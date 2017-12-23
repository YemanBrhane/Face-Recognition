%%
% =========================================================================
% Function gui_randomimage:
%   random an image path
% =========================================================================
function [image_in_path, image_in_name] = gui_randomimage(dir_test)
test_image_count = countimage (dir_test);
random_number = round(rand(1)*test_image_count);
if random_number == 0
    random_number = 1;
end
test_listing = dir(dir_test);
image_in_name = test_listing(random_number+2).name;
if image_in_name ~= 0 
image_in_path = [dir_test '\' image_in_name];
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
