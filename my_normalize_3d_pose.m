
function temp=my_normalize_3d_pose(pred)

temp = zeros(1,42);
temp_root = 0.5 * (pred(9,:) + pred(12,:));
for a = 1:14
    temp(1,3*a-2) = pred(a,1) - temp_root(1);
    temp(1,3*a-1) = pred(a,2) - temp_root(2);
    temp(1,3*a) = pred(a,3) - temp_root(3);
    y_c(a) = temp(1,2*a);
end
scale = max(y_c)-min(y_c);
temp = temp / scale;




