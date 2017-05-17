function [Z]=my_transfrom_to_first_view(X,Y)

X(isnan(X))=0;
Y(isnan(Y))=0;


[d, Z, tr] = procrustes(X,Y);
