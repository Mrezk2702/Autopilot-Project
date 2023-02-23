%% clearing Workspace
clc;clear vars;close all

%% INPUT data
t0=0;
tf=20;
n=100;
dt=(tf-t0)/(n-1);
t_vec= t0:dt:tf;
y=[-1;1];
y_func=@(t,y)[sin(t)+cos(y(1))+sin(y(2));cos(t)+sin(y(2))];
y_vec=y_func(t0,y)

%% Solver
for i=1:n-1
    
    k1=y_func(t_vec(i),y_vec(:,i));
    k2=y_func(t_vec(i)+dt/2,y_vec(:,i)+dt*k1/2);
    k3=y_func(t_vec(i)+dt/2,y_vec(:,i)+dt*k2/2);
    k4=y_func(t_vec(i)+dt,y_vec(:,i)+dt*k3);
    y_vec(:,i+1)=y_vec(:,i)+1/6*dt*(k1+2*k2+2*k3+k4);


end

[t_ODEvec, y_ODEvec]=ode45 (y_func,[t0 tf],y_func(t0,y));

%%simulink
simulation=sim("Model.slx");
%%plotting
f1=figure;

plot(t_vec,y_vec(1,:),'--',LineWidth=1);
hold on; grid
plot(t_ODEvec,y_ODEvec(:,1),LineWidth=0.5);
plot(simulation.tout,simulation.y_sim(:,1),'c',LineWidth=0.5);
xlabel('Time (s)')
ylabel('y1')
legend('Range Kutta Numerical Solver','ODE45 Solver','SIMULINK')
f2=figure;
plot(t_vec,y_vec(2,:),'--',LineWidth=1);
hold on; grid
plot(t_ODEvec,y_ODEvec(:,2),LineWidth=0.5);
plot(simulation.tout,simulation.y_sim(:,2),'g',LineWidth=1);
xlabel('Time (s)');
ylabel('y2');
legend('Range Kutta Numerical Solver','ODE45 Solver','SIMULINK')
