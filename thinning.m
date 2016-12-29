function [flag,gmag]= thinning(gmag)
[row1,col1]= size(gmag);
row=row1-1;
col=col1-1;
I=zeros(row1,col1);
flag=0;
%for North
for j= 2: col
        for k= 1:row-1
            i= row1-k;
            if gmag(i,j)==1
                %find the 8 neighbours
                [p1,p2,p3,p4,p5,p6,p7,p8]= pointVal(gmag,i,j);
                 % templates 
               [t1,t2,t3,t4,t5,t6]=templateVal(p1,p2,p3,p4,p5,p6,p7,p8);                             
                if (p1+p2+p3+p4+p4+p6+p7+p8)<=1
                    I(i,j)=1;
                    
                elseif (t1==1 || t2==1 || t3==1 || t4==1 || t5==1 || t6==1 )
                    I(i,j)=1;
                    
                elseif p2 ==1
                    I(i,j)=1;
                    
                else
                    flag=flag+1;
                end
            end
        end
end
gmag=gmag.*I;
I=zeros(row1,col1);
%for South
for j= 2: col
        for i= 2:row
            if gmag(i,j)==1
                %find the 8 neighbours
                [p1,p2,p3,p4,p5,p6,p7,p8]= pointVal(gmag,i,j);
                 % templates 
               [t1,t2,t3,t4,t5,t6]=templateVal(p1,p2,p3,p4,p5,p6,p7,p8); 
               
                if (p1+p2+p3+p4+p4+p6+p7+p8)<=1
                    I(i,j)=1;
                    
                elseif (t1==1 || t2==1 || t3==1 || t4==1 || t5==1 || t6==1 )
                    I(i,j)=1;
                   
                elseif p7==1
                    I(i,j)=1;
                   
                else 
                    flag=flag+1;
                    
                end
            end
        end
end
gmag=gmag.*I;
I=zeros(row1,col1);
%for East
for i= 2:row
        for j= 2: col
            if gmag(i,j)==1
                %find the 8 neighbours
                [p1,p2,p3,p4,p5,p6,p7,p8]= pointVal(gmag,i,j);
                 % templates 
               [t1,t2,t3,t4,t5,t6]=templateVal(p1,p2,p3,p4,p5,p6,p7,p8);                                 
                if (p1+p2+p3+p4+p4+p6+p7+p8)<=1
                    I(i,j)=1;
                   
                elseif (t1==1 || t2==1 || t3==1 || t4==1 || t5==1 || t6==1 )
                    I(i,j)=1;
                   
                elseif p5==1
                    I(i,j)=1;
                   
                else
                    flag=flag+1;
                    
                end
            end
        end
end
gmag=gmag.*I;
I=zeros(row1,col1);
%for West   
    for i= 2:row
        for k= 1:col-1
            j= col1-k;
            if gmag(i,j)==1
             %find the 8 neighbours
                [p1,p2,p3,p4,p5,p6,p7,p8]= pointVal(gmag,i,j);
                 % templates 
               [t1,t2,t3,t4,t5,t6]=templateVal(p1,p2,p3,p4,p5,p6,p7,p8);                             
               if (p1+p2+p3+p4+p4+p6+p7+p8)<=1
                    I(i,j)=1;
                   
                elseif (t1==1 || t2==1 || t3==1 || t4==1 || t5==1 || t6==1 )
                    I(i,j)=1;
                    
                elseif p4==1
                    I(i,j)=1;
                    
                else
                   flag=flag+1;
                end
            end
        end
    end
  gmag=gmag.*I;                             

end
function [p1,p2,p3,p4,p5,p6,p7,p8]= pointVal(gmag,i,j)
                p1 = gmag(i-1, j-1);
                p2 = gmag(i-1, j);
                p3 = gmag(i-1, j+1);
                p4 = gmag(i, j-1);
                p5 = gmag(i, j+1);
                p6 = gmag(i+1, j-1);
                p7 = gmag(i+1, j);
                p8 = gmag(i+1, j+1);
end
function [t1,t2,t3,t4,t5,t6]= templateVal(p1,p2,p3,p4,p5,p6,p7,p8)
t1= (p4==0 && p5==0 && p2==1 && p7==1);
                t2= (p4==1 && p5==1 && p2==0 && p7==0);
                t3= (p4==0 && p7==0 && p6==1);
                t4= (p2==0 && p5==0 && p3==1);
                t5= (p5==0 && p7==0 && p8==1);
                t6= (p4==0 && p2==0 && p1==1);
end
