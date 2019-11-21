%Fe experiments, T.weiss subcultures

%Create an array containing Fe concentrations
Fe_conc = [7.1 11 55 71 110 330 550 1100]; %Fe concentrations in pM

%% Input the data
%Load the data files, daily measurements as columns
    blank_s1 = load('matblank_Fe_1.txt'); 
    Fe_s1 = load('matdat_Fe_Tweiss_1.txt'); 

    blank_s2 = load('matblank_Fe_2.txt'); 
    Fe_s2 = load('matdat_Fe_Tweiss_2.txt'); 

    blank_s3 = load('matblank_Fe_3.txt'); 
    Fe_s3 = load('matdat_Fe_Tweiss_3.txt'); 

    blank_s4 = load('matblank_Fe_4.txt'); 
    Fe_s4 = load('matdat_Fe_Tweiss_4.txt'); 

    blank_s5 = load('matblank_Fe_5_Tweiss.txt');
    Fe_s5 = load('matdat_Fe_Tweiss_5.txt'); 

    % blank_s6 = load('matblank_Fe_6_Tweiss.txt'); 
    % Fe_s6 = load('matdat_Fe_Tweiss_6.txt'); 

%Enter the dates and times of measurements as a string array, the 
%recommended input is [""] 

    dates_s1 = ["2019-07-15 14:26:29";
                "2019-07-16 10:21:21";
                "2019-07-17 10:30:45";
                "2019-07-18 10:25:40";
                "2019-07-19 10:14:37";
                "2019-07-22 10:37:56";
                "2019-07-23 10:31:32";
                "2019-07-24 10:23:52";
                "2019-07-25 10:21:14";
                "2019-07-26 10:29:23";
                ];

    dates_s2 = ["2019-07-31 13:28:27";
                "2019-08-01 11:50:01";
                "2019-08-05 14:14:55";
                "2019-08-06 12:05:50";
                "2019-08-07 12:31:26";
                "2019-08-09 11:59:40";
                "2019-08-11 13:11:49";
                ];  

    dates_s3 = ["2019-08-11 14:54:32";
                "2019-08-12 13:26:11";
                "2019-08-13 11:03:53";
                "2019-08-14 14:20:05";
                "2019-08-15 13:03:47";
                "2019-08-16 14:16:01";
                "2019-08-19 15:05:24";
                "2019-08-20 14:44:30";
                ]; 

    dates_s4 = ["2019-08-20 15:42:00";
                "2019-08-21 14:58:20";
                "2019-08-22 08:37:16";
                "2019-08-22 16:21:13";
                "2019-08-23 08:18:52"; 
                "2019-08-23 17:52:32";
                "2019-08-24 07:22:17";
                "2019-08-27 15:35:54";
                "2019-08-28 16:08:08";
                "2019-08-29 16:07:29";
                ]; 

    dates_s5 = ["2019-08-29 16:55:43";
                "2019-08-30 15:44:46";
                "2019-09-02 16:11:10";
                "2019-09-03 17:46:25";
                "2019-09-05 16:44:30";
                "2019-09-06 15:26:44";
                "2019-09-07 16:12:56";
                "2019-09-09 15:21:20";
                "2019-09-10 15:32:46";
                ]; 

    % dates_s6 = [""]; 


%% Calculate relative growth rates    
%Obtain data tables for each of the subcultures
    Fe_data_Tweiss_s1 = data_table(Fe_conc, dates_s1, blank_s1, Fe_s1);
    Fe_data_Tweiss_s2 = data_table(Fe_conc, dates_s2, blank_s2, Fe_s2);
    Fe_data_Tweiss_s3 = data_table(Fe_conc, dates_s3, blank_s3, Fe_s3);
    Fe_data_Tweiss_s4 = data_table(Fe_conc, dates_s4, blank_s4, Fe_s4);
    Fe_data_Tweiss_s5 = data_table(Fe_conc, dates_s5, blank_s5, Fe_s5);

