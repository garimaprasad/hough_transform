function ellipse = hough_transform_ellipse(img)
[rows, cols] = size(img);
edges_count = size(find(img(2:end-1,2:end-1)==255),1);
edge_coordinates = find_edges(img);
min_a=10;
min_votes=120;
max_b=sqrt(rows^2+cols^2)/2;
acc=zeros(max_b,1);
eps=0.001;
ellipse=[];
detect_ellipse=zeros(rows, cols);
for i= 1:edges_count
    for j= edges_count:-1:i+1
        x1=edge_coordinates(i,1);
        y1=edge_coordinates(i,2);
        
        x2=edge_coordinates(j,1);
        y2=edge_coordinates(j,2);
        if(x1>0 && y1>0 && x2>0 && y2>0)
            dist=distance(x1,y1,x2,y2);
            if dist >= 2*min_a 
                x0 = (x1 + x2)/2;
                y0 = (y1 + y2)/2;
                a = dist/2;
                alpha = atan2((x2-x1),(y2-y1));
                acc=zeros(max_b,1);
                % use matrix
                if alpha ~= 0 
                    continue;
                end
                for k= 1: edges_count
                    if(k == i || k == j)
                        continue;
                    end
                    x = edge_coordinates(k,1);
                    y = edge_coordinates(k,2);
                    dist1 = distance(x0,y0,x,y);
                    if dist1 >= a
                        continue;
                    end
                    f1 = distance(x, y, x1, y1);
                    cos_tau = (a^2 + dist1^2 - f1^2)/(eps+ 2*a*dist1);
                    b = sqrt(abs(a^2 * dist1^2 * (1-cos_tau^2)/(eps+ a^2 - dist1^2 * cos_tau^2)));
                    b = ceil(b+eps);
                    if b > 0 && b <= max_b
                        acc(b)=acc(b)+1;
                    end 
                end
                [value, index]=max(acc);
                if value >= min_votes
                    % ellipse detected, store the values for ellipse
                    ellipse = [ellipse; x0 y0 a index alpha value];
                end
            end
        end
    end
    % find the best fit ellipse for a given first point (x1,y1)
    if(~isempty(ellipse))
        [~,ind]=max(ellipse(:,6));
        b_x0=ellipse(ind,1);
        b_y0=ellipse(ind,2);
        b_a=ellipse(ind,3);
        b_b=ellipse(ind,4);
        b_alpha=ellipse(ind,5);
        [edge_coordinates, img, detect_ellipse]=remove_ellipse_pixels(edge_coordinates, b_x0, b_y0, b_a, b_b, img, detect_ellipse);              
        ellipse=[];
    end
end

figure;
super_impose=imfuse(detect_ellipse, img);
imshow(super_impose);
end

function d = distance(x1, y1, x2, y2)
    d=sqrt((x1-x2)^2 + (y1-y2)^2);
end

function coordinates = find_edges(img)
[x, y] = find(img(2:end-1,2:end-1)==255);
coordinates = [x y];
end

function [edge_coordinates, img, ellipses] = remove_ellipse_pixels(edge_coordinates, x0,y0,a,b,img, ellipses)
[rows, cols] = size(img);
eps=0.05;
for i=1: rows
    for j=1:cols
        val(i,j) = (i-x0)^2/b^2 + (j-y0)^2/a^2 ;
        val(i,j) = val(i,j)>=1-eps && val(i,j)<=1+eps;
    end
end
[x, y] = find(val==1);
coordinates = [x y];
for i =1:length(coordinates)
    for j=1:length(edge_coordinates)
        if coordinates(i,1) == edge_coordinates(j,1) && coordinates(i,2) == edge_coordinates(j,2)
            edge_coordinates(j,:) = 0;
        end
    end
end
% create images with cumulative ellipses
ellipses=val+ellipses;
end