
% Mean Field Approximation

close all;
clearvars;
clc;

num_kernel = 1;
sigma_s = 4; %24
sigma_r = 0.1; %0.2
num_pca_iterations = 5;
num_pca_dimensions = 10;
patch_radius       = 5; % patch size is 2*patch_radius + 1;

im = imread('images/im3.ppm');
im = im2double(im);
figure; imshow(im);
[m1,n1 ,c1] = size (im);

im_anno = imread('images/anno3.ppm');
figure(2); imshow(im_anno);

% Computing unary potentials
colors = unique(reshape(im_anno,size(im,1)*size(im,2),3),'rows');
n_label=size(colors,1);

GT_PROB = 0.5;
u_energy = -log( 1.0 / n_label );
n_energy = -log( (1.0 - GT_PROB) / (n_label-1) );
p_energy = -log( GT_PROB );

tic
r = u_energy .* ones( size(im,1), size(im,2), n_label);
for m=1:size(im,1)
    for n=1:size(im,2)
        c = im_anno(m,n,:);
        c = c(:)';
        for i = 1:size(colors,1)
            if (length(find(c==colors(i,:))) == 3)
                break;
            end
        end
        if(sum(c)>0)
            for j=1:n_label
                r(m,n,j) = n_energy;
            end
            r(m,n,i) = p_energy;
        end
    end
end
toc

w = ones(num_kernel,1)*4;

tic
Q = exp(-r);
Q = Q ./ repmat(sum(Q,3),[1 1 size(Q,3)]);
toc

% Compute non-local-means patch space using 7x7 color patches reduced to 25 dimensions.
nlmeans_space = compute_non_local_means_basis(im ,patch_radius, num_pca_dimensions);
tree_height = 2 + compute_manifold_tree_height(sigma_s, sigma_r);

f_joint = nlmeans_space;
Q1 = zeros(m1,n1,n_label,num_kernel);

iteration=0;
while (iteration <10)
    iteration = iteration+1;
    
    tic;
    f = Q;
    for nk = 1:num_kernel
        [g ,tilde_g] = adaptive_manifold_filter(f, sigma_s, sigma_r, tree_height, f_joint, num_pca_iterations);
        Q1(:,:,:,nk) = g;%-Q; should be k(Fi,Fj)*Q
    end
    toc;
    
    Q2 = zeros(n_label,n1,m1);
    Qt = permute(Q1,[4 3 2 1]);
    for i=1:size(im,1)
        for j=1:size(im,2)
            wl = w' * Qt(:,:,j,i);
            swl = repmat(sum(wl),1,n_label);
            Q2(:,j,i) = (swl - wl)';
        end
    end
    Q2 = permute(Q2,[3 2 1]);
    Q = exp(-r - Q2);
    Q = Q ./ repmat(sum(Q,3),[1 1 size(Q,3)]);
    
    [probability, label] = max(Q,[],3);
    
    im2 = colors(label,:);
    im2 = reshape(im2,size(im));
    figure; imshow(im2);
end








