% =========================================================================
% This is the main function in Face Recognition to compute the accuracy 
% 	rate with different k
% =========================================================================
clear all; clc; close all

% -------------------------------------------------------------------------
% Initialize
dir_current = pwd;
dir_train = strcat(dir_current, '\Train');
dir_test = strcat(dir_current, '\Test');

% -------------------------------------------------------------------------
% Compute the accuracy rate with different k
array_accuracy_rate = computeaccuracywithdiffk (dir_train, dir_test);
plotaccuracyrate (array_accuracy_rate);