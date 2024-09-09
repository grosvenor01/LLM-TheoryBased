with open("C:/Users/abdo7/OneDrive/Bureau/dataseting/dialogues_text.txt" , encoding="utf-8") as file:
    text = file.read()
text = text.replace("__eou__","\n").replace(","," ").replace(".","")
lines = text.splitlines() 
lines = [line.strip() for line in lines if line.strip() != '']
pairs = []
for i in range(0 , len(lines)-1 , 2):
    pairs.append([lines[i] , lines[i+1]])

with open("C:/Users/abdo7/OneDrive/Bureau/dataseting/dataset.csv" , "w" , encoding="utf-8") as data:
    for i in range(0,len(pairs),2):
        data.write(pairs[i][0]+" , "+pairs[i][1]+"\n")