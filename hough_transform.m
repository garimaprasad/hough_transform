function [accumulator, theta, rh] = hough_transform(img)
[row,col]= size(img);
theta= (-90:1:90);
maxRho= sqrt(power(row-1,2)+ power(col-1,2));
rh = (-maxRho:1:maxRho);     
accumulator= zeros(numel(rh),numel(theta));

for i= 2:row-1
    for j= 2: col-1
        if img(i,j)==1
            for t=numel(theta):-1:1
                rho= j*cos(theta(t)*pi/180)+ i*sin(theta(t)*pi/180);
                r= floor((round(rho)+maxRho))+1;
                accumulator(r,t) = accumulator(r,t)+1;
            end
        end
    end
end
end