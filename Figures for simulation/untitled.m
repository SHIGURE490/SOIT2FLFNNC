clear all;
close all;
clc;
%%
load IT2FLFNN.mat
error0_IT2FLFNN=error(1,:);
error1_IT2FLFNN=error(2,:);
error2_IT2FLFNN=error(3,:);
tau0_IT2FLFNN=tau(1,:);
tau1_IT2FLFNN=tau(2,:);
tau2_IT2FLFNN=tau(3,:);
threshold_gen=threshold_init;
threshold_del=threshold_delete;
Q_I_IT2FLFNN=weight;
rule_number=rule_number_vec; 
s_0_IT2FLFNN=s(1,:);
s_1_IT2FLFNN=s(2,:);
s_2_IT2FLFNN=s(3,:);
load IT2FNN.mat
error0_IT2FNN=error(1,:);
error1_IT2FNN=error(2,:);
error2_IT2FNN=error(3,:);
tau0_IT2FNN=tau(1,:);
tau1_IT2FNN=tau(2,:);
tau2_IT2FNN=tau(3,:);
Q_I_IT2FNN=weight;
s_0_IT2FNN=s(1,:);
s_1_IT2FNN=s(2,:);
s_2_IT2FNN=s(3,:);
load T1FLFNN.mat
error0_T1FLFNN=error(1,:);
error1_T1FLFNN=error(2,:);
error2_T1FLFNN=error(3,:);
tau0_T1FLFNN=tau(1,:);
tau1_T1FLFNN=tau(2,:);
tau2_T1FLFNN=tau(3,:);
Q_I_T1FLFNN=weight;
s_0_T1FLFNN=s(1,:);
s_1_T1FLFNN=s(2,:);
s_2_T1FLFNN=s(3,:);
load PID.mat
error0_pid=error(1,:);
error1_pid=error(2,:);
error2_pid=error(3,:);
tau0_pid=tau(1,:);
tau1_pid=tau(2,:);
tau2_pid=tau(3,:); %28789
load PRBFNNC.mat
error0_PRBFNNC=error(1,:);
error1_PRBFNNC=error(2,:);
error2_PRBFNNC=error(3,:);
tau0_PRBFNNC=tau(1,:);
tau1_PRBFNNC=tau(2,:);
tau2_PRBFNNC=tau(3,:); %27348
load ROBUSTPTC.mat
error0_ROBUSTPTC=error(1,:);
error1_ROBUSTPTC=error(2,:);
error2_ROBUSTPTC=error(3,:);
tau0_ROBUSTPTC=tau(1,:);
tau1_ROBUSTPTC=tau(2,:);
tau2_ROBUSTPTC=tau(3,:); %28789

