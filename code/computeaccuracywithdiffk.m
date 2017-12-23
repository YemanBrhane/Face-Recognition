%%
% =========================================================================
% Function computeaccuracywithdiffk:
%   compute accuracy rate with different top k matched images
% =========================================================================
function array_accuracy_rate = computeaccuracywithdiffk (dir_train, dir_test)

% -------------------------------------------------------------------------
% Initilize
test_image_count = countimage (dir_test);
array_accuracy_rate = zeros(test_image_count,1);

% -------------------------------------------------------------------------
% For run from k=1 to number of images, compute the accuracy rate
for i=1:test_image_count
    accuracy_rate = computeaccuracy (dir_train, dir_test, i);  
    array_accuracy_rate (i,1) = accuracy_rate;
end
end


%%
% =========================================================================
% Function computeaccuracy:
%   compute accuracy rate with top k matched images
% =========================================================================
function accuracy_rate = computeaccuracy (dir_train, dir_test, k)

% -------------------------------------------------------------------------
% Initilize
true_count = 0;
test_listing = dir(dir_test);
test_image_count = countimage (dir_test);

% -------------------------------------------------------------------------
% Count true if matched image found
for i = 3 : test_image_count+2
    image_in_name = test_listing(i).name;
    image_out_name = findnameintraining (image_in_name, dir_test, dir_train, k);
    is_image_found = isimagefound(image_in_name, image_out_name);
    true_count = true_count + is_image_found;
end
accuracy_rate = true_count/test_image_count*100;
end



%%
% =========================================================================
% Function findnameintraining:
%   find list of k matched faces in train set
% =========================================================================
function image_out_name = findnameintraining (image_in_name, dir_test, dir_train, k)
image_in_path = strcat(dir_test,'\',image_in_name);
[D , matrix_name] = createdatabase(dir_train);
[mean_train, centered_train, eigen_faces] = computeeigenface(D);
image_out_name = recognizematch...
    (image_in_path, mean_train, centered_train, eigen_faces , matrix_name, k);
end


%%
% =========================================================================
% Function isimagefound:
%   return true if image is found
% =========================================================================
function is_image_found = isimagefound(image_in_name, image_out_name)
num_out = size(image_out_name,1);
is_image_found = 0;
for i=1:num_out
    image_in_name_filtered = filtername (image_in_name, 0);
    image_out_name_one = image_out_name{i,1};
    image_out_name_one_filtered = filtername (image_out_name_one, 0);
    if strcmp (image_in_name_filtered, image_out_name_one_filtered)
        is_image_found = 1;
        break;
    else
    end
end
end


%%
% =========================================================================
% Function filtername:
%   filter name to keep only useful information
% =========================================================================
function image_name_filtered = filtername (image_name, iskeepnumber)
C = strsplit(image_name,'.');
image_name_filtered = C{1};
if ~iskeepnumber
    image_name_filtered = image_name_filtered(1:size(image_name_filtered,2)-1);
end
end



%%
% =========================================================================
% Function countimage:
%   to count the number of images in one folder
% =========================================================================
function test_image_count = countimage (dir_test)
test_listing = dir(dir_test);
test_image_count = 0;
for i = 1:size(test_listing,1)
    if not(strcmp(test_listing(i).name,'.')|strcmp(test_listing(i).name,'..')|strcmp(test_listing(i).name,'Thumbs.db'))
        test_image_count = test_image_count + 1;
    end
end
end
