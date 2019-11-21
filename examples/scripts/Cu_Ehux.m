%Cu experiments, E.hux subcultures

%Create an array containing Cu concentrations
Cu_conc = [0 0.0001 0.001 0.01 0.2 2 22 124 696 1295 4925 10330]; %Cu concentrations in pM

%% Input the data
%Load the data files, daily measurements as columns
    blank_s1 = load('matblank_Cu_1.txt'); 
    Cu_s1 = load('matdat_Cu_Ehux_1.txt'); 

    blank_s2 = load('matblank_Cu_2.txt'); 
    Cu_s2 = load('matdat_Cu_Ehux_2.txt'); 

    blank_s3 = load('matblank_Cu_3.txt'); 
    Cu_s3 = load('matdat_Cu_Ehux_3.txt'); 

    blank_s4 = load('matblank_Cu_4.txt'); 
    Cu_s4 = load('matdat_Cu_Ehux_4.txt'); 

    blank_s5 = load('matblank_Cu_5.txt'); 
    Cu_s5 = load('matdat_Cu_Ehux_5.txt');

%Enter the dates and times of measurements as a string array, the 
%recommended input is [""] 

    dates_s1 = ["2019-07-25 12:25:25";
                "2019-07-26 11:29:50";
                "2019-07-28 09:05:45";
                "2019-07-29 10:32:03";
                "2019-07-31 11:21:02";
                "2019-08-01 11:09:40";
                "2019-08-05 13:36:21";
                "2019-08-06 11:27:15";
                "2019-08-07 11:47:24"]; 

    dates_s2 = ["2019-08-07 13:53:00";
                "2019-08-09 12:15:19";
                "2019-08-11 13:24:15"; 
                "2019-08-12 12:50:42";
                "2019-08-13 11:19:49";
                "2019-08-14 13:39:54";
                "2019-08-15 12:19:10";
                ]; 

    dates_s3 = ["2019-08-16 15:46:20";
                "2019-08-19 14:08:42";
                "2019-08-20 14:59:50";
                "2019-08-21 14:18:56";
                "2019-08-22 15:43:47";
                "2019-08-23 08:33:25";
                ];

    dates_s4 = ["2019-08-23 18:05:24";
                "2019-08-27 15:56:40";
                "2019-08-28 16:27:48";
                "2019-08-29 16:22:14";
                "2019-08-30 16:06:12";
                "2019-09-02 16:26:41";
                "2019-09-03 16:48:03";
                ];

    dates_s5 = ["2019-09-03 18:04:15";
                "2019-09-05 16:13:13";
                "2019-09-06 14:40:48";
                "2019-09-07 16:40:14";
                "2019-09-09 15:48:03";
                "2019-09-10 15:57:53";
                "2019-09-11 16:34:39";
                "2019-09-13 15:04:46";
                ];

            
%% Calculate relative growth rates            
%Obtain data tables for each of the subcultures
    Cu_data_Ehux_s1 = data_table(Cu_conc, dates_s1, blank_s1, Cu_s1);
    Cu_data_Ehux_s2 = data_table(Cu_conc, dates_s2, blank_s2, Cu_s2);
    Cu_data_Ehux_s3 = data_table(Cu_conc, dates_s3, blank_s3, Cu_s3);
    Cu_data_Ehux_s4 = data_table(Cu_conc, dates_s4, blank_s4, Cu_s4);
    Cu_data_Ehux_s5 = data_table(Cu_conc, dates_s5, blank_s5, Cu_s5);

%Obtain corrected Chl, and log_Chl values as well as IGR data
    Cu_growth_Ehux_s1 = org_data(Cu_conc, dates_s1, Cu_data_Ehux_s1); 
    Cu_growth_Ehux_s2 = org_data(Cu_conc, dates_s2, Cu_data_Ehux_s2); 
    Cu_growth_Ehux_s3 = org_data(Cu_conc, dates_s3, Cu_data_Ehux_s3); 
    Cu_growth_Ehux_s4 = org_data(Cu_conc, dates_s4, Cu_data_Ehux_s4); 
    Cu_growth_Ehux_s5 = org_data(Cu_conc, dates_s5, Cu_data_Ehux_s5); 

%Set the phase of each of the subcultures (the period over which want to
%calculate SGR)
    phase_s1 = 6;
    phase_s2 = 6;
    phase_s3 = 6;
    phase_s4 = 6;
    phase_s5 = 6;

%Obtain SGR data as means of triplicates and std between triplicates
    Cu_SGR_Ehux_s1 = calc_growth(Cu_conc, dates_s1, phase_s1, Cu_growth_Ehux_s1);
    Cu_SGR_Ehux_s2 = calc_growth(Cu_conc, dates_s2, phase_s2, Cu_growth_Ehux_s2);
    Cu_SGR_Ehux_s3 = calc_growth(Cu_conc, dates_s3, phase_s3, Cu_growth_Ehux_s3);
    Cu_SGR_Ehux_s4 = calc_growth(Cu_conc, dates_s4, phase_s4, Cu_growth_Ehux_s4);
    Cu_SGR_Ehux_s5 = calc_growth(Cu_conc, dates_s5, phase_s5, Cu_growth_Ehux_s5);

%Save the mean and std data as text files    
    fid = fopen('Cu_Ehux_s1.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Cu_SGR_Ehux_s1(:,4:end)');
    fclose(fid);
    % type Cu_Ehux_s1.txt

    fid = fopen('Cu_Ehux_s2.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Cu_SGR_Ehux_s2(:,4:end)');
    fclose(fid);
    % type Cu_Ehux_s2.txt

    fid = fopen('Cu_Ehux_s3.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Cu_SGR_Ehux_s3(:,4:end)');
    fclose(fid);
    % type Cu_Ehux_s3.txt

    fid = fopen('Cu_Ehux_s4.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Cu_SGR_Ehux_s4(:,4:end)');
    fclose(fid);
    % type Cu_Ehux_s4.txt

    fid = fopen('Cu_Ehux_s5.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Cu_SGR_Ehux_s5(:,4:end)');
    fclose(fid);
    % type Cu_Ehux_s5.txt

    
%% Pool together acclimated subcultures     
%Calculate means and std-s of subcultures 2-5 (each subculture weighted by 
%one as all are based on the same number of data points)
    Cu_Ehux_mu_std = zeros(length(Cu_conc),2); %preallocate array
    
        for i = 1:length(Cu_conc)
            
            %Calculate the pooled mean
            Cu_Ehux_mu_std(i,1) = (Cu_SGR_Ehux_s2(i,4)+Cu_SGR_Ehux_s3(i,4)+Cu_SGR_Ehux_s4(i,4)+Cu_SGR_Ehux_s5(i,4))/4;
            %Calculate the pooled std
            Cu_Ehux_mu_std(i,2) = sqrt((Cu_SGR_Ehux_s2(i,5)^2+Cu_SGR_Ehux_s3(i,5)^2+Cu_SGR_Ehux_s4(i,5)^2+Cu_SGR_Ehux_s5(i,5)^2)/4);
            
        end
        
%Save the pooled means and standard deviationss
fid = fopen('Cu_Ehux_mu_std.txt','w');
    fprintf(fid,'%6.2f  %12.8f\n',Cu_Ehux_mu_std');
    fclose(fid);