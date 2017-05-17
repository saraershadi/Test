clc;
close all;
% demo code for 3D human pose estimation from a monocular RGB image
% this demo code uses CPM (Convolutional Pose Machines) for 2D pose
% estimation, however, any 2D pose estimator from image can be applied.
% prediction: The 2D pose, a 14X2 matrix, 14 corresponding position as
% listed in the following order, 3 columns with [x y] coordinates.
% (head)
% (neck)
% (right shoulder)
% (right elbow)
% (right wrist)
% (left shoulder)
% (left elbow)
% (left wrist)
% (right hip)
% (right knee)
% (right ankle)
% (left hip)
% (left knee)
% (left ankle)

%% setup+
% param = model_config();
load('3D_library.mat');
fr = 350;
%% input image path
% test_image = ['imgs/im0371.jpg'];
% test_image = ['imgs/sara1.jpg'];
% test_image = ['imgs/HJ.jpg'];
% % % test_image = ['imgs/013215620.jpg'];
[ my_P ] = my_show_3d_estimate( fr,s1_s9_2d_n,s1_s9_3d);

figure()
hold on
visualize3DGT

load('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/actorsGT.mat');


% figure()
% hold on
% for camera =  1:3
%     %     temp = zeros(1,28);
%     temp_root = 0.5 * ( my_P{camera}(9,:) +  my_P{camera}(12,:));
%     for a = 1:14
%         my_P_norm{camera}(a,1) =  my_P{camera}(a,1) - temp_root(1);
%         my_P_norm{camera}(a,2) =  my_P{camera}(a,2) - temp_root(2);
%         my_P_norm{camera}(a,3) =  my_P{camera}(a,3) - temp_root(3);
%         %         y_c(a) = temp(1,2*a);
%     end
%     %     scale = max(y_c)-min(y_c);
%     %     temp = temp / scale;
%     %     my_P_norm{camera}= temp;
%     vis_3d(my_P_norm{camera});
% end
% view(26,-56);
% grid on

[X,Z1,Z2,gt_cpm,Z3,tr1_i,tr2_i]= my_show_all_3d_camera_same(my_P,fr,person,actor3D,actor2D);

error = MPJPE(gt_cpm,X)
error = MPJPE(gt_cpm,Z1)
error = MPJPE(gt_cpm,Z2)

Z_mean = (X+Z1+Z2)/3;



figure()
hold on
view(26,-56);
vis_3d(Z_mean);
vis_3d(Z3);
axis equal

close all;
X_after = tr1_i.b * Z_mean * tr1_i.T + tr1_i.c;
y_after = tr2_i.b * Z_mean * tr2_i.T + tr2_i.c;
figure()
hold on
% close all;

after_pose{1}=Z_mean;
after_pose{2}=y_after;
after_pose{3}=X_after ;

for camera=1 :3
    test_image =['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Campus_test/Camera' num2str(camera-1) '/campus4-c' num2str(camera-1) '-00', num2str(fr) , '.png'];
    %     test_image =['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Human3.6m/Images_S1/Direction1/Camera',num2str(camera),'/'  num2str(fr) ,'.jpg']
    im = imread(test_image);
    im = imresize(im,3);
    subplot(1,3,camera)
    imshow(im)
    vis_3d(after_pose{camera})
    hold on
end


% % % for camera=1 :3
% % %     test_image =['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Campus_test/Camera' num2str(camera-1) '/campus4-c' num2str(camera-1) '-00', num2str(fr) , '.png']
% % %     %     test_image =['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Human3.6m/Images_S1/Direction1/Camera',num2str(camera),'/'  num2str(fr) ,'.jpg']
% % %     im = imread(test_image);
% % %     im = imresize(im,3);
% % %     subplot(1,3,camera)
% % %     imshow(im)
%     vis_3d(after_pose{camera})
my_P=show_again_3d(fr,after_pose,s1_s9_2d_n,s1_s9_3d);
% % %     hold on
% % % end


X=my_P{1};
G=my_P{2};
Y=my_P{3};

X(isnan(X))=0;
Y(isnan(Y))=0;
G(isnan(G))=0;

[d1, Z1, tr1] = procrustes(X,Y);
[d2, Z2, tr2] = procrustes(X,G);


[d1_i, Z1_i, tr1_i] = procrustes(Y,X);
[d2_i, Z2_i, tr2_i] = procrustes(G,X);



% plot(X(:,1),X(:,2),'rx', Y(:,1),Y(:,2),'b.', Z(:,1),Z(:,2),'gx','MarkerSize' ,10, 'LineWidth',2);
plot3(X(:,1),X(:,2),X(:,3),'rx', Y(:,1),Y(:,2),Y(:,3),'b.', Z1(:,1),Z1(:,2),Z1(:,3),'gx','MarkerSize' ,10, 'LineWidth',2);
figure()
hold on
% vis_3d(X);
vis_3d(X);
vis_3d(Z1);
vis_3d(Z2);
view(26,-56)

