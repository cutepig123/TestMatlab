import matplotlib.pyplot as plt
import numpy as np
import copy
import os,sys


#for belt leveling
def PlotAndSave_ForBeltLeveling(data1):
	plt.close('all')
	plt.hold(True)
	plt.grid()
	x = range(len(data))
	plt.plot(x, data1, label='Beltlveling')
	
	ax=plt.axis()
	print ax
	#plt.axis([ax[1],ax[0], ax[2],ax[3]])	#flip y
	
	plt.xlabel('x(mm)')
	plt.ylabel('z(um)') 
	plt.title('%s'%('Beltlveling'))
	plt.legend()
#for saw mark
def PlotAndSave_ForSawMark(data1, x_center_um, halfZRange,fileBase, label_):
	#inverse z
	#data = [-i for i in data]
	
	#fill invalid pts
	data = copy.deepcopy(data1)
	for i in range(len(data)):
		if  i>0 and abs(data[i])<0.01:
			data[i] = data[i-1]
	#
	plt.close('all')
	plt.hold(True)
	plt.grid()
	
	x_leftmost_um = x_center_um - 26.*len(data)/2
	x = [0.001*(i*26+x_leftmost_um) for i in range(len(data))]
	plt.plot(x, data, label=label_)
	plt.plot(x, data1, '+')
	ax=plt.axis()
		
	# avgH
	avgH=0
	Data2 = []
	for i in data1:
		if abs(i)>0.01:
			Data2.append( i )
	avgH = sum(Data2)/len(Data2)
	
	# range
	Data2.sort()
	rrange = Data2[len(Data2)*9/10] - Data2[len(Data2)*1/10]
	
	halfZRange = abs(halfZRange)
	plt.axis([ax[1],ax[0], avgH+halfZRange,avgH-halfZRange])	#flip x,y
	plt.xlabel('x(mm)')
	plt.ylabel('z(um)') 
	plt.title('%s'%(label_))
	
	fig = plt.gcf()
	fig.set_size_inches([5,5])
	
	plt.savefig('%s\\%s.png'%(fileBase,label_))

#for chk belt	
def Plot_ForBelt(datas,label_):
	plt.close('all')
	plt.hold(True)
	plt.grid()
	
	i=0
	for data in datas:
		x = [0.001*i*26 for i in range(len(data))]
		plt.plot(x, data)
		ax=plt.axis()
		i=i+1
	
	#print label_,datas
	
	# avgH
	data = datas[0]
	avgH=0
	Data2 = []
	for i in data:
		if i>0.01 or i<-0.01:
			Data2.append( i )
	avgH = sum(Data2)/(0.001+len(Data2))
	
	# range
	minN=1000000
	for data in datas:
		if minN > len(data):
			minN = len(data)
	#print 'minN', minN
	
	MaxData = copy.deepcopy(data)
	MinData = copy.deepcopy(data)
	
	for data in datas:
		for i in range(minN):
			if abs(data[i])>0.01:
				if abs(MaxData[i])>0.01 and MaxData[i]<data[i]:
					MaxData[i] = data[i]
				if abs(MinData[i])>0.01 and MinData[i]>data[i]:
					MinData[i] = data[i]
			else:
				MaxData[i] = MinData[i] = 0
				
	ranges = []
	for i in range(minN):
		if abs(MaxData[i])>0.01 and abs(MinData[i])>0.01:
			ranges.append(MaxData[i]-MinData[i])
	ranges.sort()
	#print 'ranges',ranges
	rRange01=0
	if len(ranges)>0:
		rRange01 = ranges[(int)(len(ranges)*95.0/100)]
	
	#plot
	
	plt.axis([ax[1],ax[0], avgH+60,avgH-60])	#flip x,y
	plt.xlabel('x(mm)')
	plt.ylabel('z(um)')
	plt.title('%s (range %d)'%(label_, rRange01))
	plt.legend(range(0,len(datas)))
	
	fig = plt.gcf()
	fig.set_size_inches([15,8])
	
	#print 'rRange01', rRange01
	return rRange01
	
#load cases
A0=[]
A1=[]
A2=[]
root='c:\\WinEagle\\temp\\LogProfile'
if len(sys.argv)>1:
	root=sys.argv[1]
	
for i in range(0,100):
	fname = '%s\\%d\\log.py'%(root,i)
	if not os.path.isfile(fname):
		break
	print 'Load',fname
	a0=None
	a1=None
	a2=None
	for line in open(fname,'r').readlines():
		exec line
	#print 'a0',a0
	#print 'a1',a1
	#print 'a2',a2
	A0.append(a0)
	A1.append(a1)
	A2.append(a2)
	
#print 'A0',A0
#print 'A1',A1
#print 'A2',A2	

if (len(A0)<2):
	print "ERROR: no enough profile logging found!"
	assert(0)

Warn = "Find %d Logging."%( len(A0) )
if len(A0)<5:
	Warn = Warn + 'Suggest to inspect more than 5 times!'
	
print 'Plot Cam0'
RAN0=Plot_ForBelt(A0,"cam0")
plt.savefig('%s\\cam0.png'%(root))
print 'Plot Cam1'
RAN1=Plot_ForBelt(A1,"cam1")
plt.savefig('%s\\cam1.png'%(root))
print 'Plot Cam2'
RAN2=Plot_ForBelt(A2,"cam2")
plt.savefig('%s\\cam2.png'%(root))
RAN = [RAN0, RAN1, RAN2]
#print 'MAXRAN',RAN
MaxRan = max(RAN)
Sts = "Max Range %d, "%MaxRan

if MaxRan>50:
	Sts = Sts + 'Vibration checking fail!'
else:
	Sts = Sts + 'Vibration checking succeed!'
	
str='<table border=1><tr><td><font color=red>1.%s<br>2.%s </font></td></tr><tr><td><img src=cam0.png></td></tr><tr><td><img src=cam1.png></td></tr><tr><td><img src=cam2.png></td></tr></table>'%(Warn,Sts)
hfile='%s\\ChkBeltVib.htm'%(root)
print 'Generate file', hfile
open(hfile,'w').writelines([str])
print 'Lunch file', hfile
os.system('start explorer %s'%hfile)

