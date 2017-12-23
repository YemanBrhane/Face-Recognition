%%
% =========================================================================
% Function gui_addandfindranking:
%   add ranking to image name for example 1. yeman2
%   find the list of found faces in the best matched images
% =========================================================================
function [image_out_name_display, image_matched_display] = ...
    gui_addandfindranking (image_out_name, image_in_name_full)

% -------------------------------------------------------------------------
% Initilize
num_image = size(image_out_name,1);
% Declare list of 10 matched images with ranking
image_out_name_display = cell(num_image,1);
count = 0;
[~, image_in_name_no_number] = ...
    removeformat (image_in_name_full);

% -------------------------------------------------------------------------
% Write and look for found faces in top 10 list
for i = 1:num_image
    image_out_name_full = image_out_name{i};
    [image_out_name_only, image_out_name_no_number] = ...
        removeformat (image_out_name_full);
    ranking_string = num2str(i);
    if i<10
        image_name_with_ranking = ...
            strcat({ranking_string},{'.  '},{image_out_name_only});
    else
        image_name_with_ranking = ...
            strcat({ranking_string},{'. '},{image_out_name_only});
    end
    image_out_name_display(i,1) = image_name_with_ranking;
    is_found = isnamefound(image_in_name_no_number, image_out_name_no_number);
    if is_found
        count = count + 1;
        image_matched_display(count, 1) = image_name_with_ranking;
    end
end
end


%%
% =========================================================================
% Function removeformat:
%   remove format of file name, for example 'abc.jpg' -> 'abc'
% =========================================================================
function [image_name, image_name_no_number] = ...
    removeformat (image_name_full)
C = strsplit(image_name_full,'.');    
image_name = C{1};
image_name_no_number = image_name(1:size(image_name,2)-1);
end


%%
% =========================================================================
% Function isnamefound:
%   check whether 2 images having same name or not
% =========================================================================
function is_found = isnamefound(image_in_name, image_out_name)
is_found = 0;
if strcmp(image_in_name, image_out_name)
    is_found = 1;
end
end
