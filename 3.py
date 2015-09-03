import os,sys

def getValue(line):
	s='<ptyVal>'
	p1 = line.find(s)
	assert(p1>0)
	p1 = p1+len(s)
	
	s='</ptyVal>'
	p2 = line.find(s,p1)
	assert(p2>0)
	
	value = line[p1:p2]
	
	return value
	
def GetPtyValue(conts, name):
	s='<pty name="%s">'%name
	p1=conts.find(s)
	AutoRpt_Path = ''
	if (p1>0):
		AutoRpt_Path = getValue(conts[p1:])
	
def ProcessCase(folder)
	#// parse result.xml
	file=os.path.join(folder, 'result.xml')
	cont = ''.join(open(file,'r').readlines())
	V = [GetPtyValue(cont,'MaxSawMarkDepth'), GetPtyValue(cont,'MaxSawMarkPosX'), GetPtyValue(cont,'MaxSawMarkPosY'), GetPtyValue(cont,'MaxSawMarkCamID')
	
	#
	camId = V[3]
	#file = "%s\\pair%d\\Thick\\ReduceBufferEx.txt"%( folder, camId )
	#cont = ''.join(open(file,'r').readlines())
	#cont = 
	
	file = "%s\\pair%d\\InspSinglePair.txt"%( folder, camId )
	for line in open(file,'r').readlines():
		if line.startswith('LineProfilMaxX = ['):
			X = 