function [Theta_m,Theta_sigma_up,Theta_sigma_down,Theta_beta]=Compute_taylor(rule,s)
%IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS, VOL. 67, NO. 11, NOVEMBER
  %2020 eqn22
  poly_number=1;
  
  rule_number=size(rule.m,2);  %规则数量
  input_number=size(rule.m,1);  %输入长度
  
  Theta_m=zeros(rule_number*poly_number,rule_number*input_number);
  Theta_sigma_up=zeros(rule_number*poly_number,rule_number*input_number);
  Theta_sigma_down=zeros(rule_number*poly_number,rule_number*input_number);
  Theta_beta=zeros(rule_number*poly_number,1);               %各taylor展开系数，遵循上面那篇文章的标记
  
  [~,~,f_up,f_down,mu_up,mu_down] = IT2_output_nochange(rule,s);    %用于计算接下来使用的激活强度和隶属度函数

PHI(1)=1;
% for i=1:length(s)
%     PHI(1+(i-1)*3+1:1+(i-1)*3+3)=[s(i) sin(pi*s(i)) cos(pi*s(i))]';
% end                                        %后件多项式

  for nk=1:rule_number
       for nm=1:poly_number
          Theta_beta((nk-1)*poly_number+nm)=PHI(nm)*(f_up(nk)/sum(f_up)-f_down(nk)/sum(f_down));   
       end
  end
   
  for nk=1:rule_number
       for nm=1:poly_number
           for k=1:rule_number
               for j=1:input_number
                   if  nk==k
                       Theta_m((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*(rule.beta*(sum(f_up)-f_up(k))/sum(f_up)^2*rule.lambda*prod(mu_up(:,k))*2*(s(j)-rule.m(j,k))/rule.up_sigma(j,k)^2+...
                           (1-rule.beta)*(sum(f_down)-f_down(k))/sum(f_down)^2*rule.lambda*prod(mu_down(:,k))*2*(s(j)-rule.m(j,k))/rule.down_sigma(j,k)^2);
                       Theta_sigma_up((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*(rule.beta*(sum(f_up)-f_up(k))/sum(f_up)^2*rule.lambda*prod(mu_up(:,k))*2*(s(j)-rule.m(j,k))^2/rule.up_sigma(j,k)^3);
                       Theta_sigma_down((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*((1-rule.beta)*(sum(f_down)-f_down(k))/sum(f_down)^2*f_down(k)*rule.lambda*prod(mu_down(:,k))*2*(s(j)-rule.m(j,k))^2/rule.down_sigma(j,k)^3);
                   else
                       Theta_m((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*(rule.beta*(-f_up(nk))/sum(f_up)^2*rule.lambda*prod(mu_up(:,k))*2*(s(j)-rule.m(j,k))/rule.up_sigma(j,k)^2+...
                           (1-rule.beta)*(-f_down(nk))/sum(f_down)^2*rule.lambda*prod(mu_down(:,k))*2*(s(j)-rule.m(j,k))/rule.down_sigma(j,k)^2);
                       Theta_sigma_up((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*(rule.beta*(-f_up(nk))/sum(f_up)^2*rule.lambda*prod(mu_up(:,k))*2*(s(j)-rule.m(j,k))^2/rule.up_sigma(j,k)^3);
                       Theta_sigma_down((nk-1)*poly_number+nm,(k-1)*input_number+j)=PHI(nm)*((1-rule.beta)*(-f_down(nk))/sum(f_down)^2*rule.lambda*prod(mu_down(:,k))*2*(s(j)-rule.m(j,k))^2/rule.down_sigma(j,k)^3);
                   end
               end
           end
       end
   end
  
end