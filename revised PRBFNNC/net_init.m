function [net] = net_init
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
node_number=11;
input_number=3;
net.mu=zeros(input_number,node_number,2);
for i=1:input_number
net.mu(i,1,:)=[-1.25 -1.25];
net.mu(i,2,:)=[-1 -1];
net.mu(i,3,:)=[-0.75 -0.75];
net.mu(i,4,:)=[-0.5 -0.5];
net.mu(i,5,:)=[-0.25 -0.25];
net.mu(i,6,:)=[0 0];
net.mu(i,7,:)=[0.25 0.25];
net.mu(i,8,:)=[0.5 0.5];
net.mu(i,9,:)=[0.75 0.75];
net.mu(i,10,:)=[1 1];
net.mu(i,11,:)=[1.25 1.25];
end
net.b=0.25;
net.theta=zeros(node_number,input_number);
end

