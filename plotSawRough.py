import matplotlib.pyplot as plt
import numpy as np
import copy
import os,sys

for fname in os.listdir(sys.argv[1]):
	fpath = '%s\\%s\\pair1\\thick\\roughness.txt'%(sys.argv[1],fname)
	print fpath
	if os.path.isfile(fpath):
		i=0
		plt.close('all')
		plt.hold(True)
		plt.grid()
		for line in open(fpath,'r').readlines():
			if i>=2: 
				datas = line.strip().split(',')
				print datas
				data = []
				for x in datas:
					if len(x):
						data.append(float(x))
				
				x = range(len(data))
				plt.plot(x, data,'-*')
			i = i+1
		imgpath = '%s\\%s.png'%(sys.argv[1],fname)
		plt.savefig(imgpath)	
		#os.system('pause')
