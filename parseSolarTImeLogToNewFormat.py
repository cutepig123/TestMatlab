import os,sys

fp =open(sys.argv[1],'r')
Items={}		# One item in new timelog
for line in fp.readlines():
	line=line.strip()
	if len(line)==0:continue
	
	arr =line.split(' ')
	if len(arr)<3: continue
	if len(arr[0])<2: continue:
	thread =arr[1:-1]
	name=arr[1]
	time=arr[-1]
	assert(arr[2]=='Begin' or arr[2]=='End')
	key ='%s %s'%(thread,name)
		
	if not Items.has_key(key):
		Items[key]=[]
	Items[key].append(time)
	
		
fp.close()

print Items