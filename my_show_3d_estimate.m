function [ my_P,my_people_cores ] = my_show_3d_estimate( fr,s1_s9_2d_n,s1_s9_3d,my_people,images )

my_P=cell(1,3);
for camera=1:3
    
    subplot(2,3,camera);imshow(images{camera});
    hold on
    cnt=0;
    for k=1:size(my_people{camera},2)
        %         k
        %         size(people,2)
        hold on
        prediction_deepercut= my_people{camera}{k};
        % % %         %         if sum(sum(isnan(people{k}))<1)
        prediction_CPM=my_convert_deepcut_to_CPM(prediction_deepercut);
        % prediction = people{2};
        %{
% get image size
[H,W,~] = size(im);

%% detect human using CPM
rectangle(1) = 1;
rectangle(2) = 1;
rectangle(3) = W-1;
rectangle(4) = H-1;
[heatMaps, human_c] = applyModel_human3d(test_image, param, rectangle, 2);

%% 2D pose estimation using CPM with the bounding box specified by the
% detected human postition
rectangle(1) = human_c(1) - 0.5*W;
rectangle(2) = human_c(2) - 0.5*H;
rectangle(3) = 1*W;
rectangle(4) = 1*H;
[heatMaps, prediction] = applyModel_human3d(test_image, param, rectangle, 1);
        %}
        prediction=prediction_CPM;
        Prediction{1}=prediction;
        
        % manually adjust two hips' position due to the variation across MPII and
        % H36M
        % %         if ~isnan(prediction(9,2)) && ~isnan(prediction(12,2))
                
        prediction(9,2)  = prediction(9,2) - 20;
        prediction(12,2) = prediction(12,2) - 20;
        
        %% extract the nearest neighbor
        % % % %         [j_p] = NN_pose(s1_s9_2d_n,s1_s9_3d,prediction);
        
        [j_p] = My_NN_pose(s1_s9_2d_n,s1_s9_3d,prediction);
        
        % % % %         [j_p] = NN_pose(pool_2D,pool_3D,prediction);
        
        % [j_p] = kNN_pose_procrus(s1_s9_2d_n,s1_s9_3d,prediction, 10);
        
        % compute the scale between pixel and real world to recover real size of
        % prediction
        scale = (max(j_p(:,2))-min(j_p(:,2)))/(max(prediction(:,2))-min(prediction(:,2)));
        
        % predict the depth of each joint by the exemplar
        prediction(:,3) = j_p(:,3)/scale;
        
        
        %% visualization
        % H=figure();
        
        % self-defined ground plane
        prediction(:,3) = prediction(:,3) - min(prediction(:,3));% + 1300;
        an_x_m = min(prediction(:,1));
        an_x_M = max(prediction(:,1));
        an_y_M = max(prediction(11,2),prediction(14,2));
        x = [an_x_m-100 an_x_M+100 an_x_m-100 an_x_M+100];
        y = [an_y_M-10 an_y_M-10 an_y_M+40 an_y_M+40];
        z = [min(prediction(:,3)-120) min(prediction(:,3)-120) max(prediction(:,3)+120) max(prediction(:,3)+120)];
        A = [x(:) y(:) z(:)];
        % solve for the ground plane
        
        [n,v,m,aved,my_check]=plane_fit(A);
        if my_check
            cnt=cnt+1;
            % draw the prediction on the input image
            %         subplot(2,3,[1 2])
            people_2d_order{camera}{cnt}=k;
            subplot(2,3,camera);
            vis_2d(prediction,'b',1);
            % % % % H=figure();
            % % % % subplot(1,3,[1 2]);imshow(im);
            % % % % my_vis_2d(prediction);
            
            % draw the 3D pose
            %         subplot(1,3,camera);
            subplot(2,3,camera+3);
            hold on
            vis_3d(prediction);
            my_P{camera}{cnt}=prediction;
            my_people_cores{camera}{cnt}=my_people{camera}{k};
            % draw the ground plane
            planeplot(A,n,m)
            view(26,-56);
            % draw camera
            scale = 50;
            P = scale*[0 0 0;0.5 0.5 0.2; 0.5 -0.5 0.2; -0.5 0.5 0.2;-0.5 -0.5 0.2];
            cen = mean(prediction);
            P1=(P+repmat([cen(1:2), 800],[5,1]));
            line([P1(1,1) P1(2,1)],[P1(1,2) P1(2,2)],[P1(1,3) P1(2,3)],'color','k')
            line([P1(1,1) P1(3,1)],[P1(1,2) P1(3,2)],[P1(1,3) P1(3,3)],'color','k')
            line([P1(1,1) P1(4,1)],[P1(1,2) P1(4,2)],[P1(1,3) P1(4,3)],'color','k')
            line([P1(1,1) P1(5,1)],[P1(1,2) P1(5,2)],[P1(1,3) P1(5,3)],'color','k')
            
            line([P1(2,1) P1(3,1)],[P1(2,2) P1(3,2)],[P1(2,3) P1(3,3)],'color','k')
            line([P1(3,1) P1(5,1)],[P1(3,2) P1(5,2)],[P1(3,3) P1(5,3)],'color','k')
            line([P1(5,1) P1(4,1)],[P1(5,2) P1(4,2)],[P1(5,3) P1(4,3)],'color','k')
            line([P1(4,1) P1(2,1)],[P1(4,2) P1(2,2)],[P1(4,3) P1(2,3)],'color','k')
            
            % adjust the viewing angle
            view(26,-56);
            %     axis equal
            
            %
            %     for person=1:1:length(actor2D) %person (1,2,3)
            %         xyz = actor3D{person}{fr}; %3D joints
            %         xyz=xyz*1000;
            %         if size(xyz,1)>0
            %             c = repmat(humanCol{person},size(xyz,1),1);
            %             s = 50*ones(size(xyz,1),1);
            %             scatter3(xyz(:,1), xyz(:,2), xyz(:,3),s,c,'fill'); hold on;
            %             %             xlim([-10 10]); ylim([-10 10]); zlim([0 5]);
            %         end
            %     end
            %         view(26,-56);
            % xlim([0 1500])
            % ylim([0 1500])
            
            % ylim([0 1000])
            % zlim([0 1000])
            grid on
        end
        % %         end
        % axis off
    end
end
axis equal
grid on
end
