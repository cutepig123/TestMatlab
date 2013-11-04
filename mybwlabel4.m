function [BW2, same_lbl]=mybwlabel4(BW)
sz =size(BW);
BW2=uint8(BW);

cur_lbl =1;
same_lbl=zeros(1,1000);

%1st pass
for y=1:sz(1)
    for x=1:sz(2)
        if BW(y,x)>0
            
            lbl1=0;
            lbl2=0;
            bNewLbl=0;
            %follow left
            if x>1 & BW(y,x-1)>0
                BW2(y,x) =BW2(y,x-1);
                lbl1 =BW2(y,x-1);
            end
            
            %follow upper
            if y>1 & BW(y-1,x)>0
                BW2(y,x) =BW2(y-1,x);
                lbl2 =BW2(y-1,x);
            end
            
            if lbl1>0 | lbl2>0
                if lbl1>0 & lbl2>0 & lbl2~=lbl1
                    ids =[lbl1,lbl2,same_lbl(lbl1),same_lbl(lbl2)];
                    assert( min(ids)>0 )
                    ids =sort(ids);
                    for i=2:4
                     same_lbl( ids(i) ) =same_lbl(ids(1));
                    end
                end
            else
                cur_lbl =cur_lbl+1;
                BW2(y,x) =cur_lbl;
                same_lbl(cur_lbl) =cur_lbl;
                bNewLbl=1;
            end
            
            if bNewLbl
                %fprintf('y %d x %d lbl1 %d lbl2 %d bNewLbl %d cur_lbl %d\n',y,x,lbl1,lbl2,bNewLbl,cur_lbl)
                %same_lbl(1:cur_lbl)
            end
        end
    end
end

%process same_lbl
for i=2:cur_lbl
    t =same_lbl(i);
    while t~=same_lbl(t)
        assert( t >same_lbl(t) )
        t =same_lbl(t);
    end
    same_lbl(i) =t;
end

if 1
    map_same_lbl_val =zeros(1000);
    new_lbl_id=1;
    for i=2:cur_lbl
        if map_same_lbl_val( same_lbl(i) )==0
            map_same_lbl_val( same_lbl(i) ) =new_lbl_id;
            new_lbl_id =new_lbl_id+1;
        end
    end

    for i=2:cur_lbl
        same_lbl(i) =map_same_lbl_val( same_lbl(i) );
    end
end

%2nd pass
for y=1:sz(1)
    for x=1:sz(2)
        v =BW2(y,x);
        if v>0
            if same_lbl(v)>0
                BW2(y,x) =same_lbl(v);
            end
        end
    end
end
