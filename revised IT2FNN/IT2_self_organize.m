function [rule,threshold_init,threshold_delete] = IT2_self_organize(rule,s)

up_sigma_init=0.5;
down_sigma_init=0.25;          %规则生成初始值

poly_number=1;     %后件回归项数目

epsilon_init=exp(-0.5); 
epsilon_delete=1e-5;           %规则生成和删除阈值

threshold_init=epsilon_init*(2/(1+exp(-norm(s)))-1);
threshold_delete=epsilon_delete*(2/(1+exp(-norm(s)))-1);      %规则生成和删除遵循sigmoid函数方法

[~,~,f_up,f_down,~,~] = IT2_output_nochange(rule,s);      %计算当前时刻的激活强度
gamma=rule.beta*f_up+(1-rule.beta)*f_down;
[min_gamma,min_index]=min(gamma);

if max(gamma)<threshold_init                               %若最大规则强度小于阈值则增加
    
    rule.m=[rule.m s];

    rule.up_sigma=[rule.up_sigma up_sigma_init*ones(length(s),1)];

    rule.down_sigma=[rule.down_sigma down_sigma_init*ones(length(s),1)];

    v_new=zeros(poly_number,length(s));
    
    rule.v=[rule.v;v_new];
    rule.vP=[rule.vP;v_new];
    rule.vI=[rule.vI;zeros(poly_number,length(s))];
    
    rule.fs_past_up=[rule.fs_past_up;1];
    rule.fs_past_down=[rule.fs_past_down;1];
    
elseif min_gamma<threshold_delete                        %若最小规则强度小于阈值则删除
    
    rule.m(:,min_index)=[];

    rule.up_sigma(:,min_index)=[];

    rule.down_sigma(:,min_index)=[];

    rule.v((min_index-1)*poly_number+1:min_index*poly_number,:)=[];
    rule.vP((min_index-1)*poly_number+1:min_index*poly_number,:)=[];
    rule.vI((min_index-1)*poly_number+1:min_index*poly_number,:)=[];
    
    rule.fs_past_up(min_index)=[];
    rule.fs_past_down(min_index)=[];
end
end