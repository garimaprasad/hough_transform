function [gmag,gdir]= sobelOp(image)
Sx=[-1,0,1;-2,0,2;-1,0,1];
Sy=[1,2,1;0,0,0;-1,-2,-1]; 


[gmag,gdir]= edgeOp(image,Sx,Sy);
imwrite(gmag,'SobelMagnitude.jpg');
imwrite(gdir,'SobelDirection.jpg');

%code for scaling
min_val = min(min(gmag));
gmag=gmag-min_val;
max_val = max(max(gmag));
gmag = 255/max_val * gmag;

%code for thresholding

[gmag,gdir]=thresholding(gmag,gdir);
imwrite(gmag,'SobelThreshMag.jpg');
imwrite(gdir,'SobelThreshDir.jpg');


%code for shrink and expansion

%gmag= imageExpansion(gmag);
%imwrite(gmag,'SobelExpandMag.jpg');

%code for thinning
flag=1;
while flag>0
[flag,gmag]= thinning(gmag);
end
imwrite(gmag,'SobelThin.jpg');
end
