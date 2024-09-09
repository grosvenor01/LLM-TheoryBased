import sentencepiece as spm
import torch 
from django.http import HttpResponse
from .externals import BigramLanguageModel 
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView
from rest_framework.response import Response

sp = spm.SentencePieceProcessor(model_file='C:/Users/abdo7/OneDrive/Bureau/chatbot/LLM-TheoryBased/venv/backendbot/m.model')
model = BigramLanguageModel()
model.load_state_dict(torch.load('../backendbot/bigram_model.pth' , map_location=torch.device('cpu')))

class botview(APIView):
    @csrf_exempt
    def post(self , request):
        content  = request.data["content"]
        coded_content =  [sp.encode(content)]
        converted = torch.tensor(coded_content)
        print("arrived")
        output = sp.decode(model.generate(converted, max_number_tokens=200)[0].tolist())
        return Response({"output":output},status=200)