% %%
% figure1=figure('WindowState','maximized');
% clf;
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes1,'on');
% grid on;
% hold on;
% h1 = plot(time(1:end-1), error0_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), error0_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), error0_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time(1:end-1), error0_pid(1:end-1),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time(1:end-1), -error0_PRBFNNC(1:end-1),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time(1:end-1), -error0_ROBUSTPTC(1:end-1),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes1,'on');
% hold(axes1,'off');
% % 创建 legend
% set(axes1,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend1 = legend(axes1,'show');
% set(legend1,'NumColumns',2,'AutoUpdate','off','FontSize',24);
% line([1.5,1.5],[-0.2,0.6],'linestyle','--','linewidth',3,'color','k')
% Str = 'Error predefined-time threshold $T_s+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% ylabel('Error of joint 1/rad');
% zp = BaseZoom();
% zp.plot;
% zp1 = BaseZoom();
% zp1.plot;
% %%
% figure2=figure('WindowState','maximized');
% clf;
% axes2 = axes('Parent',figure2,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes2,'on');
% grid on;
% hold on;
% h1 = plot(time(1:end-1), error1_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), error1_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), error1_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time(1:end-1), error1_pid(1:end-1),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time(1:end-1), -error1_PRBFNNC(1:end-1),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time(1:end-1), -error1_ROBUSTPTC(1:end-1),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes2,'on');
% hold(axes2,'off');
% % 创建 legend
% set(axes2,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend2 = legend(axes2,'show');
% set(legend2,'NumColumns',2,'AutoUpdate','off','FontSize',24);
% line([1.5,1.5],[-0.2,0.6],'linestyle','--','linewidth',3,'color','k')
% Str = 'Error predefined-time threshold $T_s+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% ylabel('Error of joint 2/rad');
% zp = BaseZoom();
% zp.plot;
% zp1 = BaseZoom();
% zp1.plot;
%%
% figure3=figure('WindowState','maximized');
% clf;
% axes3 = axes('Parent',figure3,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes3,'on');
% grid on;
% hold on;
% h1 = plot(time(1:end-1), error2_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), error2_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), error2_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time(1:end-1), error2_pid(1:end-1),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time(1:end-1), -error2_PRBFNNC(1:end-1),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time(1:end-1), -error2_ROBUSTPTC(1:end-1),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes3,'on');
% hold(axes3,'off');
% % 创建 legend
% set(axes3,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend3 = legend(axes3,'show');
% set(legend3,'NumColumns',2,'AutoUpdate','off','FontSize',24);
% line([1.5,1.5],[-0.4,0.2],'linestyle','--','linewidth',3,'color','k')
% Str = 'Error predefined-time threshold $T_s+T_e=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% ylabel('Error of joint 3/rad');
% zp = BaseZoom();
% zp.plot;
% zp1 = BaseZoom();
% zp1.plot;
%%
% figure4=figure('WindowState','maximized');
% clf;
% axes4 = axes('Parent',figure4,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes4,'on');
% grid on;
% hold on;
% h1 = plot(time(1:end-1), tau0_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), tau0_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), tau0_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time(1:end-1), tau0_pid(1:end-1),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time(1:end-1), tau0_PRBFNNC(1:end-1),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time(1:end-1), tau0_ROBUSTPTC(1:end-1),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% upperlimit0=[100 100];
% lowerlimit0=[-100 -100];
% line([0 20],upperlimit0,'linestyle','--','color','r','linewidth',2)
% line([0 20],lowerlimit0,'linestyle','--','color','r','linewidth',2)
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Torque of joint 1/N \cdot m');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes4,'on');
% hold(axes4,'off');
% % 创建 legend
% set(axes4,'FontName','Times New Roman','FontSize',36);
% legend4 = legend(axes4,'show');
% set(legend4,'NumColumns',2,'AutoUpdate','off','FontSize',24);
%%
% figure5=figure('WindowState','maximized');
% clf;
% axes5 = axes('Parent',figure5,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes5,'on');
% grid on;
% hold on;
% h1 = plot(time(1:end-1), tau1_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), tau1_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), tau1_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time(1:end-1), tau1_pid(1:end-1),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time(1:end-1), tau1_PRBFNNC(1:end-1),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time(1:end-1), tau1_ROBUSTPTC(1:end-1),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% upperlimit0=[100 100];
% lowerlimit0=[-100 -100];
% line([0 20],upperlimit0,'linestyle','--','color','r','linewidth',2)
% line([0 20],lowerlimit0,'linestyle','--','color','r','linewidth',2)
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Torque of joint 2/N \cdot m');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes5,'on');
% hold(axes5,'off');
% % 创建 legend
% set(axes5,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend5 = legend(axes5,'show');
% set(legend5,'NumColumns',2,'AutoUpdate','off','FontSize',24);
%%
% figure6=figure('WindowState','maximized');
% clf;
% axes6 = axes('Parent',figure6,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes6,'on');
% grid on;
% hold on;
% h1 = plot(time(1:end-1), tau2_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), tau2_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), tau2_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time(1:end-1), tau2_pid(1:end-1),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time(1:end-1), tau2_PRBFNNC(1:end-1),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time(1:end-1), tau2_ROBUSTPTC(1:end-1),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% upperlimit0=[100 100];
% lowerlimit0=[-100 -100];
% line([0 20],upperlimit0,'linestyle','--','color','r','linewidth',2)
% line([0 20],lowerlimit0,'linestyle','--','color','r','linewidth',2)
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Torque of joint 3/N \cdot m');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes6,'on');
% hold(axes6,'off');
% % 创建 legend
% set(axes6,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend6 = legend(axes6,'show');
% set(legend6,'NumColumns',2,'AutoUpdate','off','FontSize',24);
%%
figure7=figure('WindowState','maximized');
axes7 = axes('Parent',figure7,'Position',[-0.04,0,1.05,0.8],'OuterPosition',[-0.04,0,1.05,0.8]);
hold(axes7,'on');
hold on;
yyaxis left
plot(time(2:end-1),threshold_gen(2:end-1),'linewidth',2.5);
ylabel('Threshold of generating rules T_g');
xlabel('Time/s');
ylim([0 0.7])
yyaxis right
plot(time(2:end-1),threshold_del(2:end-1),'linewidth',2.5);
ylabel('Threshold of deleting rules T_d');
xlabel('Time/s');
ylim([0 1e-5])
grid(axes7,'on');
hold(axes7,'off');
% 创建 legend
set(axes7,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
legend({'T_{g}','T_{d}'})
legend7 = legend(axes7,'show');
line([0.75,0.75],[0,0.5],'linestyle','--','linewidth',3,'color','k')
set(legend7,'NumColumns',1,'AutoUpdate','off','FontSize',28);
Str = 'Parameter predefined-time threshold $T_s=0.75s$';
an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
    'Interpreter','latex','String',Str,'FontSize',28);
an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
an.LineWidth = 2;
%%
% figure8=figure('WindowState','maximized');
% clf;
% axes8 = axes('Parent',figure8,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes8,'on');
% hold on;
% h1 = plot(time(2:end-1), rule_number(2:end-1),'color','#D95319','linewidth', 2);
% ylabel('Number of rules');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes8,'on');
% hold(axes8,'off');
% % 创建 legend
% set(axes8,'FontName','Times New Roman','FontSize',36);
% line([0.75,0.75],[0,30],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=0.75s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time(1:end-1), Q_I_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), Q_I_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), Q_I_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% ylabel('Network Weight tr({Q_I^TQ_I})');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36);
% 
% line([0.75,0.75],[0,6],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=0.75s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% zp = BaseZoom();
% zp.plot;
%%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time(1:end-1), s_0_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), s_0_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), s_0_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% ylabel('Sliding surface value s_1');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36);
% line([0.75,0.75],[-2,8],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=0.75s$';
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;
%%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time(1:end-1), s_1_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), s_1_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), s_1_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% ylabel('Sliding surface value s_2');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36);
% line([0.75,0.75],[-2,8],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=0.75s$';
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;
%%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time(1:end-1), s_2_IT2FLFNN(1:end-1),'color','#D95319','linewidth', 2.5);
% h2 = plot(time(1:end-1), s_2_IT2FNN(1:end-1),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time(1:end-1), s_2_T1FLFNN(1:end-1),'color','#EDB120','linewidth', 2.5);
% ylabel('Sliding surface value s_3');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36);
% line([0.75,0.75],[-20,10],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=0.75s$';
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;
