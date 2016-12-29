function [gmag,gdir]= edgeOp(img,Sx,Sy)
I = imread(img);
G= rgb2gray(I);
G = double(G);
gx= findgx(Sx,G);
gy= findgy(Sy,G);
gmag= sqrt(power(gx,2) + power(gy,2));
gdir= atan2(gy,gx);

end

function gx= findgx(Sx,G)
[row,col]= size(G);
G(row+1,col+1)=0;
G(row+2,col+2)=0;
gx= zeros(row,col);
maskSize= size(Sx,1);

for i= 1:row
    for j= 1: col
        mul_mat = G(i:i+maskSize-1,j:j+maskSize-1) .* Sx;
        gx(i,j) = sum(sum(mul_mat));
    end
end

end

function gy= findgy(Sy,G)
[row,col]= size(G);
G(row+1,col+1)=0;
G(row+2,col+2)=0;
gy= zeros(row,col);
maskSize= size(Sy,1);
for i= 1:row
    for j= 1: col
        mul_mat = G(i:i+maskSize-1,j:j+maskSize-1) .* Sy;
        gy(i,j) = sum(sum(mul_mat));
    end
end

end
