function [rule] = T1_adaption(rule,s)

dt=1e-3;              %由于方便起见使用ODE1，所以直接时间步

nu_sigma=0.02; 
nu_m=0.3;  
nu_I=15; 
nu_P=0.5;                                              %各超参数

rule_number=size(rule.m,2);                %规则数
input_number=size(rule.m,1);               %输入数
output_number=length(s);                   %输出数

m=reshape(rule.m,[],1);                                    %将其按照矩阵列排成列向量

sigma=reshape(rule.sigma,[],1);
                                                           %将其按照矩阵列排成列向量

[~,H]=T1_output_nochange(rule,s);  %eqn 40 H_hat IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 67, NO. 11, NOVEMBER 202

vP=zeros(length(H),output_number);
vI_dot=zeros(length(H),output_number);
for j=1:output_number
    vP(:,j)=s(j)*H;
    vI_dot(:,j)=s(j)*H;
end                                             %eqn40 41 IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 67, NO. 11, NOVEMBER 202

[Theta_m,Theta_sigma]=Compute_taylor(rule,s);

m_dot=nu_m*(Theta_m'*rule.v*s);
sigma_dot=nu_sigma*(Theta_sigma'*rule.v*s);


m=m_dot*dt+m;
sigma=sigma_dot*dt+sigma;

rule.m=reshape(m,input_number,rule_number);
rule.sigma=reshape(sigma,input_number,rule_number);

rule.vP=vP;
rule.vI=rule.vI+vI_dot*dt;
rule.v=nu_P*rule.vP+nu_I*rule.vI;

end