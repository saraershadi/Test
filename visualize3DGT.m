% Vasilis Belagiannis - CAMP - TUM - belagian@in.tum.de

% clear all; close all; clc;

images{1} = dir('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/Camera0/*.png');
images{2} = dir('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/Camera1/*.png');
images{3} = dir('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/Camera2/*.png');

load('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/actorsGT.mat');

%individual color
humanCol = {[1 0 0],[0 1 0],[1 0 1]};

my_dir='/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/';
%calibration
load('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/CampusSeq1/Calibration/prjectionMat.mat');

N_cams=length(actor2D{1}{1});
N_frames=length(actor2D{1});

% for fr=704:1:N_frames %frame
% for fr=351:351%448:470%frame
fr
%plot joints 3D
subplot(2,2,N_cams+1);
for person=1:1:length(actor2D) %person (1,2,3)
    xyz = actor3D{person}{fr}; %3D joints
    
    if size(xyz,1)>0
        c = repmat(humanCol{person},size(xyz,1),1);
        s = 50*ones(size(xyz,1),1);
        scatter3(xyz(:,1), xyz(:,2), xyz(:,3),s,c,'fill'); hold on;
        xlim([-10 10]); ylim([-10 10]); zlim([0 5]);
    end
end
hold off;
view(26,-56);


%plot joints 2D
for cam=1:1:N_cams
    
    %load image data
    im = imread([my_dir sprintf('Camera%d/',cam-1) images{cam}(fr).name]);
    subplot(2,2,cam);
    imshow(im); hold on;
    
    for person=1:1:length(actor2D) %person (1,2,3)
        
        xyz = actor3D{person}{fr}; %3D joints
        
        text(10,10,sprintf('Frame:%d, Camera:%d',fr,cam),'Color','r','FontSize',12);
        for m=1:1:size(xyz,1)
            
            X = [xyz(m,:) 1]';
            xy = P{cam}*X; %project the 3D point
            xy = xy./xy(3);
            
            text(xy(1),xy(2), num2str(m), 'Color', humanCol{person});
            
            if m==14
                text(xy(1),xy(2)-10, sprintf('A%d',person), 'Color', humanCol{person}, 'FontSize', 12);
            end
        end
    end
    hold off;
end
pause(0.03);
% end
