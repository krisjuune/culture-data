%Script for plotting the relative pooled growth rates of different
%organisms against Cu/Fe concentrations

%Plot the pooled means of relative growth rates with error bars on a semi
%log x plot

%% For omitting specific data points:
Cu_conc_T = [0 0.0001 0.001 0.2 2 22 124 696 1295 4925 10330]; %pM
Cu_conc_E = [0 0.0001 0.001 0.01 0.2 2 22 124 696 4925 10330]; %pM
Fe_conc_T = [7.1 11 55 110 330 550 1100]; %pM
Fe_conc_E = [7.1 11 55 71 110 550 1100]; %pM

if length(Cu_Tweiss_mu_std(:,1))~=length(Cu_conc_T)
Cu_Tweiss_mu_std(4,:) = [];
end
if length(Cu_Ehux_mu_std(:,1))~=length(Cu_conc_E)
Cu_Ehux_mu_std(10,:) = [];
end

if length(Fe_Tweiss_mu_std(:,1))~=length(Fe_conc_T)
Fe_Tweiss_mu_std(4,:) = [];
end
if length(Fe_Ehux_mu_std(:,1))~=length(Fe_conc_E)
Fe_Ehux_mu_std(6,:) = [];
end

%% Plot the data
figure(1) %Cu experiment
    hAx=axes; %new axes, save handle
    errorbar(Cu_conc_E,Cu_Ehux_mu_std(:,1),Cu_Ehux_mu_std(:,2),'-o', 'LineWidth',1)
    hAx.XScale='log'; %turn to semilogx form
    hold on
    errorbar(Cu_conc_T,Cu_Tweiss_mu_std(:,1),Cu_Tweiss_mu_std(:,2),'-o', 'LineWidth',1)
    legend({'Emiliania huxleyi', 'Thalassiosira weissflogii'}, 'Fontsize', 14, 'Location','SouthEast');
    xlabel('Cu concentration (pM)', 'Fontsize', 14)
    ylabel('Relative growth rate', 'Fontsize', 14)
    title('Cu', 'Fontsize', 24)
    
figure(2) %Fe experiment
    hAx=axes; %new axes, save handle
    errorbar(Fe_conc_E,Fe_Ehux_mu_std(:,1),Fe_Ehux_mu_std(:,2),'-o', 'LineWidth',1)
    hAx.XScale='log'; %turn to semilogx form
    hold on
    errorbar(Fe_conc_T,Fe_Tweiss_mu_std(:,1),Fe_Tweiss_mu_std(:,2),'-o', 'LineWidth',1)
    legend({'Emiliania huxleyi', 'Thalassiosira weissflogii'}, 'Fontsize', 14, 'Location','SouthEast');
    xlabel('Fe concentration (pM)', 'Fontsize', 14)
    ylabel('Relative growth rate', 'Fontsize', 14)
    title('Fe', 'Fontsize', 24)
    
    
    

