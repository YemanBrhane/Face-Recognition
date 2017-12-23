%%
% =========================================================================
% Function gui_selectimage:
%   return selected image path
% =========================================================================
function [image_in_path, image_in_name] = gui_selectimage()
[image_in_name, path]= uigetfile('*.*','Open Image');
if image_in_name ~= 0 
image_in_path = [path image_in_name];
end
end