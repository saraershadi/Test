% visualize 2d pose
function vis_2d(j_p,color,t)
prediction = j_p;
%prediction(:,1)=prediction(:,1)*(-1);
depth = prediction(:,3);
    hold on;
    %for a = 1:14
    %    scatter(prediction(a,1),prediction(a,2));
    %    axis equal
    %end
    
line([prediction(1,1),prediction(2,1)],[prediction(1,2),prediction(2,2)],[depth(1),depth(2)],'Color', color,'LineWidth',3);
line([prediction(2,1),prediction(3,1)],[prediction(2,2),prediction(3,2)],[depth(2),depth(3)],'Color',color,'LineWidth',3);
line([prediction(3,1),prediction(4,1)],[prediction(3,2),prediction(4,2)],[depth(3),depth(4)],'Color',color,'LineWidth',3);
line([prediction(4,1),prediction(5,1)],[prediction(4,2),prediction(5,2)],[depth(4),depth(5)],'Color',color,'LineWidth',3);
line([prediction(2,1),prediction(6,1)],[prediction(2,2),prediction(6,2)],[depth(2),depth(6)],'Color',color,'LineWidth',3);
line([prediction(6,1),prediction(7,1)],[prediction(6,2),prediction(7,2)],[depth(6),depth(7)],'Color',color,'LineWidth',3);
line([prediction(7,1),prediction(8,1)],[prediction(7,2),prediction(8,2)],[depth(7),depth(8)],'Color',color,'LineWidth',3);
line([prediction(9,1),prediction(10,1)],[prediction(9,2),prediction(10,2)],[depth(9),depth(10)],'Color',color,'LineWidth',3);
line([prediction(10,1),prediction(11,1)],[prediction(10,2),prediction(11,2)],[depth(10),depth(11)],'Color',color,'LineWidth',3);
line([prediction(12,1),prediction(13,1)],[prediction(12,2),prediction(13,2)],[depth(12),depth(13)],'Color',color,'LineWidth',3);
line([prediction(13,1),prediction(14,1)],[prediction(13,2),prediction(14,2)],[depth(13),depth(14)],'Color',color,'LineWidth',3);
line([(prediction(9,1)+prediction(12,1))/2,prediction(2,1)],[(prediction(9,2)+prediction(12,2))/2,prediction(2,2)],[(depth(9)+depth(12))/2,depth(2)],'Color',color,'LineWidth',3);
line([prediction(9,1),prediction(12,1)],[prediction(9,2),prediction(12,2)],[depth(9),depth(12)],'Color',color,'LineWidth',3);



% h=rectangle('Position',[prediction(1,1) prediction(1,2)  100  100]);
% text(prediction(1,1), prediction(1,2),num2str(t),'LineWidth',30,'FontSize',50,'Color',[0.749019622802734 0 0.749019622802734])   

% % % h=rectangle('Position',[prediction(1,1) prediction(1,2)  100  100], 'LineWidth',30,...
% % %     'FontSize',30,...
% % %     'Color',[0.749019622802734 0 0.749019622802734])
% % % text(prediction(1,1), prediction(1,2),num2str(t), 'LineWidth',30,...
% % %     'FontSize',30,...
% % %     'Color',[0.749019622802734 0 0.749019622802734])   
    
% % line([prediction(1,1),prediction(2,1)],[prediction(1,2),prediction(2,2)],[depth(1),depth(2)],'Color','b','LineWidth',3);
% % line([prediction(2,1),prediction(3,1)],[prediction(2,2),prediction(3,2)],[depth(2),depth(3)],'Color','b','LineWidth',3);
% % line([prediction(3,1),prediction(4,1)],[prediction(3,2),prediction(4,2)],[depth(3),depth(4)],'Color','g','LineWidth',3);
% % line([prediction(4,1),prediction(5,1)],[prediction(4,2),prediction(5,2)],[depth(4),depth(5)],'Color','g','LineWidth',3);
% % line([prediction(2,1),prediction(6,1)],[prediction(2,2),prediction(6,2)],[depth(2),depth(6)],'Color','b','LineWidth',3);
% % line([prediction(6,1),prediction(7,1)],[prediction(6,2),prediction(7,2)],[depth(6),depth(7)],'Color','r','LineWidth',3);
% % line([prediction(7,1),prediction(8,1)],[prediction(7,2),prediction(8,2)],[depth(7),depth(8)],'Color','r','LineWidth',3);
% % line([prediction(9,1),prediction(10,1)],[prediction(9,2),prediction(10,2)],[depth(9),depth(10)],'Color','g','LineWidth',3);
% % line([prediction(10,1),prediction(11,1)],[prediction(10,2),prediction(11,2)],[depth(10),depth(11)],'Color','g','LineWidth',3);
% % line([prediction(12,1),prediction(13,1)],[prediction(12,2),prediction(13,2)],[depth(12),depth(13)],'Color','r','LineWidth',3);
% % line([prediction(13,1),prediction(14,1)],[prediction(13,2),prediction(14,2)],[depth(13),depth(14)],'Color','r','LineWidth',3);
% % line([(prediction(9,1)+prediction(12,1))/2,prediction(2,1)],[(prediction(9,2)+prediction(12,2))/2,prediction(2,2)],[(depth(9)+depth(12))/2,depth(2)],'Color','b','LineWidth',3);
% % line([prediction(9,1),prediction(12,1)],[prediction(9,2),prediction(12,2)],[depth(9),depth(12)],'Color','b','LineWidth',3);

hold off
end