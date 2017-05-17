function my_show_associate_color(fr,my_people,images)

color= ['g'; 'b';'r';'c';'y']
for camera=1:3
    subplot(1,3,camera)
    imshow(images{camera})
    for k=1:size(my_people{camera},2)
%         if sum(sum(isnan(my_people{camera}{k}))<10)
            
            prediction_deepercut= my_people{camera}{k};
            prediction_CPM=my_convert_deepcut_to_CPM(prediction_deepercut);
            
            prediction_CPM(:,3)=ones(14,1) ;
            vis_2d(prediction_CPM,color(k),1);
            
            hold on
%         end
    end
end