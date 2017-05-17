
cnt=1;
for camera =1:3
    for num=751:2000
        num;
        for person=1:3
            if  ~isempty(actor3D{person}{num})   
                pool3D(:,:,cnt)= actor3D{person}{num};
                pool2D(:,:,cnt)= actor2D{person}{num}{camera};
                cnt=cnt+1;
            end
        end
    end
end

for k=1:size(pool3D,3)
    pool_3D(k,:)=my_normalize_3d_pose(pool3D(:,:,k));
    pool_2D(k,:)=my_normalize_2d_pose(pool2D(:,:,k));
end

cat_2D_pose= cat(1, pool_2D ,s1_s9_2d_n);
cat_3D_pose= cat(1, pool_3D ,s1_s9_3d );

pred=  pool2D(:,:,1);
jp= pool3D(:,:,1);
[j_p] = NN_pose(cat_2D_pose,cat_3D_pose,pred);

jp
j_p
