function [net_output,Phi]=RBFNN_output(net,error,error_dot)
input_number=3; output_number=3; node_number=11;
for i=1:3
   z(i,:)=[error(i) error_dot(i)];
end
Phi=zeros(node_number,input_number);
for i=1:input_number
for j=1:node_number
Phi(j,i)=exp(-((z(i,1)-net.mu(i,j,1))*(z(i,1)-net.mu(i,j,1))+(z(i,2)-net.mu(i,j,2))*(z(i,2)-net.mu(i,j,2)))/net.b^2);
end
for k=1:output_number
net_output(k)=net.theta(:,k)'*Phi(:,k);
end
end