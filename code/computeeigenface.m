%%
% =========================================================================
% Function computeeigenface:
%   compute eigenfaces
% =========================================================================
function [mean_train, centered_train, eigen_faces] = computeeigenface(D)
                
% -------------------------------------------------------------------------
% Calculating the mean image 
mean_train = mean(D,2);
number_train = size(D,2);

% Calculating the deviation of each image from mean image
centered_train = [];  
for i = 1 : number_train
    temp = double(D(:,i)) - mean_train;
    centered_train = [centered_train temp];
end

% -------------------------------------------------------------------------
% Perform PCA
Sigma = centered_train'*centered_train; 
[V, P] = eig(Sigma);

% -------------------------------------------------------------------------
% Sorting and keep top eigenvalues
eigen_vector = [];
for i = 1 : size(V,2) 
    if( P(i,i)>1 )
        eigen_vector = [eigen_vector V(:,i)];
    end
end

% -------------------------------------------------------------------------
% Calculating the eigenfaces
eigen_faces = centered_train * eigen_vector; % A: centered image vectors