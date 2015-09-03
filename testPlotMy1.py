import matplotlib.pyplot as plt
import matplotlib.patches as patches
import time

# build a rectangle in axes coords
left, width = .25, .5
bottom, height = .25, .5
right = left + width
top = bottom + height

fig = plt.figure(num=None, figsize=(8, 6), dpi=80, facecolor='w', edgecolor='k')
ax = fig.add_axes([0,0,1,1])

for i in range(10):
	text ='%d'%i
	print text
	pos =left
	if i%2==0:
		pos =right
	ax.text(pos, 0.5*(bottom+top), text,
			horizontalalignment='left',
			verticalalignment='top',
			fontsize=20, color='red',
			transform=ax.transAxes)
	plt.ion()     # turns on interactive mode
	plt.show()
	#print "doing something else now"
	#raw_input('Press Enter to continue...')
	time.sleep(1)