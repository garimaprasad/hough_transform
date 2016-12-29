function [c,r] = hough_Peaks(H)
threshold= ceil(0.2*max(H(:)));
r = [];
c = [];
[max_col, row_num] = max(H);
for i = 1:size(max_col, 2)
   if max_col(i) > threshold
       c(end + 1) = i;
       r(end + 1) = row_num(i);
   end
end
end

