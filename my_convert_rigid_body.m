function [Cameras,number_of_people,P,err,best_selection]=my_convert_rigid_body(my_P,fr,images,my_people_cores)

Cameras=0;
for c=1:3
    number_of_people{c}=size(my_people_cores{c},2);
end

%% -------------------------------------------------------------------------
%% -------creating selection for camera first ------------------------------
for k=1:size(my_people_cores{1},2)
    selection{1}(k)=k;
end
%% -------------------------------------------------------------------------
for c=2:3
    c
    %     subplot(1,3,c);imshow(images{c});
    
    cnt=1;
    for k=1:size(my_people_cores{c},2)
        %         if sum(sum(isnan(my_people{c}{k}))<7)
        prediction_deepercut  = my_people_cores{c}{k};
        prediction_CPM{c}{cnt}= my_convert_deepcut_to_CPM(prediction_deepercut);
        cnt=cnt+1;
        %         end
    end
    %% ---------selection matrix is for selecting people between the number of people in the scene--------
    if  (number_of_people{c}> number_of_people{1})
        n=1:number_of_people{c};
        k=number_of_people{1};
        selection{c}=nchoosek(n,k);
    elseif  (number_of_people{c}== number_of_people{1})
        
        selection{c}= 1:number_of_people{c};
    else
        continue;
    end
% % %     
% % %     elseif  (number_of_people{c} number_of_people{1})
% % %         selection{c}= 1:number_of_people{c};
% % %         
% % %     elseif   (number_of_people{c}< number_of_people{1})
% % %         selection{c}= 1:number_of_people{c};
% % %         
% % %         n=1:number_of_people{1};
% % %         k=number_of_people{c};
% % %         my_selection{c}=nchoosek(n,k);
% % %     end
    %% ------Now I should permute the selection for choosing the best order of people ---------------------------
    %% ------I might select the correct people K from n available people but the color of people are not the same
    for t=1:size(selection{c},1)
        t
        my_perm{c}{t}=perms(selection{c}(t,:));
        for h=1:size(my_perm{c}{t},1)
            h
            for k=1:size(my_perm{c}{t},2)
                k
                %% -----   P is an array of 3D people corresponding to my_perm{c}(t,:) order      ------
                % % %                 if (number_of_people{c} < number_of_people{1})
                % % %                     my_perm_cam_1{1}{t}=perms(my_selection{c}(t,:));
                % % %
                % % %                     P{c}{t}{h}(1+(k-1)*14:k*14,:)=my_P{c}{my_perm{c}{t}(h,k)};
                % % %                     %% ----- p_CPM_concat is array of 2D people correpsonding to my_perm{c}(t,:) order ------
                % % %                     p_CPM_concat{c}{t}{h}(1+(k-1)*14:k*14,:)= prediction_CPM{c}{my_perm{c}{t}(h,k)};
                % % %
                % % %                     %% -------converting my_P from cell shape to array shape -------------------
                % % %                     for t=1:size(my_P{1},2)
                % % %                         t
                % % %                         %     my_P{1}{t}
                % % %                         P{1}{1}{1}(1+(t-1)*14:t*14,:)=my_P{1}{my_perm{c}{t}(h,k)};
                % % %                     end
                % % %                 else
                
                %% -------converting my_P from cell shape to array shape -------------------
                for x=1:size(my_P{1},2)
                    x
                    %     my_P{1}{t}
                    P{1}{1}{1}(1+(x-1)*14:x*14,:)=my_P{1}{x};
                end
                P{c}{t}{h}(1+(k-1)*14:k*14,:)=my_P{c}{my_perm{c}{t}(h,k)};
                %% ----- p_CPM_concat is array of 2D people correpsonding to my_perm{c}(t,:) order ------
                p_CPM_concat{c}{t}{h}(1+(k-1)*14:k*14,:)= prediction_CPM{c}{my_perm{c}{t}(h,k)};
                
                %         X(isnan(X))= 0;
                %         Y(isnan(Y))= 0;
                % % %                 end
            end
            P{1}{1}{1}(isnan(P{1}{1}{1}))=0;
            P{c}{t}{h}(isnan(P{c}{t}{h}))=0;
            [d{c}{t}{h}, Z{c}{t}{h}, tr{c}{t}{h}] = procrustes(P{c}{t}{h},P{1}{1}{1});
            %% --------------------re-projection error  ---------------------------------------
            %% --------------------------------------------------------------------------------
            %         after{c}{t}=permute(reshape(temporary,[3 14 size(Z{c}{t},1)/14 ]),[2 1 3]);
            % %         err{c}(t)=sqrt(sum(sum((my_P{c}{k}(:,1:2)-after{c}{t}(:,1:2)).*(my_P{c}{k}(:,1:2)-after{c}{t}(:,1:2)))));
            term_1= p_CPM_concat{c}{t}{h}(:,1:2);
            term_2 = Z{c}{t}{h}(:,1:2);
            term_1(isnan(term_1))=0;
            term_2(isnan(term_2))=0;
            err{c}(t,h)=sqrt(sum(sum((term_1-term_2).*(term_1 - term_2))));
        end
    end
    [value,order] = min(min(err{c}));
    [min_val,idx]= min(err{c}(:))
    [row,col]=ind2sub(size(err{c}),idx)
    best_selection{c} = my_perm{c}{row}(col,:);
end

%% -----There are approximately 120 different states and the best satet is one of them ----------------
%% ----------------------------------------------------------------------------------------------------
% camera=2;
% c=2;
% temp_people{1} = my_people_cores{1};
%
% for t=1:size(selection{c},1)
%     for k=1:size(my_perm{c}{t},1)
%         for h=1:size(my_perm{c}{t},2)
%             temp_people{c}{h} = my_people_cores{c}{my_perm{c}{t}(k,h)};
%         end
%         figure()
%         my_show_associate_color(fr,temp_people,images);
%     end
% end



