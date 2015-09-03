import matplotlib.pyplot as plt
import numpy as np
import copy

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
	if(len(Data2)):
		avgH = sum(Data2)/len(Data2)
	
	# range
	#Data2.sort()
	#rrange = Data2[len(Data2)*9/10] - Data2[len(Data2)*1/10]
	
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
	plt.hold(True)
	plt.grid()
	
	i=0
	for data in datas:
		x = [0.001*i*26 for i in range(len(data))]
		plt.plot(x, data)
		ax=plt.axis()
		i=i+1
		
	# avgH
	data = datas[0]
	avgH=0
	Data2 = []
	for i in data:
		if i>0.01 or i<-0.01:
			Data2.append( i )
	avgH = sum(Data2)/len(Data2)
	
	# range
	minN=100000
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
	#print ranges
	#rRange00 = ranges[-1] - ranges[0]
	rRange01 = ranges[len(ranges)*9/10] - ranges[len(ranges)*1/10]
	
	#plot
	
	plt.axis([ax[1],ax[0], avgH+60,avgH-60])	#flip x,y
	plt.xlabel('x(mm)')
	plt.ylabel('z(um)')
	#plt.title('%s range %d(0.0) %d(0.1)'%(label_, rRange00, rRange01))
	plt.title('%s (range %d)'%(label_, rRange01))
	#plt.legend()
	
	fig = plt.gcf()
	fig.set_size_inches([15,18])
	
	
	