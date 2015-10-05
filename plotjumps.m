function plotjumps(t,j,x)
%PLOTJUMPS   plot a Hybrid arc plot (1D).
%     PLOTJUMPS(t,j,x) plots (in red) the projection of the trajectory x
%     onto the jump time j. The initial and final value of the trajectory
%     on each interval [t_j,t_{j+1}] is denoted by * (in red) and the
%     continuous evolution of the trajectory on each interval is depicted
%     with a dashed line (in blue).
%
%   Example
%         % Generate a hybrid arc
%         % initial conditions
%         x1_0 = 1;
%         x2_0 = 0;
%         x0 = [x1_0;x2_0];
% 
%         % simulation horizon
%         TSPAN=[0 10];
%         JSPAN = [0 20];
% 
%         % rule for jumps
%         % rule = 1 -> priority for jumps
%         % rule = 2 -> priority for flows
%         rule = 1;
% 
%         options = odeset('RelTol',1e-6,'MaxStep',.1);
% 
%         % simulate
%         [t j x] = HyEQsolver( @f_ex1_2,@g_ex1_2,@C_ex1_2,@D_ex1_2,...
%             x0,TSPAN,JSPAN,rule,options);
%         L = x(:,2).^2*1/2+9.81.*x(:,1);
%         % plot solution
% 
%         figure(1) % position
%         clf
%         subplot(2,1,1),plotflows(t,j,x(:,1))
%         grid on
%         ylabel('x1')
% 
%         subplot(2,1,2),plotjumps(t,j,x(:,1))
%         grid on
%         ylabel('x1')
% 
%         figure(2) % velocity
%         clf
%         subplot(2,1,1),plotflows(t,j,x(:,2))
%         grid on
%         ylabel('x2')
% 
%         subplot(2,1,2),plotjumps(t,j,x(:,2))
%         grid on
%         ylabel('x2')
%           
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @ Hybrid Dynamics and Control Lab, 
% http://www.u.arizona.edu/~sricardo/index.php?n=Main.Software
% http://hybridsimulator.wordpress.com/
% Filename: plotjumps.m
%--------------------------------------------------------------------------
%   See also plotflows, plotHarc, plotHarcColor, plotHarcColor3D,
%   plotHybridArc, plotjumps.
%   Copyright @ Hybrid Dynamics and Control Lab,
%   Revision: 0.0.0.1 Date: 04/23/2014 10:48:24



% max (t,j) in simulation
T = t(length(t));
J = j(length(j));

% variables
Xarc = cell(J+1,1);
Tarc = cell(J+1,1);
Jarc = cell(J+1,1);
i = 1;
k = 1;
while i <= length(j),
   jcurrent = j(i);
   l = 0;
   clear xk tk jk;
   if (jcurrent < J)
      while (j(i+l) == jcurrent)
        xk(l+1) = x(i+l);
	tk(l+1) = t(i+l);
	jk(l+1) = j(i+l);
        l = l+1;
      end
   else
      for l=0:length(j)-i,
        xk(l+1) = x(i+l);
	tk(l+1) = t(i+l);
	jk(l+1) = j(i+l);
      end
      l = length(j)-i+1;
   end
   Xarc(jcurrent+1) = {xk};
   Tarc(jcurrent+1) = {tk};
   Jarc(jcurrent+1) = {jk};
   jcurrent;
   i = i+l;
end

hold on

for i = 1:J+1,
   xith = cell2mat(Xarc(i));
   tith = cell2mat(Tarc(i));
   tmax = tith(length(tith));
   jith = cell2mat(Jarc(i));
   jmax = jith(length(jith));
   xprev = xith(1);
   jprev = jith(1);
   xpost = xith(length(xith));
   jpost = jith(length(jith));
   pPrev = [jprev, xprev];
   pPost = [jpost, xpost];
   plot(jprev,xprev,'r*');
   hold on
   plot(jpost,xpost,'r*');
   plot(jprev*ones(1,length(tith)),xith,'b--');
end

set(gca,'XTick',linspace(0,J,J+1))
set(gca,'Box','on')
grid on
xlabel('jumps [j]')
