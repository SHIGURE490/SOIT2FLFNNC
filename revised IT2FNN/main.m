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

error_S_alpha=zeros(6,length(time));
error_Sig_alpha=zeros(6,length(time));
error_F_alpha=zeros(6,length(time));
error_D_alpha=zeros(6,length(time));
s=zeros(6,length(time));

s_Sig_kappa1=zeros(6,length(time));
s_Sig_kappa2=zeros(6,length(time));

u=zeros(6,length(time));
u_sm=zeros(6,length(time));
u_IT2=zeros(6,length(time));
u_nc=zeros(6,length(time));
u_sa=zeros(6,length(time));

tau=zeros(6,length(time));
tau_max=100*ones(6,1);

mdl_puma560;
real_mdl_puma560;

alpha=0.5; Te=0.75;
kappa=0.5; Ts=0.75;
varepsilon1=3;
varepsilon2=1;
delta=0.005;
tho=0.2;

rule_number_vec=zeros(1,length(time));
threshold_init=zeros(1,length(time));
threshold_delete=zeros(1,length(time));
BMM_q=zeros(1,length(time));
weight=zeros(1,length(time));

n=3;

for i=1:(length(time)-1)
    M0=p560.inertia(q(:,i)');
    C0=p560.coriolis(q(:,i)',dq(:,i)');
    G0=p560.gravload(q(:,i)');
    
    error(:,i)=q_desire(:,i)-q(:,i);
    derror(:,i)=dq_desire(:,i)-dq(:,i);
    for j=1:6
        if error(j,i)>delta
            error_S_alpha(j,i)=power(abs(error(j,i)),(1-alpha))*sign(error(j,i));
        else
            error_S_alpha(j,i)=delta^(-alpha)*error(j,i);
        end
    end
    error_Sig_alpha(:,i)=power(abs(error(:,i)),(1+alpha)).*sign(error(:,i)); 

    for j=1:6
        if abs(error(j,i))>delta
            error_F_alpha(j,i)=(1-alpha)*abs(power(error(j,i),-alpha))*derror(j,i);
        else
            error_F_alpha(j,i)=delta^(-alpha)*derror(j,i);
        end
    end
    error_D_alpha(:,i)=(1+alpha)*abs(power(error(:,i),alpha)).*derror(:,i);

    s(:,i)=derror(:,i)+1/(Te*alpha)*(2*error(:,i)+error_S_alpha(:,i)+error_Sig_alpha(:,i));
    s_Sig_kappa1(:,i)=power(abs(s(:,i)),(1-kappa)).*sign(s(:,i));
    s_Sig_kappa2(:,i)=(n+1)^(kappa/2)*power(abs(s(:,i)),(1+kappa)).*sign(s(:,i));

    u_sm(:,i)=1/(Te*alpha)*M0*(2*derror(:,i)+error_F_alpha(:,i)+error_D_alpha(:,i))+...
        1/(Ts*kappa)*M0*(2*s(:,i)+s_Sig_kappa1(:,i)+s_Sig_kappa2(:,i))+...
        M0*ddq_desire(:,i)+C0*dq(:,i)+G0';

    input=s(1:3,i);  
    if i==1
        [rule]=IT2_init(input);
    else
        [rule,threshold_init(i),threshold_delete(i)] = IT2_self_organize(rule,input);
    end

    [rule] = IT2_adaption(rule,input);

    [O,rule]=IT2_output(rule,input);

    u_IT2(:,i)=M0*[O;zeros(3,1)];

    if norm(s(:,i))>tho
        u_nc(:,i)=M0*varepsilon1*sign(s(:,i))+1/(Ts*kappa)*M0*s(:,i)/(norm(s(:,i))^2)*(2*varepsilon2+(varepsilon2)^(1-kappa/2)+4^(kappa/2)*(varepsilon2)^(1+kappa/2));
        u_sa(:,i)=norm(u_sm(:,i)+u_IT2(:,i)+u_nc(:,i))/norm(s(:,i))*(1-0.65)*s(:,i);
    else
        u_nc(:,i)=M0*varepsilon1*s(:,i)/tho+1/(Ts*kappa)*M0*s(:,i)/tho^2*(2*varepsilon2+(varepsilon2)^(1-kappa/2)+4^(kappa/2)*(varepsilon2)^(1+kappa/2));
        u_sa(:,i)=norm(u_sm(:,i)+u_IT2(:,i)+u_nc(:,i))/tho*(1-0.65)*s(:,i);
    end

    u(:,i)=u_sm(:,i)+u_IT2(:,i)+u_nc(:,i)+u_sa(:,i);
    [tau(:,i)]=saturation(u(:,i),tau_max);

    [q(:,i+1),dq(:,i+1)] = simu_p560(real_p560,q(:,i),dq(:,i),tau(:,i),time(i));
    q(4:6,i+1)=q(4:6,1);
    rule_number_vec(i)=size(rule.m,2);
    BMM_q(i)=rule.beta;
    weight(i)=trace(rule.vI'*rule.vI);


    disp([num2str(i/(length(time))*100,'%.2f'),'% completed.'])
end

save IT2FNN.mat


