import sys
data=[]
score = 0
while score >= 0:
    score = int(input())
    if score >= 0:
        data.append(score)

freq = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
for i in range(len(data)):
  idx = data[i]/10
  if idx>=10:
    idx=9
  freq[int(idx)]=freq[int(idx)]+1

maxfreq = max(freq)
matrix = []
for i in range(10):
    matrix.append("*"*freq[i]+"."*(maxfreq-freq[i]))
for i in range(10):
    print(format((i+1)*10, '3d')+'|'+(matrix[i]))
print

for i in range(maxfreq-1,-1,-1):
    line=""
    for j in range(10):
        line=line+matrix[j][i]
    print(line)

print("----------")
print("1234567891")
print("0000000000")
print("         0")
