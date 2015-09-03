#This program is used to add a header file to a list of cpp files
#it firstly check whether the file is already included
#if not, then it add to the file as the 2nd includes (because tjhe 1st one can be StdAfx.h)

FIleList="in.txt"
StrFind="#include	<itf_insp_thread_para.h>"
	
def ChkAndUpdate(file):	
	print file,
	fp2=open(file,'r')
	cont =fp2.read()
	fp2.close()
	if cont.lower().find(StrFind)>=0:
		print "No change!"
		return
	p1 =cont.find('#include')
	assert( p1>=0)
	p2 =cont.find('\n',p1)
	assert( p2>=0)
	p2 =p2+1
	
	cont2 ='%s\n%s\n%s'%(cont[:p2],StrFind,cont[p2:])
	fp =open('%s'%file,'w')
	fp.write(cont2)
	fp.close()
	print "Updated!"
	
for file in open(FIleList,'r').readlines():
	file =file.strip()
	ChkAndUpdate(file)
	