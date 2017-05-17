% function [Z,err,ind,prob_f]= my_easy_find_correspondance(my_P,fr)
function [Z,err,ind]= my_easy_find_correspondance(my_P,fr)
color =['r','g' ,'b'];

for c=2:3
    figure()
    im= ['/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Shelf/Camera' ,num2str(c-1),'/img_' sprintf('%06d', fr), '.png'] ;
    imshow(imread(im))
    hold on
    for i=1:size(my_P{1},2)
        %         clear err
        for k=1:size(my_P{c},2)
            Z{k} = my_transfrom_to_first_view(my_P{c}{k},my_P{1}{i});
            err{c}(i,k)=sqrt(sum(sum((Z{k}(:,1:2)-my_P{c}{k}(:,1:2)).*(Z{k}(:,1:2)-my_P{c}{k}(:,1:2)))));
            %             for j=1:size(my_P{c},2)
            %                 reproj_er(i,c,j) = sqrt(sum(sum((Z{k}-my_P{c}{j}).*(Z{k}-my_P{1}{i}))));
            %             end
            vis_2d(Z{k},color(i),1)
            vis_2d(my_P{c}{k},'c',1)
        end
    end
end

for c=2:3
    c
    for k=1:size(err{c},1)
        k
        [v,ind{c}(k)]= min(err{c}(k,:),[],2);
        
        err{c}(:,k)  = inf;
        err{c}(ind{c}(k),:) =inf;
    end
end

% % for c=2:3
% %     for i=1:size(my_P{1},2)
% %         for k=1:size(my_P{c},2)
% %             err{c}
% %             prob_n= err{c}./(repmat(sum(err{c},2),[1,size(err{c},2),1]));
% %             prob_k= err{c}./(repmat(sum(err{c},1),[size(err{c},1),1],1));
% %             %             prob_f= prob_n .*  prob_k;
% %             [~,ind(i,c-1)]=min(prob_f(i,:));
% %             %             [~,ind(i,c-1)]=min(err(:,k));
% %             groups{1}.a=[1,1];
% %             groups{1}.b=[1,2];
% %             groups{1}.c=[1,3];
% %             groups{1}.d=[1,4];
% %             
% %             
% %             groups{2}.a=[2,1];
% %             groups{2}.b=[2,2];
% %             groups{2}.c=[2,3];
% %             groups{2}.d=[2,4];
% %             
% %             
% %             groups{3}.a=[3,1];
% %             groups{3}.b=[3,2];
% %             groups{3}.c=[3,3];
% %             groups{3}.d=[3,4];
% % 
% %             for m=1:4
% %                 for n=1:4
% %                     if m==n 
% %                         continue
% %                     end
% %                     for o=1:4
% %                         if (m==n || n==o || m==o) 
% %                             continue
% %                         end
% %                         
% %                     end
% %                 end
% %             end  
% %         end
% %         disp(['Camera ' , num2str(c) ,' View First ', num2str(i) ])
% %         ind
% %     end
% % end
% % 
