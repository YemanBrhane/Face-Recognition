%%
% =========================================================================
% Function createdatabase:
%   create databse from train set
% =========================================================================
function [D , matrix_name] = createdatabase(dir_train)

% -------------------------------------------------------------------------
% Initilize

% Find number of images in a folder
train_listing = dir(dir_train);
train_count = 0;
for i = 1:size(train_listing,1)
    if not(strcmp(train_listing(i).name,'.')|strcmp(train_listing(i).name,'..')|strcmp(train_listing(i).name,'Thumbs.db'))
        train_count = train_count + 1;
    end
end

% -------------------------------------------------------------------------
% Construct of matrix from 1D image vectors and array of corresponding face
% name
matrix_name = cell (train_count,1);
listing = dir (dir_train);
D = [];
for i = 3 : train_count+2    
    image_name = listing(i).name;
    matrix_name{i-2} = image_name;
    image_path = strcat (dir_train , '\' , image_name);
    str = image_path;
    img = imread(str);
    [row, col] = size(img);
    temp = reshape(img',row*col,1);
    D = [D temp];        
end