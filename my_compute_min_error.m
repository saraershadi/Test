function matrix_index=my_compute_min_error(my_P,Z,fr)
% my_P : input , it contains the poses of detected persons in each of the
% camera views , it is a cell(1,3) and each of the cells contains some
% cells about the detected persons

% Z : output , it contains the transformed back to the first camera view poses.
% Z{1} cell contains the m_P{1} content, it relates to detectd poses of the
%first camera view
% Z{p}{2}{k} cell contains the transformed back of point k in the second
% camera to the point p in the first camera

% Z{p}{3}{k} cell contains the transformed back of point k in third
% camera to the point p in the first camera



Z_final=cell(1,size(my_P{1},2));
for k=1:size(my_P{1},2)
    for camera=1:2
        for t=1:size(my_P{k},2)
            Z_final{k} = (Z{k}{1}+Z{k}{1}{t}+Z{k}{3}{t})/3;
            % % % %     [d1, Z1, tr1] = procrustes(Z_final{k},my_P{k}{1});
            % % % %     [d2, Z2, tr2] = procrustes(Z_final{k},my_P{k}{2});
            x{camera}=my_transfrom_to_first_view(Z_final{k}, my_P{camera}{k});
            reproj_er(k,camera)= my_reproj_error(x{camera}, my_P{camera}{k});
        end
        [m,ind]=min(reproj_er(k,:));
        matrix_index(k,camera)=ind;
    end
end






