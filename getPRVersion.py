import sys
for line in open(sys.argv[1],'r').readlines():
	if 'ITF_PR_VERSION_NO' in line and line.strip()[0]=='#':
		a =line.split('\"')
		print a[1].strip()
		break