clear,clc,close all
%file='time.log'
file='..\python\2.txt'
%file='time_test.log'
%file='superglue.log'
f=fopen(file,'r')

figure,hold on

Threads = containers.Map();
Colors =containers.Map();
Numbers =containers.Map();  %Number of plots for each task

TOTAL_time_start=-1;
TOTAL_time_end=-1;
%%% 1: AutoAssignColor (different module may have assigned same color )	2: User define color (No overlap)
ColorMode =1

if ColorMode==1
	AllColors='rgbcmyk';
else
	AllColors='cmyk';
    %AllColors='rgby';
	%Colors('ConstrMergProfile Time(ms)')='r';
    Colors('ConstructProfile Time(ms)')='r'
    Colors('MergeProfile Time(ms)')='g';
    Colors('WarpY Time(ms)')='b';
	
    % Remove used color from AllColors
    v =values(Colors);
    for i =1:length(v)
        t =v(i);
        AllColors =AllColors(AllColors~=t{1});
    end
end	

%%% Whether need set start time to 0     
t0=0;
ist0set=1;

%%% 
TimeScaleFactor=1/1000;

while ~feof(f)
    s=fgets(f);
	parts1 = strread(s,'%s','delimiter',':');
    if length(parts1)<2
        continue
    end
    parts = strread(parts1{1},'%s','delimiter','\t');
    if length(parts)==0 | parts{1}(1)=='#'
        continue
    end
    if(length(parts)~=5) 
        continue
    end
    
	stid =(parts{1});
    ststart =(parts{2});
    stend =(parts{3});
    stlen =(parts{4});
    name =strtrim([parts{5}]);
	%tid =str2num(parts{1});
	tstart =str2num(parts{2})*TimeScaleFactor;
    tend =str2num(parts{3})*TimeScaleFactor;
    tlen =str2num(parts{4})*TimeScaleFactor;
	
    if ~isKey(Threads, stid)
        t =0
        t.y =length(Threads)*100;
        t.busy =0;
        Threads(stid) =t;
    end
    
    if ~isKey(Colors, name)
        id =mod(length(Colors),length(AllColors))+1;
        Colors(name) =AllColors(id);
    end
    
    if ~isKey(Numbers, name)
        Numbers(name) =0;
    end
    Numbers(name) =Numbers(name)+1;

    
    if ~ist0set
        t0 =tstart;
        ist0set=1;
    end
    
    tstart =tstart-t0;
    tend =tend-t0;
    tlen =tlen-t0;
    
    
    y =Threads(stid).y;
    plot([tstart tstart tend tstart],[y+20 y-20 y y+20],Colors(name))
    
    if( TOTAL_time_start<0 )
        TOTAL_time_start=tstart;
    else
        TOTAL_time_start=min( tstart, TOTAL_time_start);
    end
    
     if( TOTAL_time_end<0 )
        TOTAL_time_end=tstart;
    else
        TOTAL_time_end=max( tstart, tend);
     end
    
     t =Threads(stid);
     t.busy = t.busy +tend -tstart;
     Threads(stid) =t;
    %text(tstart, y,name)
end

fclose(f)

for i=1:length(Colors)
    keyss =keys(Colors);
    key=keyss{i};
    t =Colors(key);
    n =Numbers(key);
    fprintf('name %s color %s NUmbers %d\n', key,t,n)

end
 
total_time =TOTAL_time_end -TOTAL_time_start;
for i=1:length(Threads)
    keyss =keys(Threads);
    key=keyss{i};
    t =Threads(key);
    ratio=t.busy/total_time;
    fprintf('Thread ID %s y %d busy ratio(not accurate since including overlapped) %f\n', key, t.y, ratio);
end

zoom('on');
zM = zoom(gcf);
set(zM, 'ActionPostCallback', ...
    @(figh, eventobj) set(eventobj.Axes, 'XTickLabel', ...
    sprintf('%5.3f|', get(eventobj.Axes, 'XTick'))));