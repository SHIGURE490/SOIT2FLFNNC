function [tau]=saturation(u,tau_max)
%u为列向量,u_max也为列向量
tau=zeros(length(u),1);
for i=1:length(u)
    if u(i)>=tau_max(i)
        tau(i)=tau_max(i)*sign(u(i));
    elseif u(i)<=-tau_max(i)
        tau(i)=tau_max(i)*sign(u(i));
    else
        tau(i)=u(i);
    end
end
end