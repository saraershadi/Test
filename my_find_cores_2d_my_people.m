function my_2d_final_people= my_find_cores_2d_my_people(my_people,best_selection)

%%  for camera 1 the order is its own order.
for k=1:size(best_selection{2},2)
    my_2d_final_people{1}{k}= my_people{1}{k};
end

for camera=2:3
    camera
    for k=1:size(best_selection{camera},2)
        k
        my_2d_final_people{camera}{k}=my_people{camera}{best_selection{camera}(k)};
    end
end
