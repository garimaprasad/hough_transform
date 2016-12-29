function out= hough_elipse_modified(image)
% figure(1)
% imshow(image);
%image=imread(image);
%imshow(image);
%image=image./255;
[row,col]= size(image);
% image(:,799)=0;
out= zeros(row,col);
[xAxis,pix,maxR]=findPix(image(2:end-1,2:end-1));
 img= image;
 output= zeros(row,col);
 i1=1;
while i1~= xAxis
   [parameters,image,output]=findEllipse(pix,xAxis,maxR,image,output,i1); 
   if ~isempty(parameters)
        figure(1); 
        imshow(img); 
        hold on;
        [yaxis,xaxis]= find(output==1);
        plot(xaxis, yaxis, 's', 'color', 'red');       
   display(parameters);
   [xAxis,pix,maxR]=findPix(image(2:end-1,2:end-1));
   imshow(image);
   i1=1;
   else
       i1=i1+1;
   end
end
end
 
function [p,image,output]= findEllipse(pix,xAxis,maxR,image,output,i1)
 %maxR=maxR;
 [row,col]= size(image);
 H=zeros(1,maxR/2);
 B=zeros(1,maxR/2);
 minA=10;
 minVotes=120;
 p=[];
 param=[];
 for i2= 2:xAxis
            x1=pix(i1,1);
            x2=pix(i2,1);
            y1=pix(i1,2);
            y2=pix(i2,2);
            if x1<x2
                d1 = sqrt(power((x1-x2),2)+ power((y1-y2),2));
                if d1>=2*minA
                     x0 = (x1 + x2)/2;
                     y0 = (y1 + y2)/2;
                     a = d1/2;
                     alpha = atan2((y2 - y1),(x2 - x1));
                     if alpha~=0
                         continue;
                     end
                     H=H*0;
                     B=B*0;                        
                     for i = 1:xAxis  
                         if i==i1 || i==i2 
                             continue;
                         end
                         x=pix(i,1);
                         y=pix(i,2);
                         d= sqrt(power((x-x0),2)+ power((y-y0),2));
                         if d<=a
                             f= sqrt(power((x-x2),2)+ power((y-y2),2));
                             cost = (a^2 + d^2 - f^2) / (2 * a * d);
                             sin2t = 1 - cost^2;
                             b = ceil(sqrt((a^2 * d^2 * sin2t) /(a^2 - d^2 * cost^2)));
                             %br=floor(b);
                             if b > 0 && b <= length(H)
                               H(b)=H(b)+1;
                               %B(br)=b;
                             end
                            
                         end
                     end
                    [vote,bmax] = max(H);
                    if vote > minVotes
                        %bm=B(bmax);
                        param = [param;x0 y0 a bmax alpha vote];
                    end                 
                end                  
            end
            
 end
if ~isempty(param)
    [~, ind] = max(param(:,6));
    p= param(ind,:);
    for i= 1:row
        for j= 1: col 
            val=makeEllipse(p(1), p(2) ,p(3) ,p(4),i,j);
            if val ==1
                output(i,j)=1;
                image(i,j)=0;
            end
        end
    end        
    param=[];
end       
end
 
function [xAxis,pix,maxR]=findPix(image)
[row,col]= size(image);
pix=[];
[yaxis,xaxis]= find(image==1);
xAxis= size(xaxis,1);
maxR= ceil(sqrt(power(row,2)+ power(col,2)));
%all edge elements (x1,y1)
pix=[xaxis yaxis];
end
 
 
function [val] = makeEllipse(x0, y0 ,a ,b,i,j)
val= ((((j-x0)^2)/(a^2)) + (((i-y0)^2)/(b^2))) ;
eps=0.05;
if val <=1-eps || val>=1+eps
    val=0;
else
    val=1;
end
end
