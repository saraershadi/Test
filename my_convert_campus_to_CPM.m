function gt_cpm=my_convert_campus_to_CPM(gt_campus)

nodes=[ 1     2    3     4     5     6     7    8    9    10    11    12    13    14  ;
        11    10   9     12    13    14    5    4    3     6     7     8     2     1; ];

for i=1:14
    gt_cpm(nodes(2,i),:)= gt_campus(nodes(1,i),:);
end