%Obtain corrected Chl, and log_Chl values as well as IGR data
    Fe_growth_Tweiss_s1 = org_data(Fe_conc, dates_s1, Fe_data_Tweiss_s1); 
    Fe_growth_Tweiss_s2 = org_data(Fe_conc, dates_s2, Fe_data_Tweiss_s2); 
    Fe_growth_Tweiss_s3 = org_data(Fe_conc, dates_s3, Fe_data_Tweiss_s3); 
    Fe_growth_Tweiss_s4 = org_data(Fe_conc, dates_s4, Fe_data_Tweiss_s4); 
    Fe_growth_Tweiss_s5 = org_data(Fe_conc, dates_s5, Fe_data_Tweiss_s5); 

%Set the phase of each of the subcultures (the period over which want to
%calculate SGR)
    phase_s1 = 6;
    phase_s2 = 6;
    phase_s3 = 6;
    phase_s4 = 6;
    phase_s5 = 6;

%Obtain SGR data as means of triplicates and std between triplicates
    Fe_SGR_Tweiss_s1 = calc_growth(Fe_conc, dates_s1, phase_s1, Fe_growth_Tweiss_s1);
    Fe_SGR_Tweiss_s2 = calc_growth(Fe_conc, dates_s2, phase_s2, Fe_growth_Tweiss_s2);
    Fe_SGR_Tweiss_s3 = calc_growth(Fe_conc, dates_s3, phase_s3, Fe_growth_Tweiss_s3);
    Fe_SGR_Tweiss_s4 = calc_growth(Fe_conc, dates_s4, phase_s4, Fe_growth_Tweiss_s4);
    Fe_SGR_Tweiss_s5 = calc_growth(Fe_conc, dates_s5, phase_s5, Fe_growth_Tweiss_s5);

% disp(Fe_SGR_Tweiss_s1(:,4:end)); 
% disp(Fe_SGR_Tweiss_s2(:,4:end)); 
% disp(Fe_SGR_Tweiss_s3(:,4:end)); 
% disp(Fe_SGR_Tweiss_s4(:,4:end)); 
% disp(Fe_SGR_Tweiss_s5(:,4:end)); 

%Save the mean and std data as text files
    fid = fopen('Fe_Tweiss_s1.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_Tweiss_s1(:,4:end)');
    fclose(fid);
    % type Tweiss_s1.txt

    fid = fopen('Fe_Tweiss_s2.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_Tweiss_s2(:,4:end)');
    fclose(fid);
    % type Tweiss_s2.txt

    fid = fopen('Fe_Tweiss_s3.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_Tweiss_s3(:,4:end)');
    fclose(fid);
    % type Tweiss_s3.txt

    fid = fopen('Fe_Tweiss_s4.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_Tweiss_s4(:,4:end)');
    fclose(fid);
    % type Tweiss_s4.txt

    fid = fopen('Fe_Tweiss_s5.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_SGR_Tweiss_s5(:,4:end)');
    fclose(fid);
    % type Tweiss_s5.txt

    
%% Pool together acclimated subcultures     
%Calculate means and std-s of subcultures 2-5 (each subculture weighted by 
%one as all are based on the same number of data points)
    Fe_Tweiss_mu_std = zeros(length(Fe_conc),2); %preallocate array
    
        for i = 1:length(Fe_conc)
            
            %Calculate the pooled mean
            Fe_Tweiss_mu_std(i,1) = (Fe_SGR_Tweiss_s2(i,4)+Fe_SGR_Tweiss_s3(i,4)+Fe_SGR_Tweiss_s4(i,4)+Fe_SGR_Tweiss_s5(i,4))/4;
            %Calculate the pooled std
            Fe_Tweiss_mu_std(i,2) = sqrt((Fe_SGR_Tweiss_s2(i,5)^2+Fe_SGR_Tweiss_s3(i,5)^2+Fe_SGR_Tweiss_s4(i,5)^2+Fe_SGR_Tweiss_s5(i,5)^2)/4);
            
        end
        
%Save the pooled means and standard deviations
fid = fopen('Fe_Tweiss_mu_std.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Fe_Tweiss_mu_std');
    fclose(fid);