%%%%% ---------------------------------
X=my_P{1};
G=my_P{2};
Y=my_P{3};

X(isnan(X))=0;
Y(isnan(Y))=0;
G(isnan(G))=0;

[d1, Z1, tr1] = procrustes(X,Y);
[d2, Z2, tr2] = procrustes(X,G);


[d1_i, Z1_i, tr1_i] = procrustes(Y,X);
[d2_i, Z2_i, tr2_i] = procrustes(G,X);



% plot(X(:,1),X(:,2),'rx', Y(:,1),Y(:,2),'b.', Z(:,1),Z(:,2),'gx','MarkerSize' ,10, 'LineWidth',2);
plot3(X(:,1),X(:,2),X(:,3),'rx', Y(:,1),Y(:,2),Y(:,3),'b.', Z1(:,1),Z1(:,2),Z1(:,3),'gx','MarkerSize' ,10, 'LineWidth',2);
figure()
hold on
% vis_3d(X);
vis_3d(X);
vis_3d(Z1);
vis_3d(Z2);
view(26,-56)
% axis equal
grid on
xyz = actor3D{person}{fr}; %3D joints

for person=1:1:length(actor2D) %person (1,2,3)
    xyz = actor3D{person}{fr}; %3D joints
%     xyz= xyz *300;
    if size(xyz,1)>0
        gt_cpm=my_convert_campus_to_CPM(xyz);
        
        [d3, Z3, tr3] = procrustes(X,gt_cpm);
        [d3_i, Z3_i, tr3_i] = procrustes(gt_cpm,X);

        vis_3d(Z3);
        %
        %         c = repmat(humanCol{person},size(xyz,1),1);
        %         s = 50*ones(size(xyz,1),1);
        %         scatter3(Z3(:,1), Z3(:,2), Z3(:,3),s,c,'fill'); hold on;
        %         xlim([-10 10]); ylim([-10 10]); zlim([0 5]);
    end
end
hold on;
view(26,-56);


prediction = Z3(:,1:2);
%prediction(:,1)=prediction(:,1)*(-1);
depth = Z3(:,3);
%h=figure(4); 
hold on;
line([prediction(1,1),prediction(2,1)],[prediction(1,2),prediction(2,2)],[depth(1),depth(2)],'Color','k','LineWidth',3);
line([prediction(2,1),prediction(3,1)],[prediction(2,2),prediction(3,2)],[depth(2),depth(3)],'Color','k','LineWidth',3);
line([prediction(3,1),prediction(4,1)],[prediction(3,2),prediction(4,2)],[depth(3),depth(4)],'Color','k','LineWidth',3);
line([prediction(4,1),prediction(5,1)],[prediction(4,2),prediction(5,2)],[depth(4),depth(5)],'Color','k','LineWidth',3);
line([prediction(2,1),prediction(6,1)],[prediction(2,2),prediction(6,2)],[depth(2),depth(6)],'Color','k','LineWidth',3);
line([prediction(6,1),prediction(7,1)],[prediction(6,2),prediction(7,2)],[depth(6),depth(7)],'Color','k','LineWidth',3);
line([prediction(7,1),prediction(8,1)],[prediction(7,2),prediction(8,2)],[depth(7),depth(8)],'Color','k','LineWidth',3);
line([prediction(9,1),prediction(10,1)],[prediction(9,2),prediction(10,2)],[depth(9),depth(10)],'Color','k','LineWidth',3);
line([prediction(10,1),prediction(11,1)],[prediction(10,2),prediction(11,2)],[depth(10),depth(11)],'Color','k','LineWidth',3);
line([prediction(12,1),prediction(13,1)],[prediction(12,2),prediction(13,2)],[depth(12),depth(13)],'Color','k','LineWidth',3);
line([prediction(13,1),prediction(14,1)],[prediction(13,2),prediction(14,2)],[depth(13),depth(14)],'Color','k','LineWidth',3);
line([(prediction(9,1)+prediction(12,1))/2,prediction(2,1)],[(prediction(9,2)+prediction(12,2))/2,prediction(2,2)],[(depth(9)+depth(12))/2,depth(2)],'Color','k','LineWidth',3);
line([prediction(9,1),prediction(12,1)],[prediction(9,2),prediction(12,2)],[depth(9),depth(12)],'Color','k','LineWidth',3);


error = MPJPE(gt_cpm,X)
error = MPJPE(gt_cpm,Z1)
error = MPJPE(gt_cpm,Z2)

Z_mean = (X+Z1+Z2)/3;



figure()
hold on
view(26,-56);
vis_3d(Z_mean);
vis_3d(Z3);
axis equal


X_after = tr1_i.b * Z_mean * tr1_i.T + tr1_i.c;
y_after = tr2_i.b * Z_mean * tr2_i.T + tr2_i.c;
% figure()
% hold on


