function [O,H,f_up,f_down,mu_up,mu_down]=IT2_output_nochange(rule,s)
poly_number=1+3*length(s);     %后件回归多项式长度

PHI=zeros(poly_number,1);

PHI(1)=1;
for i=1:length(s)
   PHI(1+(i-1)*3+1:1+(i-1)*3+3)=[s(i) sin(pi*s(i)) cos(pi*s(i))]';
end                                %后见回归多项式赋值使用三角函数展开

rule_number=size(rule.m,2);         %规则数
input_number=size(rule.m,1);        %输入数

mu_up=zeros(input_number,rule_number);
mu_down=zeros(input_number,rule_number);
for i=1:input_number
    for j=1:rule_number
        mu_up(i,j)=exp(-(s(i)-rule.m(i,j))^2/rule.up_sigma(i,j)^2);
        mu_down(i,j)=exp(-(s(i)-rule.m(i,j))^2/rule.down_sigma(i,j)^2);
    end
end                                                   %模糊集上下隶属度

f_up=zeros(rule_number,1);           %规则上激活强度
f_down=zeros(rule_number,1);         %规则下激活强度

for k=1:rule_number
    f_up(k)=rule.lambda*prod(mu_up(:,k))+(1-rule.lambda)*rule.fs_past_up(k);
end

for k=1:rule_number
    f_down(k)=rule.lambda*prod(mu_down(:,k))+(1-rule.lambda)*rule.fs_past_down(k);
end                                        %layer 3 上下激活强度

H=zeros(poly_number*rule_number,1);
for j=1:rule_number
    for nm=1:poly_number
        H((j-1)*poly_number+nm)=(rule.beta*f_up(j)/sum(f_up)+(1-rule.beta)*f_down(j)/sum(f_down))*...
            PHI(nm);
    end
end                                     %后件综合回归项
 
O=rule.v'*H;                            %输出
end