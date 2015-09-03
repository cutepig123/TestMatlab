import matplotlib.pyplot as plt
import numpy as np
import copy,os

def MyPlot(data1,title,fp):
	plt.close('all')
	plt.hold(True)
	plt.grid()
	X = [x[0] for x in data1]
	Y = [x[1] for x in data1]
	plt.plot(X, Y, '+',label='X')
	
	ax=plt.axis()
	print ax
	#plt.axis([ax[1],ax[0], ax[2],ax[3]])	#flip y
	
	plt.xlabel('y(pixel)')
	plt.ylabel('z(um)') 
	plt.title(title)
	fname='%s.png'%title
	plt.savefig(fname)
	fp.writelines(['<img src=%s></img>'%fname])

fp=open('1.htm'	,'w')
#x=0.000000
Cam0_X0_YZ=[  (0.000000, 84.061279),  (120.500000, 104.856941),  (241.000000, 125.486427),  (361.500000, 148.313004),  (482.000000, 172.432266), ]
MyPlot( Cam0_X0_YZ,'Cam0_X0_YZ',fp )
#x=226.000000

#x=0.000000
Cam1_X0_YZ=[  (0.000000, -142.290497),  (120.500000, -125.457413),  (241.000000, -107.122025),  (361.500000, -87.024529),  (482.000000, -66.135490), ]
MyPlot( Cam1_X0_YZ,'Cam1_X0_YZ',fp )
#x=226.000000

#x=0.000000
Cam2_X0_YZ=[  (0.000000, -76.488884),  (120.500000, -57.321281),  (241.000000, -35.109711),  (361.500000, -8.374653),  (482.000000, 22.309988), ]
MyPlot( Cam2_X0_YZ, 'Cam2_X0_YZ',fp )
#x=226.000000

#x=0.000000
Cam3_X0_YZ=[  (0.000000, -159.712906),  (120.500000, -139.494888),  (241.000000, -119.671288),  (361.500000, -98.946167),  (482.000000, -75.898567), ]
MyPlot( Cam3_X0_YZ, 'Cam3_X0_YZ',fp )
#x=226.000000

#x=0.000000
Cam4_X0_YZ=[  (0.000000, -78.859459),  (120.500000, -58.081394),  (241.000000, -35.335770),  (361.500000, -9.671449),  (482.000000, 18.008747), ]
MyPlot( Cam4_X0_YZ, 'Cam4_X0_YZ',fp )
#x=226.000000

#x=0.000000
Cam5_X0_YZ=[  (0.000000, 21.534779),  (120.500000, 47.805840),  (241.000000, 75.733215),  (361.500000, 106.307495),  (482.000000, 137.695938), ]
MyPlot( Cam5_X0_YZ, 'Cam5_X0_YZ',fp )
#x=226.000000
fp.close()
os.system('1.htm')