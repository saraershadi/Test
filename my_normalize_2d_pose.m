
function temp=my_normalize_2d_pose(pred)

temp = zeros(1,28);
temp_root = 0.5 * (pred(9,:) + pred(12,:));
for a = 1:14
    temp(1,a*2-1) = pred(a,1) - temp_root(1);
    temp(1,a*2) = pred(a,2) - temp_root(2);
    y_c(a) = temp(1,2*a);
end
scale = max(y_c)-min(y_c);
temp = temp / scale;


