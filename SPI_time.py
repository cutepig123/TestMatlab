import os,sys

def extractTime(line, str):
	s= str
	tbegin=0
	p1= line.find(s)
	if p1>=0:
		tbegin =float( line[ (p1+len(s)) :]
	return tbegin
	
def extractTimeDiff(file):
	tbegin=0
	tend=0
	for line in open(file,'r').readlines():
		tbegin =extractTime(line, 'Begin SPI Insp,')
		tend =extractTime(line, 'End SPI Insp,')
	assert(tbegin>0)
	assert(tend>0)
	return tend -tbegin
	
RootFdr=r'C:\wineagle\log\AutoRpt_1'
for fdrname in os.listdir(RootFdr):
	fpath = '%s\\%s\\TimeLog(MainThread).csv'%(RootFdr,fdrname)
	print fpath
	if os.path.isfile(fpath):
		print extractTimeDiff(fpath)
		