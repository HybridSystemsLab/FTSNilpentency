function xdot = f(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% Project: Simulation of a hybrid system
%
% Name: f.m
%
% Description: Flow map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% global data 
AA = [0 1 0;-1 0 0;0 0 0];
BB = [0 0 -1]';

% state
xp = x(1:3); 

% flow map
xpdot = AA*xp  + BB;

xdot = [xpdot];      
end