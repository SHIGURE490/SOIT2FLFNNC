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

s=zeros(6,length(time));

u=zeros(6,length(time));
u_eq1=zeros(6,length(time));
u_eq2=zeros(6,length(time));
u_sw=zeros(6,length(time));

tau=zeros(6,length(time));
tau_max=100*ones(6,1);

mdl_puma560;
real_mdl_puma560;

alpha=0.5; p1=1; T1=0.75; q1=1; mu1=1;
T2=0.75; beta=0.5; mu2=1; p2=1; q2=1;
delta=5e-3;
tho=1;

epsilon=2;
%%

for i=1:(length(time)-1)
    M0=p560.inertia(q(:,i)');
    C0=p560.coriolis(q(:,i)',dq(:,i)');
    G0=p560.gravload(q(:,i)');
    
    error(:,i)=-q_desire(:,i)+q(:,i);
    derror(:,i)=-dq_desire(:,i)+dq(:,i);
    
    s(:,i)=derror(:,i)+pi/(alpha*T1)*error(:,i)+pi*p1/(alpha*mu1*T1*sqrt(p1*q1))*(1/2)^(1-alpha/2)*(abs(error(:,i)).^(1-alpha)...
        .*sign(error(:,i)))+pi*q1*mu1/(alpha*T1*sqrt(p1*q1))*(1/2)^(1+alpha/2)*(abs(error(:,i)).^(1+alpha).*sign(error(:,i)));
    
    u_eq1(:,i)=-inv(M0)*C0*dq(:,i)-inv(M0)*G0'-ddq_desire(:,i)+pi/(alpha*T1)*derror(:,i)+...
        pi*q1*mu1/(alpha*T1*sqrt(p1*q1))*(1/2)^(1+alpha/2)*(1+alpha)*abs(error(:,i)).^(alpha).*derror(:,i);

    for j=1:6
        if abs(error(j,i))>delta
            u_eq2(j,i)=pi*p1/(alpha*mu1*T1*sqrt(p1*q1))*(1/2)^(1-alpha/2)*(1-alpha)*abs(error(j,i)).^(-alpha).*derror(j,i);
        else
            u_eq2(j,i)=pi*p1/(alpha*mu1*T1*sqrt(p1*q1))*(1/2)^(1-alpha/2)*(1-alpha)*(delta.^(-alpha).*derror(j,i));
        end
    end

    k1=1/T2*pi/beta; k2=p2/sqrt(p2*q2)*1/(mu2*T2)*pi/beta*(1/2)^(1-beta/2);
    k3=q2/sqrt(p2*q2)*1/(mu2*T2)*pi/beta*(1/2)^(1+beta/2);
    if norm(s(:,i))>tho
    u_sw(:,i)=k1*s(:,i)+k2*abs(s(:,i)).^(1-beta).*sign(s(:,i))+k3*abs(s(:,i)).^(1+beta).*sign(s(:,i))+...
        epsilon*sign(s(:,i));
    else
        u_sw(:,i)=k1*s(:,i)+k2*abs(s(:,i)).^(1-beta).*s(:,i)/tho+k3*abs(s(:,i)).^(1+beta).*s(:,i)/tho+...
        epsilon*s(:,i)/tho;
    end
    

    u(:,i)=-M0*(u_eq1(:,i)+u_eq2(:,i)+u_sw(:,i));
    [tau(:,i)]=saturation(u(:,i),tau_max);

    [q(:,i+1),dq(:,i+1)] = simu_p560(real_p560,q(:,i),dq(:,i),tau(:,i),time(i));
    q(4:6,i+1)=q(4:6,1);

    disp([num2str(i/(length(time))*100,'%.2f'),'% completed.'])
end

save ROBUSTPTC.mat

