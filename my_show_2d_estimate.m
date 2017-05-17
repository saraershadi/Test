function my_show_2d_estimate(fr,my_people,images)

for camera=1:3
    subplot(1,3,camera)
    imshow(images{camera})
    for k=1:size(my_people{camera},2)
        if sum(sum(isnan(my_people{camera}{k}))<10)
            
            prediction_deepercut= my_people{camera}{k};
            prediction_CPM=my_convert_deepcut_to_CPM(prediction_deepercut);
            
            prediction_CPM(:,3)=ones(14,1) ;
            vis_2d(prediction_CPM,'b',1);
            
            hold on
        end
    end
end