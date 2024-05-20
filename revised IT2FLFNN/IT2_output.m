function [O,rule]=IT2_output(rule,s)
% 注意这个rule必须输出否则规则上下隶属度不会发生变化
% 一列代表一个规则
poly_number=1+3*length(s);           %拟合多项式长度

PHI=zeros(poly_number,1);            %后件拟合多项式向量

PHI(1)=1;

for i=1:length(s)
   PHI(1+(i-1)*3+1:1+(i-1)*3+3)=[s(i) sin(pi*s(i)) cos(pi*s(i))]';
end                                  %后件拟合多项式赋值

rule_number=size(rule.m,2);          %规则数
input_number=size(rule.m,1);         %输入数        

mu_up=zeros(input_number,rule_number);
mu_down=zeros(input_number,rule_number);
for i=1:input_number
    for j=1:rule_number
        mu_up(i,j)=exp(-(s(i)-rule.m(i,j))^2/rule.up_sigma(i,j)^2);
        mu_down(i,j)=exp(-(s(i)-rule.m(i,j))^2/rule.down_sigma(i,j)^2);
    end
end                                                   %模糊集上下隶属度

f_up=zeros(rule_number,1);
f_down=zeros(rule_number,1);

for k=1:rule_number
    f_up(k)=rule.lambda*prod(mu_up(:,k))+(1-rule.lambda)*rule.fs_past_up(k);
end
for k=1:rule_number
    f_down(k)=rule.lambda*prod(mu_down(:,k))+(1-rule.lambda)*rule.fs_past_down(k);
end

H=zeros(poly_number*rule_number,1);
for j=1:rule_number
    for nm=1:poly_number
        H((j-1)*poly_number+nm)=(rule.beta*f_up(j)/sum(f_up)+(1-rule.beta)*f_down(j)/sum(f_down))*...
            PHI(nm);
    end
end

O=rule.v'*H;
rule.fs_past_up=f_up;
rule.fs_past_down=f_down;                 %更新过去的激活强度

end