% % load tsy_main.mat
% % plot(time,q_e_0.Value)
% % %25.2845
% % plot(time,enable_start.Value)
% %25.285
% % load tsymain1.mat
% % plot(0:0.0005:(length(enable_start.Value)-1)*0.0005,enable_start.Value)
% %18.1545
% % load tsy_pid.mat
% % plot(0:0.0005:(length(enable_all_Value.Value)-1)*0.0005,enable_all_Value.Value)
% %12.642+5
% load tsy_predefinedtime.mat
% plot(0:0.0005:(length(enable_all_Value.Value)-1)*0.0005,enable_all_Value.Value)
% %10.117+5
clear all;
close all;
clc;
load IT2FLFNN.mat
error0_IT2FLFNN=q_e_0.Value;
error1_IT2FLFNN=q_e_1.Value;
error2_IT2FLFNN=q_e_2.Value;
tau0_IT2FLFNN=tau_final_0.Value;
tau1_IT2FLFNN=tau_final_1.Value;
tau2_IT2FLFNN=tau_final_2.Value;
threshold_gen=Tgen_show.Value;
threshold_del=Tmerg_show.Value;
Q_I_IT2FLFNN=Q_I.Value;
rule_number=Rn_show.Value; %34380
s_0_IT2FLFNN=s_0.Value;
s_1_IT2FLFNN=s_1.Value;
s_2_IT2FLFNN=s_2.Value;
load IT2FNN.mat
error0_IT2FNN=q_e_0.Value;
error1_IT2FNN=q_e_1.Value;
error2_IT2FNN=q_e_2.Value;
tau0_IT2FNN=tau_final_0.Value;
tau1_IT2FNN=tau_final_1.Value;
tau2_IT2FNN=tau_final_2.Value;
Q_I_IT2FNN=Q_I.Value;
s_0_IT2FNN=s_0.Value;
s_1_IT2FNN=s_1.Value;
s_2_IT2FNN=s_2.Value;
% rule_number=Rn_show.Value;  %37934
load T1FLFNN.mat
error0_T1FLFNN=q_e_0.Value;
error1_T1FLFNN=q_e_1.Value;
error2_T1FLFNN=q_e_2.Value;
tau0_T1FLFNN=tau_final_0.Value;
tau1_T1FLFNN=tau_final_1.Value;
tau2_T1FLFNN=tau_final_2.Value; %34380
Q_I_T1FLFNN=Q_I.Value;
s_0_T1FLFNN=s_0.Value;
s_1_T1FLFNN=s_1.Value;
s_2_T1FLFNN=s_2.Value;
load PID.mat
error0_PID=q_e_0.Value;
error1_PID=q_e_1.Value;
error2_PID=q_e_2.Value;
tau0_PID=tau_final_0.Value;
tau1_PID=tau_final_1.Value;
tau2_PID=tau_final_2.Value; %28789
load PRBFNNC.mat
error0_PRBFNNC=q_e_0.Value;
error1_PRBFNNC=q_e_1.Value;
error2_PRBFNNC=q_e_2.Value;
tau0_PRBFNNC=tau_final_0.Value;
tau1_PRBFNNC=tau_final_1.Value;
tau2_PRBFNNC=tau_final_2.Value; %27348
load PTCrobust.mat
error0_PTCrobust=q_e_0.Value;
error1_PTCrobust=q_e_1.Value;
error2_PTCrobust=q_e_2.Value;
tau0_PTCrobust=tau_final_0.Value;
tau1_PTCrobust=tau_final_1.Value;
tau2_PTCrobust=tau_final_2.Value; %28789
%%
index1_start=50321; index1_end=50321+40/(5e-4);
index2_start=37934; index2_end=37934+40/(5e-4);
index3_start=34380; index3_end=34380+40/(5e-4);
index4_start=93084; index4_end=93084+40/(5e-4);
index5_start=37349; index5_end=37349+40/(5e-4);
index6_start=38790; index6_end=38790+40/(5e-4);
time=0:5e-4:40;
dt=5e-4;
RMSE=0;
ITAE=0;
ISE=0;
IAE=0;
ECI=0;
AICE=0;
% for i=1:length(time)
%     RMSE=RMSE+error2_PTCrobust(index6_start+i-1)^2;
%     ITAE=ITAE+i/length(time)*abs(error2_PTCrobust(index6_start+i-1))*dt;
%     IAE=IAE+abs(error2_PTCrobust(index6_start+i-1))*dt;
%     ISE=ISE+error2_PTCrobust(index6_start+i-1)^2*dt;
% end
% RMSE=sqrt(RMSE/length(time));
% RMSE
% ITAE
% IAE
% ISE
    for i=1:length(time)
        ECI=ECI+abs(tau0_IT2FLFNN(index1_start+i-1))*dt+abs(tau1_IT2FLFNN(index1_start+i-1))*dt+abs(tau2_IT2FLFNN(index1_start+i-1))*dt;
    end
