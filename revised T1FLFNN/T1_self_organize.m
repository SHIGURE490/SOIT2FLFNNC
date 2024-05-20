function [rule,threshold_init,threshold_delete] = T1_self_organize(rule,s)

sigma_init=0.5;

poly_number=1+3*length(s);     %后件回归项数目

epsilon_init=exp(-1); 
epsilon_delete=1e-5;           %规则生成和删除阈值

threshold_init=epsilon_init*(2/(1+exp(-norm(s)))-1);
threshold_delete=epsilon_delete*(2/(1+exp(-norm(s)))-1);      %规则生成和删除遵循sigmoid函数方法

[~,~,f,~] = T1_output_nochange(rule,s);      %计算当前时刻的激活强度
[min_gamma,min_index]=min(f);

if max(f)<threshold_init                               %若最大规则强度小于阈值则增加
    
    rule.m=[rule.m s];

    rule.sigma=[rule.sigma sigma_init*ones(length(s),1)];

    v_new=zeros(poly_number,length(s));
    
    rule.v=[rule.v;v_new];
    rule.vP=[rule.vP;v_new];
    rule.vI=[rule.vI;zeros(poly_number,length(s))];
    
    rule.fs_past=[rule.fs_past;1];
    
elseif min_gamma<threshold_delete                        %若最小规则强度小于阈值则删除
    
    rule.m(:,min_index)=[];

    rule.sigma(:,min_index)=[];

    rule.v((min_index-1)*poly_number+1:min_index*poly_number,:)=[];
    rule.vP((min_index-1)*poly_number+1:min_index*poly_number,:)=[];
    rule.vI((min_index-1)*poly_number+1:min_index*poly_number,:)=[];
    
    rule.fs_past(min_index)=[];
end
end