function [rule]=T1_init(s)
%每一列代表一个二型模糊规则

%function link使用三角函数展开
poly_number=1+3*length(s);      %网络后件用于拟合的多项式长度

rule.m=s;                         %RFNN中心

rule.sigma=0.3*ones(length(s),1);    %RFNN的上下方差

rule.fs_past=1;                         %用于记载过去的激活强度

     %后件对应系数，初始值可取随机或0
rule.v=zeros(poly_number,length(s));    

rule.vP=rule.v;                            %后件对应比例项和
rule.vI=zeros(poly_number,length(s));      %后件对应积分项和

rule.lambda=0.85;                          %循环激活强度参数

end