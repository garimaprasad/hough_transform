function  main(image1, image2)
%edge detection using Sobel operator
 im=imread(image2); 
 im1=imread(image1);
% gray_img = rgb2gray(im);
% imgLine=edge(gray_img,'canny');
%imwrite(img,'Thin.jpg');


imgEllipse=sobelOp(image1);
imgLine=sobelOp(image2);
figure(1);
imshow(imgLine);
 % hough transform for line

[H, theta, rho] = hough_transform(imgLine);
 
 % Display the transform
figure(2); 
imshow(imadjust(mat2gray(H)), [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);

% Find the peaks in the Hough transform matrix H
[c,r]= hough_Peaks(H);

% Superimpose the location of the peaks onto the transform display
x = theta(c)
y = rho(r)
plot(x, y, 's', 'color', 'black');


% Create a plot that superimposes the lines onto the original image
[row,col]=size(im);
figure(3); 
imshow(im); 
hold on;
xy=[];
for k = 1:length(x)
    for xx=1:col
        slope=-(1/tan(x(k)*pi/180));
        c= y(k)/sin(x(k)*pi/180);
        yy= xx*slope+c;
        xy=[xy;xx yy];
    end
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');
    xy=[];
end

%ellipse detection
figure(4);
imshow(imgEllipse);
output= hough_elipse(imgEllipse);
figure(5); 
imshow(im1); 
hold on;
[yaxis,xaxis]= find(output==1);
plot(xaxis, yaxis, 's', 'color', 'red');
 
end
 