%%
% =========================================================================
% Function plotaccuracyrate:
%   plot accuracy rate
% =========================================================================
function plotaccuracyrate (array_accuracy_rate)
x = 1:40;
y = array_accuracy_rate(1:40,1);
figure; plot(x,y); title('Accuracy rate with different k'); xlim([1 40]);
end