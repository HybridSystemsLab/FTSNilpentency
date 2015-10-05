%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Yuchun Li
%
% Project: A hybrid system with linear flow and jump
%
% Name: run.m
%
% Description: run script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all 

%%%%%%%% INITIALIZE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial conditions                                                  
%%% -----------------------
y0 = [3 3 1]';    

% simulation horizon
TSPAN = [0 10];
JSPAN = [0 200];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-4,'MaxStep',1e-4);

% simulate
[t y j] = hybridsolver(@f,@g,@C,@D,y0,TSPAN,JSPAN,rule);


% plot solution
figure 
subplot(211)
set(gca,'FontSize',30)
hold on
plotflows(t,j,y(:,1))
axis([0 4 -2 6])
subplot(212)
set(gca,'FontSize',30)
plotflows(t,j,y(:,2))
axis([0 4 -1 3])
grid on

% phase plot
figure
plotflowsphase(t,j,y(:,1),y(:,2))
axis([-1 5 -1 3.5])

