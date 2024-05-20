clear all;
close all;
clc;
%%
dt=1e-3;
time=0:dt:20;

q=zeros(6,length(time));
dq=zeros(6,length(time));

q_desire=[sin(time/5*pi+pi/6);
    1.2*cos(pi*time/5)-0.7;
    0.6*sin(pi*time/5-pi/6)-0.1;
    zeros(3,length(time))];
dq_desire=[pi/5*cos(time/5*pi+pi/6);
    -1.2*pi/5*sin(pi*time/5);
    0.6*pi/5*cos(pi*time/5-pi/6);
    zeros(3,length(time))];
ddq_desire=[-(pi/5)^2*sin(time/5*pi+pi/6);
    -1.2*(pi/5)^2*sin(pi*time/5);
    -0.6*(pi/5)^2*sin(pi*time/5-pi/6);
    zeros(3,length(time))];

error=zeros(6,length(time));
derror=zeros(6,length(time));
error_int=zeros(6,length(time));

u=zeros(6,length(time));

tau=zeros(6,length(time));
tau_max=100*ones(6,1);

mdl_puma560;
real_mdl_puma560;

K_p=diag([750 750 750 0 0 0]); K_i=diag([200 200 200 0 0 0]); 
K_d=diag([100 100 100 0 0 0]);
%%

for i=1:(length(time)-1)
    
    error(:,i)=q_desire(:,i)-q(:,i);
    derror(:,i)=dq_desire(:,i)-dq(:,i);
    if i==1
         error_int(:,i)=error(:,i)*dt;
    else
         error_int(:,i)=error(:,i)*dt+error(:,i-1);
    end
    
    u(:,i)=K_p*error(:,i)+K_d*derror(:,i)+K_i*error_int(:,i);

    [tau(:,i)]=saturation(u(:,i),tau_max);

    [q(:,i+1),dq(:,i+1)] = simu_p560(real_p560,q(:,i),dq(:,i),tau(:,i),time(i));
    q(4:6,i+1)=q(4:6,1);

    disp([num2str(i/(length(time))*100,'%.2f'),'% completed.'])
end

save PID.mat


