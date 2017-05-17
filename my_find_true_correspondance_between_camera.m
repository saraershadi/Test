function Z=my_find_true_correspondance_between_camera(my_P)
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


% Z=cell(1,size(my_P{1},2));

for p=1:size(my_P{1},2)
    for camera =2:3
        for k=1:size(my_P{camera},2)
            if size(my_P{camera}{k}>0)
                
                Z{p}{camera-1}{k}=my_transfrom_to_first_view(my_P{1}{p},my_P{camera}{k});
          
            end
        end
    end
end



