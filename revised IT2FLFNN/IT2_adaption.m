function [rule] = IT2_adaption(rule,s)

dt=1e-3;              %由于方便起见使用ODE1，所以直接时间步

nu_up_sigma=0.02; 
nu_down_sigma=0.01; 
nu_m=0.3;  
nu_beta=0.0005; 
nu_I=30; 
nu_P=0.5;                                              %各超参数

rule_number=size(rule.m,2);                %规则数
input_number=size(rule.m,1);               %输入数
output_number=length(s);                   %输出数

m=reshape(rule.m,[],1);                                    %将其按照矩阵列排成列向量

up_sigma=reshape(rule.up_sigma,[],1);
                                                           %将其按照矩阵列排成列向量
down_sigma=reshape(rule.down_sigma,[],1);
                                                           %将其按照矩阵列排成列向量

[~,H]=IT2_output_nochange(rule,s);  %eqn 40 H_hat IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 67, NO. 11, NOVEMBER 202

vP=zeros(length(H),output_number);
vI_dot=zeros(length(H),output_number);
for j=1:output_number
    vP(:,j)=s(j)*H;
    vI_dot(:,j)=s(j)*H;
end                                             %eqn40 41 IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 67, NO. 11, NOVEMBER 202

[Theta_m,Theta_sigma_up,Theta_sigma_down,Theta_beta]=Compute_taylor(rule,s);

m_dot=nu_m*(Theta_m'*rule.v*s);
up_sigma_dot=nu_up_sigma*(Theta_sigma_up'*rule.v*s);
down_sigma_dot=nu_down_sigma*(Theta_sigma_down'*rule.v*s);
beta_dot=nu_beta*(Theta_beta'*rule.v*s);

m=m_dot*dt+m;
up_sigma=up_sigma_dot*dt+up_sigma;
down_sigma=down_sigma_dot*dt+down_sigma;

rule.m=reshape(m,input_number,rule_number);
rule.up_sigma=reshape(up_sigma,input_number,rule_number);
rule.down_sigma=reshape(down_sigma,input_number,rule_number);
rule.beta=rule.beta+dt*beta_dot;

rule.vP=vP;
rule.vI=rule.vI+vI_dot*dt;
rule.v=nu_P*rule.vP+nu_I*rule.vI;

end