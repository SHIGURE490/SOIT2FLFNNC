(sum(abs(error0_ROBUSTPTC))+sum(abs(error1_ROBUSTPTC))+sum(abs(error2_ROBUSTPTC)))/(3*length(error0_ROBUSTPTC))
(sum(abs(error0_ROBUSTPTC).*time)+sum(abs(error1_ROBUSTPTC).*time)+sum(abs(error2_ROBUSTPTC).*time))/(3*length(error0_ROBUSTPTC))
(sum(abs(error0_ROBUSTPTC).^2)+sum(abs(error1_ROBUSTPTC).^2)+sum(abs(error2_ROBUSTPTC).^2))/(3*length(error0_ROBUSTPTC))
(sum(abs(tau0_ROBUSTPTC))+sum(abs(tau1_ROBUSTPTC))+sum(abs(tau2_ROBUSTPTC)))*1e-3/3
(sum(abs(tau0_ROBUSTPTC(2:end-1)-tau0_ROBUSTPTC(1:end-2)))+sum(abs(tau1_ROBUSTPTC(2:end-1)-tau1_ROBUSTPTC(1:end-2)))+...
    sum(abs(tau2_ROBUSTPTC(2:end-1)-tau2_ROBUSTPTC(1:end-2))))*1e-3/3