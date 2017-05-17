clear all;
load('/media/sara/AE4E365A4E361B91/ERSHADI/dataset/Shelf/actorsGT.mat');
for fr=300:600
    for person=1:1:length(actor2D) %person (1,2,3)
        xyz= actor2D{person}{fr}; %3D joints
        %         actor2D{person}{fr}
        if ~isempty(actor3D{person}{fr})
            validity_3d{person}(fr-299)= 1;
        else
            validity_3d{person}(fr-299)= 0;
        end
    end
end
