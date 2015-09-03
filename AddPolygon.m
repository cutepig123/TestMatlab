function main
Pts=[0 -50; 50 0;0 50;-50 0]'+100;

Sz =[100 100];
P=MASK_AddPolygonx(Pts,Sz);
imagesc(P)
%Input: 
%   Pts: 2xN matrix
%   Sz: 2x1 vector, yxx
function P =MASK_AddPolygonx(Pts, Sz)

%sort by y
%[miny, minidx]=min(Pts(2,:));
N=size(Pts,2);
%SortedPts=[Pts(:,minidx:N) Pts(:,1:(minidx-1))];

%construct edge lists
%edgelist:
% [x1 ...
% y1
% x2
% y2
edgelist=zeros(Sz(1),2);
edgelistndata=ones(1,Sz(1));
for i=1:N
    Ps=Pts(:,i);
    Pd=[];
    if i==N
        Pd=Pts(:,1);
    else
        Pd=Pts(:,i+1);
    end
    
    if Ps(2)>Pd(2)
        t=Ps; Ps=Pd; Pd=t;
    end
    
    Y=max(Ps(2),1):min(Pd(2),Sz(1));
    X=(Y-Pd(2)).*(Ps(1)-Pd(1))/(Ps(2)-Pd(2))+Pd(1);
    
    YO=Y;
    XO=max(min(X,Sz(2)),1);
    
    for j=1:length(YO)
        y=YO(j)
        idx =edgelistndata(y);
        t =edgelist(y,:);
        t2 =find(t==XO(j));
        if length(t2)==0
            assert(idx<=2)
            edgelist(y, idx)=XO(j);
            edgelistndata(y) =edgelistndata(y)+1;
        end
    end
end

%edgelistndata
edgelist=sort(edgelist,2);
P=zeros(Sz);
for i=1:Sz(1)
    tn=edgelistndata(i);
    if tn>1
        assert(tn<=3)
        if tn==3
        t=edgelist(i,:);
        assert(length(t)==2)
        x1=edgelist(i,1);
        x2=edgelist(i,2);
        P(i,x1:x2)=1;
        end
    end
end

