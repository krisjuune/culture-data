%Function to plot daily measurements for monitoring cultures using the 
%output of org_data.m. Function returns the handle to the scatter plot. 

%The output matrix of org_data.m contains the times of measurements as the 
%1st column, and the corresponding Chl values as the 2nd column, and 
%log_Chl is as the 5th column for each of the treatments (as pages). 

%Substitue TM for the tace metal of interest.

function mon_plots = plot_daily(TM_conc, TM_growth)

    if nargin < 2
        disp('Not enough input arguments')
    end

    nr_trt = length(TM_conc);
    labels = string(TM_conc); %Create string with concentrations 
    
    for i = 1:nr_trt
        %Sort the data per treatment
        
        days = TM_growth(:,1,i);
        log_Chl = TM_growth(:,5,i);

        %Reshape data into each set of measurements as columns to 
        %calculate the means and standard deviations
        
        TM_data_columns = vec2mat(log_Chl,3)'; 
        %returns an 3-by-length(days) array for i-th treatment
        
        TM_data_mean = mean(TM_data_columns); 
        %returns mean of columns as a row vector for i-th treatment
        
        TM_data_err = 2*std(TM_data_columns); 
        %returns 2*std dev of columns as a row vector for i-th treatment
        
        days_mean = vec2mat(days,3); 
        days_mean = days_mean(:,1); %keep every third datapoint 

        %Plot the data with time on x-axis and log(Chl) on y-axis
        lgd_columns = 2; %specify nr of columns in the legend
        fontsize = 8; %specify the fontsize of the legend

        subplot(2,1,1)
        mon_plots = plot(days, log_Chl, 'o');
        hold on
        xlabel('Time (days)')
        ylabel('log(Chl)')
        lgd = legend(labels, 'NumColumns', lgd_columns, 'Fontsize', fontsize, 'Location','NorthWestOutside');
        title(lgd, 'Concentration (pM)')

        %plot the data with errorbars and mean values instead of points
        subplot(2,1,2)
        errorbar(days_mean, TM_data_mean, TM_data_err)
        hold on
        xlabel('Time (days)')
        ylabel('log(Chl)')
        lgd = legend(labels, 'NumColumns', lgd_columns, 'Fontsize', fontsize, 'Location','NorthWestOutside');
        title(lgd, 'Concentration (pM)')
         
    end
    
    hold off
    
end
    