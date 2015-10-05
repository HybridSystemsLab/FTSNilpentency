function xplus = g(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% Project: Simulation of a hybrid system
%
% Name: g.m
%
% Description: Jump map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% global data -----------
AA = [0 1 0;-1 0 0;0 0 0];
BB = [0 0 -1]';
G0 = [2/5 -1/5;4/5 -2/5];
GG = G0*inv(expm([0 1;-1 0]));

% state
xp   = x(1:3); 

% jump map
xpplus  = [GG zeros(2,1);zeros(1,3)]*xp + [0 0 1]'; 

xplus = [xpplus];   
end