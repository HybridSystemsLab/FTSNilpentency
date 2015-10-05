function value = D(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% Project: Simulation of a hybrid system
%
% Name: D.m
%
% Description: Jump set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% state
xp   = x(1:3);

if xp(3) <= 0;  % jump condition 
    value = 1;  % report jump 
else
    value = 0;  % do not report jump
end