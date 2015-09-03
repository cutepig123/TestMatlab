import os,sys
import matplotlib.pyplot as plt
import numpy as np
import copy

#draw graphics for repeatability
class Data:
	def __init__(self,content,lineNum,value):
		self.content = content
		self.lineNum = lineNum
		self.value = value
		
class Item:
	def __init__(self,name):
		self.name_ = name
		self.data_ = []
		
	def processLine(self,line,lineNum):
		if line.find('<td>%s</td>'%self.name_)>=0:
			s = '<td name="security" onclick="open_Max_win(this)">'
			p1 = line.find(s)
			if not (p1>0): 
				print line
			else:
				s1='</td><td>'
				p2 = line.find(s1,p1+len(s))
				assert(p2>0)
				p3 = line.find(s1,p2+len(s1))
				assert(p3>0)
				text = line[(p2+len(s1)):p3]
				val = float(text)
				data = Data(line,lineNum,val)
				self.data_.append(data)
			return True
		else:
			return False
	def getName(self):
		return self.name_;
		
	def getResult(self):
		return [x.value for x in self.data_];
		
items=['Average Thickness','Min Thickness','Max Thickness','TTV','NPointTTV','Warpage','BOW','Roughness','MaxSawMarkDepth','MaxSawMarkDepth0','MaxSawMarkDepth1','DenseSawPartitionNum']
Items=[Item(x) for x in items]
folder = sys.argv[1]
print 'Load data...'
lines =open('%s\\out_repeatibility.htm'%folder,'r').readlines()
for i in range(len(lines)):
	print '.',
	for item in Items:
		if item.processLine(lines[i],i):
			break
			
print
print 'Processing...'
for item in Items:			
	#print item.getName(), len(item.getResult()), item.getResult()
	title = item.getName()
	data = item.getResult()
	print title
	
	plt.close('all')
	plt.hold(True)
	plt.grid()
	#x = range(len(data))
	#plt.plot(x, data1, label='Beltlveling')
	plt.plot(data,'*')
	plt.title(title)
	
	plt.savefig('%s\\rep_%s.png'%(folder,title))
	