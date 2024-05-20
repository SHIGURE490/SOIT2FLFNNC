function [O,H,f,mu]=T1_output_nochange(rule,s)
poly_number=1+3*length(s);     %后件回归多项式长度

PHI=zeros(poly_number,1);

PHI(1)=1;
for i=1:length(s)
   PHI(1+(i-1)*3+1:1+(i-1)*3+3)=[s(i) sin(pi*s(i)) cos(pi*s(i))]';
end                                %后见回归多项式赋值使用三角函数展开

rule_number=size(rule.m,2);         %规则数
input_number=size(rule.m,1);        %输入数

mu=zeros(input_number,rule_number);
for i=1:input_number
    for j=1:rule_number
        mu(i,j)=exp(-(s(i)-rule.m(i,j))^2/rule.sigma(i,j)^2);
    end
end                                                   %模糊集上下隶属度

f=zeros(rule_number,1);           %规则上激活强度

for k=1:rule_number
    f(k)=rule.lambda*prod(mu(:,k))+(1-rule.lambda)*rule.fs_past(k);
end


H=zeros(poly_number*rule_number,1);
for j=1:rule_number
    for nm=1:poly_number
        H((j-1)*poly_number+nm)=f(j)/sum(f)*PHI(nm);
    end
end                                     %后件综合回归项
 
O=rule.v'*H;                            %输出
end