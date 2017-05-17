function my_show_correspondance_multi_view(matrix_index,my_P,fr)

test_image=['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Shelf/Camera' ,num2str(1),'/img_' sprintf('%06d', fr), '.png'] ;
im = imread(test_image);
subplot(1,3,1);imshow(im);
hold on
vis_2d(my_P{1}{2});


for camera=2:3
    %     test_image =['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Campus_test/Camera' num2str(camera-1) '/campus4-c' num2str(camera-1) '-00', num2str(fr) , '.png'];
    %     test_image =['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Human3.6m/Images_S1/Direction1/Camera',num2str(camera),'/'  num2str(fr) ,'.jpg']
    test_image=['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Shelf/Camera' ,num2str(camera-1),'/img_' sprintf('%06d', fr), '.png'] ;
    
    im = imread(test_image);
    %     im = imresize(im,3);
    %     load(['/home/sara/applications/temp_deepCut/deepcut/data/mpii-multiperson/multicut/Campus/Camera' num2str(camera-1) '/campus4-c' num2str(camera-1) '-00',num2str(fr) ,'.mat']);
    %     load(['/home/sara/applications/temp_deepCut/deepcut/data/mpii-multiperson/multicut/Shelf_pred/Camera' num2str(camera-1) '/pred-img_', sprintf('%06d',fr),'.mat']);
    subplot(1,3,camera);imshow(im);
    hold on
    
    for k=2:2%size(my_P{1},2)
        
        prediction_CPM= my_P{camera}{matrix_index(k,camera-1)};
        %         prediction_CPM=my_convert_deepcut_to_CPM(prediction_deepercut);
        %         prediction_CPM(:,3)=ones(14,1) ;
        vis_2d(prediction_CPM);
        hold on
    end
end