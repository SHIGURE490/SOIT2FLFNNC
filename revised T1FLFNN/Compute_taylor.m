function [Theta_m,Theta_sigma]=Compute_taylor(rule,s)
%IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 67, NO. 11, NOVEMBER
  %2020 eqn22
  poly_number=1+3*length(s); %后件多项式长度
  
  rule_number=size(rule.m,2);  %规则数量
  input_number=size(rule.m,1);  %输入长度
  
  Theta_m=zeros(rule_number*poly_number,rule_number*input_number);
  Theta_sigma=zeros(rule_number*poly_number,rule_number*input_number);
  
  [~,~,f,mu] = T1_output_nochange(rule,s);    %用于计算接下来使用的激活强度和隶属度函数

PHI(1)=1;
for i=1:length(s)
    PHI(1+(i-1)*3+1:1+(i-1)*3+3)=[s(i) sin(pi*s(i)) cos(pi*s(i))]';
end                                        %后件多项式

  for nk=1:rule_number
       for nm=1:poly_number
           for k=1:rule_number
               for j=1:input_number
                   if  nk==k
                       Theta_m((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*(sum(f)-f(k))/sum(f)^2*rule.lambda*prod(mu(:,k))*2*(s(j)-rule.m(j,k))/rule.sigma(j,k)^2;
                       Theta_sigma((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*((sum(f)-f(k))/sum(f)^2*rule.lambda*prod(mu(:,k))*2*(s(j)-rule.m(j,k))^2/rule.sigma(j,k)^3);
                   else
                       Theta_m((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*(-f(nk))/sum(f)^2*rule.lambda*prod(mu(:,k))*2*(s(j)-rule.m(j,k))/rule.sigma(j,k)^2;
                       Theta_sigma((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*((-f(nk))/sum(f)^2*rule.lambda*prod(mu(:,k))*2*(s(j)-rule.m(j,k))^2/rule.sigma(j,k)^3);
                   end
               end
           end
       end
   end
  
end