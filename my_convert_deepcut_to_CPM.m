function prediction_CPM=my_convert_deepcut_to_CPM(prediction_deepercut)

nodes=[ 1     2    3     4     5     6     7    8    9    10    11    12    13    14  ;
        11    10   9     12    13    14    5    4    3     6     7     8     2     1; ];

for i=1:14
    prediction_CPM(nodes(2,i),:)= prediction_deepercut(nodes(1,i),:);
end


