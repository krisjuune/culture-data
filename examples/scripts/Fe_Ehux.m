%Fe experiments, E.hux subcultures

%Create an array containing Fe concentrations
Fe_conc = [7.1 11 55 71 110 330 550 1100]; %Fe concentrations in pM

%% Input the data
%Load the data files, daily measurements as columns
    blank_s1 = load('matblank_Fe_1.txt'); 
    Fe_s1 = load('matdat_Fe_Ehux_1.txt'); 

    blank_s2 = load('matblank_Fe_2.txt'); 
    Fe_s2 = load('matdat_Fe_Ehux_2.txt'); 

    blank_s3 = load('matblank_Fe_3.txt'); 
    Fe_s3 = load('matdat_Fe_Ehux_3.txt'); 

    blank_s4 = load('matblank_Fe_4_Ehux.txt'); 
    Fe_s4 = load('matdat_Fe_Ehux_4.txt'); 

    blank_s5 = load('matblank_Fe_5_Ehux.txt'); 
    Fe_s5 = load('matdat_Fe_Ehux_5.txt'); 

%Enter the dates and times of measurements as a string array, the 
%recommended input is [""] 

    dates_s1 = ["2019-07-15 14:20:19";
                "2019-07-16 10:26:51";
                "2019-07-17 10:24:34";
                "2019-07-18 10:19:19";
                "2019-07-19 10:09:29";
                "2019-07-22 10:31:37";
                "2019-07-23 10:25:51";
                "2019-07-24 10:18:10";
                "2019-07-25 10:14:32";
                "2019-07-26 10:17:19"
                ];

    dates_s2 = ["2019-07-31 13:23:00";
                "2019-08-01 11:44:54";
                "2019-08-05 14:07:54";
                "2019-08-06 12:00:38";
                "2019-08-07 12:18:01";
                "2019-08-09 11:54:30";
                "2019-08-11 13:06:47";
                ]; 

    dates_s3 = ["2019-08-11 14:49:02";
                "2019-08-12 13:21:00";
                "2019-08-13 10:58:58";
                "2019-08-14 14:14:34";
                "2019-08-15 12:55:16";
                "2019-08-16 14:06:27";
                "2019-08-19 14:59:45";
                "2019-08-20 14:38:56";
                ]; 

    dates_s4 = ["2019-08-20 15:35:35";
                "2019-08-21 14:53:20";
                "2019-08-22 08:32:19";
                "2019-08-22 16:16:14";
                "2019-08-23 08:14:02";
                "2019-08-23 17:46:02";
                "2019-08-24 07:17:33";
                "2019-08-27 15:31:01";
                "2019-08-28 16:13:29";
                "2019-08-29 16:02:22";
                "2019-08-30 15:38:05";
                "2019-09-02 16:05:48";
                ]; 

    dates_s5 = ["2019-09-02 17:05:17";
                "2019-09-03 17:41:23";
                "2019-09-05 16:39:11";
                "2019-09-06 15:20:51";
                "2019-09-07 16:22:51";
                "2019-09-09 15:32:34";
                "2019-09-10 15:41:03";
                "2019-09-11 17:10:40";
                "2019-09-12 14:42:54";
                ]; 

    % dates_s6 = [""];

    
%% Calculate relative growth rates    
%Obtain data tables for each of the subcultures
    Fe_data_s1 = data_table(Fe_conc, dates_s1, blank_s1, Fe_s1);
    Fe_data_s2 = data_table(Fe_conc, dates_s2, blank_s2, Fe_s2);
    Fe_data_s3 = data_table(Fe_conc, dates_s3, blank_s3, Fe_s3);
    Fe_data_s4 = data_table(Fe_conc, dates_s4, blank_s4, Fe_s4);
    Fe_data_s5 = data_table(Fe_conc, dates_s5, blank_s5, Fe_s5);

%Obtain corrected Chl, and log_Chl values as well as IGR data
    Fe_growth_s1 = org_data(Fe_conc, dates_s1, Fe_data_s1); 
    Fe_growth_s2 = org_data(Fe_conc, dates_s2, Fe_data_s2); 
    Fe_growth_s3 = org_data(Fe_conc, dates_s3, Fe_data_s3); 
    Fe_growth_s4 = org_data(Fe_conc, dates_s4, Fe_data_s4); 
    Fe_growth_s5 = org_data(Fe_conc, dates_s5, Fe_data_s5); 

%Set the phase of each of the subcultures (the period over which want to
%calculate SGR as a number of data points, i.e. 6 for 2 days due to 
%triplicates)
    phase_s1 = 6;
    phase_s2 = 6;
    phase_s3 = 6;
    phase_s4 = 6;
    phase_s5 = 6;

%Obtain SGR data as means of triplicates and std between triplicates
    Fe_SGR_s1 = calc_growth(Fe_conc, dates_s1, phase_s1, Fe_growth_s1);
    Fe_SGR_s2 = calc_growth(Fe_conc, dates_s2, phase_s2, Fe_growth_s2);
    Fe_SGR_s3 = calc_growth(Fe_conc, dates_s3, phase_s3, Fe_growth_s3);
    Fe_SGR_s4 = calc_growth(Fe_conc, dates_s4, phase_s4, Fe_growth_s4);
    Fe_SGR_s5 = calc_growth(Fe_conc, dates_s5, phase_s5, Fe_growth_s5);

%Save the mean and std data as text files
    fid = fopen('Fe_Ehux_s1.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_s1(:,4:end)');
    fclose(fid);
    % type Ehux_s1.txt
    fid = fopen('Fe_Ehux_s2.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_s2(:,4:end)');
    fclose(fid);
    % type Ehux_s2.txt
    fid = fopen('Fe_Ehux_s3.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_s3(:,4:end)');
    fclose(fid);
    % type Ehux_s3.txt
    fid = fopen('Fe_Ehux_s4.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_s4(:,4:end)');
    fclose(fid);
    % type Ehux_s4.txt
    fid = fopen('Fe_Ehux_s5.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_s5(:,4:end)');
    fclose(fid);
    % type Ehux_s5.txt

    
%% Pool together acclimated subcultures    
%Calculate means and std-s of subcultures 2-5 (each subculture weighted by 
%one as all are based on the same number of data points)
    Fe_Ehux_mu_std = zeros(length(Fe_conc),2); %preallocate array
    
        for i = 1:length(Fe_conc)
            
            %Calculate the pooled mean
            Fe_Ehux_mu_std(i,1) = (Fe_SGR_s2(i,4)+Fe_SGR_s3(i,4)+Fe_SGR_s4(i,4)+Fe_SGR_s5(i,4))/4;
            %Calculate the pooled std
            Fe_Ehux_mu_std(i,2) = sqrt((Fe_SGR_s2(i,5)^2+Fe_SGR_s3(i,5)^2+Fe_SGR_s4(i,5)^2+Fe_SGR_s5(i,5)^2)/4);
            
        end
        
%Save the pooled means and standard deviationss
fid = fopen('Fe_Ehux_mu_std.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_Ehux_mu_std');
    fclose(fid);









