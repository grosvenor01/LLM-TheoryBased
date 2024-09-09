import torch 

batch_size = 8 #number of inputs processed in the same time
block_size = 16 #length of the block
num_iter = 25000
learning_rate = 1e-3
device = 'cuda' if torch.cuda.is_available() else 'cpu'
n_embd = 64 # size of the embeddings for example each token represented with 64 embedding
n_head = 4 # number of heads that works in parallel in multi headed
num_layers = 10
eval_interval = 100 #print losess each 100 iteration
eval_iters = 200
vocab_size = 3000
torch.manual_seed(1337)

import torch.nn as nn
from torch.nn import functional as F
class Head(nn.Module):
  # constrcutor to define the linear function
  def __init__(self , head_size):
    super().__init__()
    self.key = nn.Linear(n_embd,head_size,bias=False)
    self.query = nn.Linear(n_embd,head_size,bias=False)
    self.value = nn.Linear(n_embd,head_size,bias=False)
    self.register_buffer('tril',torch.tril(torch.ones(block_size,block_size)))#the masking layer for non ecovered tokens
    self.dropout = nn.Dropout(0.0)

  #like zipping the pipeline in the multiheaded in one method
  def forward(self , x):
    B,T,C  = x.shape #storing inpute batch size , the sequance length (token number, carecters in our case) , embedding size
    k= self.key(x)
    q= self.query(x)
    # calculate attention scores ("affinities")
    wei = q @ k.transpose(-2,-1) * C**-0.5 # a dot product followed by a scaling
    wei = wei.masked_fill(self.tril[:T, :T] == 0, float('-inf')) #mask the toen we idn't descover yet
    wei = F.softmax(wei, dim=-1)
    v = self.value(x)
    out = wei @ v
    return out

class MultiHeadedAttention(nn.Module):
    def __init__(self , num_heads , head_size):
      super().__init__()
      self.heads = nn.ModuleList([Head(head_size) for _ in range(n_head)])
      self.proj = nn.Linear(n_embd, n_embd)
      self.dropout = nn.Dropout(0.0)

    #concatintae the result output heads matrix
    def forward(self, x):
        out = torch.cat([h(x) for h in self.heads], dim=-1)
        out = self.dropout(self.proj(out))
        return out

class FeedForward(nn.Module):
  def __init__(self , n_embd):
    super().__init__()
    #creating a linear layer followed by a no linearity (using RELU activation)
    self.net = nn.Sequential(
            nn.Linear(n_embd, 4 * n_embd),
            nn.ReLU(),
            nn.Linear(4 * n_embd, n_embd),
            nn.Dropout(0.0),
        )
  def forward(self, x):
        return self.net(x)


class Block(nn.Module):
    # in the block we pass the input into a normalization layer and also the output heads
    # first for the residual connection + the feature normalization

    def __init__(self, n_embd, n_head):
        # n_embd: embedding dimension, n_head: the number of heads we'd like
        super().__init__()
        head_size = n_embd // n_head
        self.sa = MultiHeadedAttention(n_head, head_size)
        self.ffwd = FeedForward(n_embd)
        self.ln1 = nn.LayerNorm(n_embd)
        self.ln2 = nn.LayerNorm(n_embd)

    def forward(self, x):
        x = x + self.sa(self.ln1(x))
        x = x + self.ffwd(self.ln2(x))
        return x

class BigramLanguageModel(nn.Module):
  def __init__(self):
    super().__init__()
    self.embeddings_table = nn.Embedding(vocab_size,n_embd)
    self.position_embeddings = nn.Embedding(block_size,n_embd) #position representation (token 2 is the first , 1 is the second .. etc)
    self.blocks = nn.Sequential(*[Block(n_embd, n_head=n_head) for _ in range(num_layers)]) #number of encoder blocks
    self.LayerN = nn.LayerNorm(n_embd)
    self.lm_head = nn.Linear(n_embd , vocab_size)
  def forward(self , idx, targets=None): #generate the logits and the loss in case of training (forward propagtion)
    B , T = idx.shape #idx -> input data
    token_embd = self.embeddings_table(idx)
    pos_embd = self.position_embeddings(torch.arange(T, device=device))
    x = token_embd + pos_embd
    x = self.blocks(x)
    x = self.LayerN(x)
    logits = self.lm_head(x) # (B,T,vocab_size)

    if targets is None:
        loss = None
    else:
        B, T, C = logits.shape
        logits = logits.view(B*T, C)
        targets = targets.view(B*T)
        loss = F.cross_entropy(logits, targets)

    return logits, loss
  def generate(self , idx , max_number_tokens):
    for _ in range(max_number_tokens):
      idx_cond = idx[:, -block_size:]
      logits, loss = self(idx_cond)
      logits = logits[:, -1, :]
      probs = F.softmax(logits, dim=-1)
      idx_next = torch.multinomial(probs, num_samples=1)
      idx = torch.cat((idx, idx_next), dim=1) # icluding the new token into the new one
    return idx

