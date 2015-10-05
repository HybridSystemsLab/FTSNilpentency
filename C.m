function [value] = C(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% Project: Simulation of a hybrid system
%
% Name: C.m
%
% Description: Flow set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% state
xp   = x(1:3); 

if xp(3) >= 0   % flow condition 
    value = 1;  % report flow
else
    value = 0;  % do not report flow
end
