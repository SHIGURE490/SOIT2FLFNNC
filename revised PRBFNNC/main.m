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
G1=zeros(6,length(time));
G2=zeros(6,length(time));
G3=zeros(6,length(time));
G4=zeros(6,length(time));
G5=zeros(6,length(time));
u1=zeros(6,length(time));
u2=zeros(6,length(time));
u3=zeros(6,length(time));

tau=zeros(6,length(time));
tau_max=100*ones(6,1);

mdl_puma560;
real_mdl_puma560;

Tc=0.75; Td=0.75;
m=[0.25 0.25 0.25 0.25 0.25 0.25]';
n=[0.25 0.25 0.25 0.25 0.25 0.25]';
iota=0.005;
u_max=[100;100;100;100;100;100];
epsilon_max=50;
lambda=5;
%%
for i=1:(length(time)-1)
    M0=p560.inertia(q(:,i)');
    
    error(:,i)=-q_desire(:,i)+q(:,i);
    derror(:,i)=-dq_desire(:,i)+dq(:,i);
    for j=1:6
       if abs(error(j,i))<=iota
           s(j,i)=derror(j,i)+1/(n(j)*Tc)*exp(abs(error(j,i))^n(j))*...
               ((1+n(j))*iota^(-n(j))*error(j,i)+(-n(j))*iota^(-1-n(j))*(abs(error(j,i)))^2*sign(error(j,i)));
       else
           s(j,i)=derror(j,i)+1/(n(j)*Tc)*exp(abs(error(j,i))^n(j))*...
               (abs(error(j,i)))^(1-n(j))*sign(error(j,i));
       end
    end


    if i==1
      [net] = net_init;
    end
     [net]=net_adaption(net,error(1:3,i),derror(1:3,i),s(1:3,i));
    [u_netoutput(:,i),~]=RBFNN_output(net,error(1:3,i),derror(1:3,i));
    
    G1(:,i)=-[u_netoutput(:,i);zeros(3,1)]-epsilon_max*tanh(s(:,i)/0.15)+ddq_desire(:,i);
    for j=1:3
        G2(j,i)=1/(n(j)*Tc^2)*abs(exp(2*error(j,i)))^n(j)*abs(error(j,i))^(1-n(j))*sign(error(j,i))-...
            (1-n(j))/(n(j)^2*Tc^2)*abs(exp(2*error(j,i)))^n(j)*abs(error(j,i))^(1-2*n(j))*sign(error(j,i));
    end
    for j=1:3
        G3(j,i)=1/(m(j)*Td)*abs(exp(s(j,i)))^(1-2*m(j))*abs(exp(error(j,i)))^(2*m(j))*sign(error(j,i))-lambda*sign(s(j,i));
    end
    
    for j=1:3
        G4(j,i)=(1-n(j))/(n(j)*Tc)*exp(abs(error(j,i))^n(j))*abs(error(j,i))^(-n(j))*derror(j,i)+...
            1/Tc*exp(abs(error(j,i))^n(j))*derror(j,i);
    end
    
    for j=1:3
        G5(j,i)=abs(error(j,i))^(n(j)-1)*derror(j,i)/Tc*exp(abs(error(j,i))^n(j))*...
            ((1+n(j))*iota^(-n(j))*error(j,i)+(-n(j))*(iota^(-1-n(j)))*abs(error(j,i))^2*sign(error(j,i)))+...
            1/(n(j)*Tc)*exp(abs(error(j,i))^n(j))*((1+n(j))*iota^(-n(j))*derror(j,i)+2*(-n(j))*iota^(-1-n(j))*abs(derror(j,i))*error(j,i));
    end
    u1(:,i)=M0*(G1(:,i)-G2(:,i)-G3(:,i));
    u2(:,i)=M0*(G1(:,i)-G4(:,i)-G3(:,i));
    u3(:,i)=M0*(G1(:,i)-G5(:,i)-G3(:,i));
    for j=1:6
        if s(j,i)==0
        u(j,i)=u1(j,i);
        elseif s(j,i)~=0 && abs(error(j,i))>iota
        u(j,i)=u2(j,i);
        else
        u(j,i)=u3(j,i);
        end
    end

    [tau(:,i)]=saturation(u(:,i),tau_max);

    [q(:,i+1),dq(:,i+1)] = simu_p560(real_p560,q(:,i),dq(:,i),tau(:,i),time(i));
    q(4:6,i+1)=q(4:6,1);

    disp([num2str(i/(length(time))*100,'%.2f'),'% completed.'])
end

save PRBFNNC.mat



