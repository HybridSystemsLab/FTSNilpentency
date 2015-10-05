function plotflows(t,j,x)
%PLOTFLOWS  plot a Hybrid arc plot (1D).
%     PLOTFLOWS(t,j,x) plots (in blue) the projection of the trajectory x
%     onto the flow time axis t.  The value of the trajectory for intervals
%     [t_j,t_{j+1}] with empty interior is marked with * (in blue).  Dashed
%     lines (in red) connect the value of the trajectory before and after
%     the jump.
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
% Filename: plotflows.m
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

xith = cell2mat(Xarc(1));
tith = cell2mat(Tarc(1));
xprev = xith(length(xith));
tprev = tith(length(tith));
for i = 1:J+1,
   xith = cell2mat(Xarc(i));
   tith = cell2mat(Tarc(i));
   tmax = tith(length(tith));
   jith = cell2mat(Jarc(i));
   jmax = jith(length(jith));
   if(length(jith)==1)
       plot(tith,xith,'b','LineWidth',2)
   else
       aa=length(tith);
       tith = tith(2:aa);
       aa=length(xith);
       xith = xith(2:aa);
       plot(tith,xith,'b','LineWidth',2)
   end
   hold on
   if (i>=2) & (i<=J+1)
       xpost = xith(1);
       tpost = tith(1);
       pPrev = [tprev, xprev];
       pPost = [tpost, xpost];
       plot([tprev tprev],[xprev xpost],'r--');
       xprev = xith(length(xith));
       tprev = tith(length(tith));
   end
   hold on
end

xlabel('t')
grid on
set(gca,'Box','on')