function [O,rule]=T1_output(rule,s)
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

mu=zeros(input_number,rule_number);
for i=1:input_number
    for j=1:rule_number
        mu(i,j)=exp(-(s(i)-rule.m(i,j))^2/rule.sigma(i,j)^2);
    end
end                                                   %模糊集上下隶属度

f=zeros(rule_number,1);

for k=1:rule_number
    f(k)=rule.lambda*prod(mu(:,k))+(1-rule.lambda)*rule.fs_past(k);
end

H=zeros(poly_number*rule_number,1);
for j=1:rule_number
    for nm=1:poly_number
        H((j-1)*poly_number+nm)=f(j)/sum(f)*PHI(nm);
    end
end

O=rule.v'*H;
rule.fs_past=f;

end