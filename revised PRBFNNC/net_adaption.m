function [net]=net_adaption(net,error,error_dot,s)
dt=1e-3; P=100;
output_number=3;
[~,Phi]=RBFNN_output(net,error,error_dot);
for i=1:output_number
theta_dot(:,i)=P*Phi(i)*s(i);
net.theta(:,i)=theta_dot(:,i)*dt+net.theta(:,i);
end
end