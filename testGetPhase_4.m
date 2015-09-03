paths='C:\CamLoopTestResult\20141204'
pathD='C:\CamLoopTestResult\20141204Result2'

cd D:\Octave3.6.4_gcc4.6.2
mkdir(pathD)
close all,clc
SpixS={};
for camid=0:5
	cam=sprintf('Cam%d',camid)
	D = dir([paths '\' cam '*.bmp']);

	% Engine
	S = [D(:).datenum].'; % you may want to eliminate . and .. first.
	[S,S] = sort(S);
	S = {D(S).name} % Cell array of names in order by datenum. 
	for i=1:length(S)
		S{i} =[paths '\' S{i}];
	end

	if camid==0
		CZY= [160   367   480];
		HWy=[50 10 50];
	elseif camid==1
		CZY= [160   346   480];
		HWy=[50 10 50];
	elseif camid==2
		CZY= [160   248   420];
		HWy=[50 10 50];
	elseif camid==3
		CZY= [160   369   480];
		HWy=[50 10 50];
	elseif camid==4
		CZY= [160   356   480];
		HWy=[50 10 50];
	elseif camid==5
		CZY= [160   247   420];
		HWy=[50 10 50];
	end
	
	Spix= GetPhaseShift_withRef_4(S,1,[pathD '\' cam '.txt'],CZY,HWy);

    SpixS{camid+1} =Spix;
	% thermalLG20141221: 1st run, camera in old framework
	% thermalLG_Test1: there are 6 sub folders, camera in test jig
	% thermalLG_Test1\all: camera in new framework
end

for i=1:6
    if i<4
        SpixS{i} =SpixS{i}.*27;
    else
        SpixS{i} =-SpixS{i}.*27;
    end
end


close all
h=figure
set(h,'Position',[0 0 1000 1000])
for i=1:6
    subplot(4,3,i);
    plot(SpixS{i})
	title(sprintf('Z level of cam %d',i-1))
	xlabel('time(min)')
	ylabel('z(um)')
	if i==1
		l=legend('Regin 1','Regin 2','Regin 3')
	end
	%set(l,'Position',[0 0 0.2 0.2])
	grid on
	axis tight
	ylim([-30 30])
	
end

for i=1:3
    subplot(4,3,6+i);
	
	n1=size(SpixS{i},1);
	n2=size(SpixS{i+3},1);
	n=min(n1,n2);
	diff=SpixS{i+3}(1:n,:) -SpixS{i}(1:n,:);
    plot(diff)
	title(sprintf('thickness of pair %d',i-1))
	xlabel('time(min)')
	ylabel('z(um)')
	%l=legend('Regin 1','Regin 2','Regin 3')
	%set(l,'Position',[0 0 0.2 0.2])
	grid on
	axis tight
	ylim([-30 30])
end


for i=1:3
    subplot(4,3,9+i);
	
	n1=size(SpixS{i},1);
	n2=size(SpixS{i+3},1);
	n=min(n1,n2);
	diff=SpixS{i+3}(1:n,:) -SpixS{i}(1:n,:);
	
	for k=1:3
        if k~=2
            diff(:,k) =diff(:,k)-diff(:,2);
        end
    end
    diff(:,2)=0;
	
    plot(diff)
	title(sprintf('thickness of pair %d (after compensation)',i-1))
	xlabel('time(min)')
	ylabel('z(um)')
	%l=legend('Regin 1','Regin 2','Regin 3')
	%set(l,'Position',[0 0 0.2 0.2])
	grid on
	axis tight
	ylim([-30 30])
end

set(gcf,'color',[1 1 1])
saveas(h,[pathD '\Data'],'png')
print(h,[pathD '\Data_.png'],'-dpng','-S2100,2100')

Pos=get(h,'Position');
Grab = getframe(gcf,Pos);
imwrite(Grab.cdata, [pathD '\_Data.png']);

save [pathD '\Data.mat'];