ECI=ECI/3
%     for i=1:(length(time)-1)
%         AICE=AICE+abs(tau0_PRBFNNC(index5_start+i)-tau0_PRBFNNC(index5_start+i-1))*dt+abs(tau1_PRBFNNC(index5_start+i)-tau1_PRBFNNC(index5_start+i-1))*dt+abs(tau2_PRBFNNC(index5_start+i)-tau2_PRBFNNC(index5_start+i-1))*dt;
%     end
% AICE=AICE/3

%%
% figure1=figure('WindowState','maximized');
% clf;
% axes1 = axes('Parent',figure1,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes1,'on');
% grid on;
% hold on;
% h1 = plot(time, error0_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, error0_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, error0_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time, error0_PID(index4_start:index4_end),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time, -error0_PRBFNNC(index5_start:index5_end),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time, -error0_PTCrobust(index6_start:index6_end),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes1,'on');
% hold(axes1,'off');
% % 创建 legend
% set(axes1,'FontName','Times New Roman','FontSize',36);
% legend1 = legend(axes1,'show');
% set(legend1,'NumColumns',2,'AutoUpdate','off','FontSize',28);
% line([3,3],[-0.4,0.2],'linestyle','--','linewidth',3,'color','k')
% Str = 'Error predefined-time threshold $T_s+T_e=3s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% ylabel('Error of joint 1/rad');
% zp = BaseZoom();
% zp.plot;
% zp1 = BaseZoom();
% zp1.plot;
%
% figure2=figure('WindowState','maximized');
% clf;
% axes2 = axes('Parent',figure2,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes2,'on');
% grid on;
% hold on;
% h1 = plot(time, error1_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, error1_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, error1_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time, error1_PID(index4_start:index4_end),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time, -error1_PRBFNNC(index5_start:index5_end),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time, -error1_PTCrobust(index6_start:index6_end),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Error of joint 2/rad');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes2,'on');
% hold(axes2,'off');
% % 创建 legend
% set(axes2,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend1 = legend(axes2,'show');
% set(legend1,'NumColumns',2,'AutoUpdate','off','FontSize',28);
% line([3,3],[-0.3,0.2],'linestyle','--','linewidth',3,'color','k')
% Str = 'Error predefined-time threshold $T_s+T_e=3s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;
% zp1 = BaseZoom();
% zp1.plot;

% figure2=figure('WindowState','maximized');
% clf;
% axes2 = axes('Parent',figure2,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes2,'on');
% grid on;
% hold on;
% h1 = plot(time, error2_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, error2_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, error2_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time, error2_PID(index4_start:index4_end),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time, -error2_PRBFNNC(index5_start:index5_end),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time, -error2_PTCrobust(index6_start:index6_end),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Error of joint 3/rad');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes2,'on');
% hold(axes2,'off');
% % 创建 legend
% set(axes2,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend1 = legend(axes2,'show');
% set(legend1,'NumColumns',2,'AutoUpdate','off','FontSize',28);
% line([3,3],[-0.3,0.2],'linestyle','--','linewidth',3,'color','k')
% Str = 'Error predefined-time threshold $T_s+T_e=3s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
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
% h1 = plot(time, tau0_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, tau0_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, tau0_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time, tau0_PID(index4_start:index4_end),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time, tau0_PRBFNNC(index5_start:index5_end),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time, tau0_PTCrobust(index6_start:index6_end),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% upperlimit0=[50 50];
% lowerlimit0=[-50 -50];
% line([0 40],upperlimit0,'linestyle','--','color','r','linewidth',2)
% line([0 40],lowerlimit0,'linestyle','--','color','r','linewidth',2)
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Torque of joint 1/N \cdot m');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes4,'on');
% hold(axes4,'off');
% % 创建 legend
% set(axes4,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% legend4 = legend(axes4,'show');
% set(legend4,'NumColumns',2,'AutoUpdate','off','FontSize',28);
%%
% figure4=figure('WindowState','maximized');
% clf;
% axes4 = axes('Parent',figure4,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes4,'on');
% grid on;
% hold on;
% h1 = plot(time, tau1_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, tau1_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, tau1_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time, tau1_PID(index4_start:index4_end),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time, tau1_PRBFNNC(index5_start:index5_end),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time, tau1_PTCrobust(index6_start:index6_end),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% upperlimit0=[50 50];
% lowerlimit0=[-50 -50];
% line([0 40],upperlimit0,'linestyle','--','color','r','linewidth',2)
% line([0 40],lowerlimit0,'linestyle','--','color','r','linewidth',2)
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Torque of joint 2/N \cdot m');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes4,'on');
% hold(axes4,'off');
% % 创建 legend
% set(axes4,'FontName','Times New Roman','FontSize',36);
% legend4 = legend(axes4,'show');
% set(legend4,'NumColumns',2,'AutoUpdate','off','FontSize',28);

% figure4=figure('WindowState','maximized');
% clf;
% axes4 = axes('Parent',figure4,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes4,'on');
% grid on;
% hold on;
% h1 = plot(time, tau2_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, tau2_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, tau2_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% h4 = plot(time, tau2_PID(index4_start:index4_end),'color','#4DBEEE','linestyle',':','linewidth', 2.5);
% h5 = plot(time, tau2_PRBFNNC(index5_start:index5_end),'color','#A2142F','linestyle','--','linewidth', 2.5);
% h6 = plot(time, tau2_PTCrobust(index6_start:index6_end),'color','#77AC30','linestyle','-.','linewidth', 2.5);
% upperlimit0=[50 50];
% lowerlimit0=[-50 -50];
% line([0 40],upperlimit0,'linestyle','--','color','r','linewidth',2)
% line([0 40],lowerlimit0,'linestyle','--','color','r','linewidth',2)
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC','PID','PRBFNNC','ROBUSTPTC'},'Numcolumns',2)
% ylabel('Torque of joint 3/N \cdot m');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes4,'on');
% hold(axes4,'off');
% % 创建 legend
% set(axes4,'FontName','Times New Roman','FontSize',36);
% legend4 = legend(axes4,'show');
% set(legend4,'NumColumns',2,'AutoUpdate','off','FontSize',28);
%%
% figure7=figure('WindowState','maximized');
% axes7 = axes('Parent',figure7,'Position',[-0.04,0,1.05,0.8],'OuterPosition',[-0.04,0,1.05,0.8]);
% hold(axes7,'on');
% hold on;
% yyaxis left
% plot(time(1:end),threshold_gen(index1_start:index1_end),'linewidth',2.5);
% ylabel('Threshold of generating rules');
% xlabel('Time/s');
% ylim([0 0.5])
% yyaxis right
% plot(time(1:end),threshold_del(index1_start:index1_end),'linewidth',2.5);
% ylabel('Threshold of deleting rules');
% xlabel('Time/s');
% ylim([0 1e-6])
% grid(axes7,'on');
% hold(axes7,'off');
% % 创建 legend
% set(axes7,'FontName','Times New Roman','FontSize',36);
% legend({'T_{g}','T_{d}'})
% legend7 = legend(axes7,'show');
% set(legend7,'NumColumns',1,'AutoUpdate','off','FontSize',28);
% Str = 'Parameter predefined-time threshold $T_s=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',24);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% line([1.5,1.5],[0,0.5],'linestyle','--','linewidth',3,'color','k')
%%
% figure8=figure('WindowState','maximized');
% axes8 = axes('Parent',figure8,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% % axes8 = axes('Parent',figure8);
% hold(axes8,'on');
% hold on;
% h1 = plot(time, rule_number(index1_start-2:index1_end-2),'color','#D95319','linewidth', 2);
% ylabel('Number of rules');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes8,'on');
% hold(axes8,'off');
% % 创建 legend
% set(axes8,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% line([1.5,1.5],[0,8],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
%%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time, Q_I_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, Q_I_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, Q_I_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% ylabel('Network Weight tr({Q_I^TQ_I})');
% ylim([0 12])
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% line([1.5,1.5],[0,12],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;
%%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time, s_0_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, s_0_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, s_0_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% ylabel('Sliding surface value s_0');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% line([1.5,1.5],[-1.5,0.5],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
%%
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time, s_1_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, s_1_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, s_1_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% ylabel('Sliding surface value s_2');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36);
% line([1.5,1.5],[-0.5,1],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;
% figure9=figure('WindowState','maximized');
% axes9 = axes('Parent',figure9,'Position',[-0.05,0,1.14,0.7],'OuterPosition',[-0.05,0,1.14,0.7]);
% hold(axes9,'on');
% hold on;
% h1 = plot(time, s_2_IT2FLFNN(index1_start:index1_end),'color','#D95319','linewidth', 2.5);
% h2 = plot(time, s_2_IT2FNN(index2_start:index2_end),'color','#0072BD','linewidth', 2.5);
% h3 = plot(time, s_2_T1FLFNN(index3_start:index3_end),'color','#EDB120','linewidth', 2.5);
% legend({'IT2FLFNNC','IT2FNNC','T1FLFNNC'},'Numcolumns',1)
% ylabel('Sliding surface value s_3');
% % 创建 xlabel
% xlabel('Time/s');
% grid(axes9,'on');
% hold(axes9,'off');
% % 创建 legend
% set(axes9,'FontName','Times New Roman','FontSize',36,'LineWidth',1.5);
% line([1.5,1.5],[-0.5,1],'linestyle','--','linewidth',3,'color','k')
% Str = 'Parameter predefined-time threshold $T_s=1.5s$';
% an = annotation('textarrow',[0.1,0.5],[0.6,0.6],...
%     'Interpreter','latex','String',Str,'FontSize',28);
% an.Position = [0.735714285714286,0.327619047619048,-0.03,0.087619047619048];
% an.LineWidth = 2;
% zp = BaseZoom();
% zp.plot;