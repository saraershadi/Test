function reproj_er= my_reproj_error(x,p)

reproj_er = sqrt(sum(sum((x-p).*(x-p))));