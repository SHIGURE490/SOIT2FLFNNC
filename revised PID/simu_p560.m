function [q_output,dq_output] = simu_p560(real_p560,q,dq,tau,t)
%SIMUA 3自由度机械臂
%
%   此处显示详细说明
dt=1e-3; %仿真步长

if t<10
    F=[0.3*dq(1)+1.2*sin(2*q(1))+2*sign(dq(1));
       0.8*dq(2)+2.3*sin(3*q(2))-3*sign(dq(2));
       0.5*dq(3)-1.5*cos(2*q(3))+0.8*sign(dq(3));
       zeros(3,1)];
else
    F=[0.3*dq(1)+1.2*sin(2*q(1))+7*sign(dq(1));
       0.8*dq(2)+2.3*sin(3*q(2))-9*sign(dq(2));
       0.5*dq(3)-1.5*cos(2*q(3))+5*sign(dq(3));
       zeros(3,1)];
end

tau_ex=[3*sin(t)+3*cos(10*pi*t);
        cos(t)^2-2*sin(10*pi*t);
        sin(t)^2+4*cos(10*pi*t);
        zeros(3,1)];

if t<10
    eta=zeros(6,1);
else
    eta=[6*sin(q(1)*q(2))+15*cos(q(1)*dq(2))+1;
        8*cos(q(1)*q(2))+13*sin(dq(1)*dq(2))+3;
        2*sin(q(2)*q(3))-19*sin(dq(2)*dq(3))+6;
        zeros(3,1)];
end

tau_d=F+eta+tau_ex;

real_tau=tau-tau_d;
ddq=real_p560.accel(q',dq',real_tau');
dq_output=ddq*dt+dq;
q_output=dq*dt+q;

end