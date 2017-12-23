%%
% =========================================================================
% Function recognizematch:
%   find top k matching images in Train set
% =========================================================================
function image_out_name = ...
    recognizematch(image_in_path, mean_train, ...
    centered_train, eigen_faces, matrix_name, k)

% -------------------------------------------------------------------------
% Find projected images
image_projectted = [];
train_count = size(eigen_faces,2);
for i = 1 : train_count
    temp = eigen_faces'*centered_train(:,i);
    image_projectted = [image_projectted temp]; 
end

% -------------------------------------------------------------------------
% Compute PCA
image_in = imread(image_in_path);
temp = image_in(:,:,1);
[row, col] = size(temp);
image_in = reshape(temp',row*col,1);
% Find centered test image
image_diff = double(image_in)-mean_train;
% Find feature vectors
feature_vector = eigen_faces'*image_diff; 

% -------------------------------------------------------------------------
% Calculating Euclidean distances 
distance_euclide = [];
for i = 1 : train_count
    q = image_projectted(:,i);
    temp = ( norm( feature_vector - q ) )^2;
    distance_euclide = [distance_euclide temp];
end

% -------------------------------------------------------------------------
% Find 10 best match
min_k_value = sort(distance_euclide);
min_k_value = min_k_value(1,1:k);
recognized_index = zeros(1,k);

% Return the name of 10 best match
image_out_name = cell(k,1);
for i=1:k
    num = min_k_value(1,i);
    [x, ~] = ind2sub(size(distance_euclide,2),find(distance_euclide==num));
    recognized_index(1,i) = x;
    image_out_name{i,1} = matrix_name{x};
end