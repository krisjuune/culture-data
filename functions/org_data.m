%Function to calculate corrected Chl values, log_Chl, and to produce a half
%empty data matrix, containing the times of measurements as the 1st column,
%and the corresponding Chl values as the 2nd column, and log_Chl is as the
%5th column. The input data matrix has to be in the form as returned by the
%function data_table. Other inputs include a string array of dates, and a
%row vector containing the trace metal concentrations. 

%In order to observe the growth phase of organisms, plot the 1st column of
%the data matrix against the 5th column. 

%Substitue TM for the tace metal of interest.

function TM_growth = org_data(TM_conc, dates, TM_data)
        
    %Conditional statement to test whether the number of input arguments is
    %correct
        
        nr_trt = length(TM_conc);
        num = length(dates)*3; %calculate nr of Chl values
        TM_growth_pg = zeros(num,5,8); %pre-allocate growth data array
        %columns for dates, Chl, IGR&SGR values, and log_Chl, pages for 
        %treatments
        TM_growth_pg_tr = zeros(5,num,8); %pre-allocate array 
        %with the matrices in each page transposed rel to Fe_growth_pg
        
        
        for i = 1:nr_trt
            %sort the data per treatment
            trt = TM_data(:,2); %select the column with treatment numbers
            rows_trt = find(trt == i); %get indices of where the right trt is
            trt_data = zeros(length(rows_trt),4); %preallocate the treatment array

                for j = rows_trt
                    trt_data = TM_data(j,:); %add the correct row to the trt array            
                end

             %sort the data per value factor (blank vs biological)
             fct = trt_data(:,3); %select column with value factors
             rows_fct = find(fct == 0); %get indices for blank values
                for k = rows_fct
                    blank_data = trt_data(k,:); %obtain vector with blanks
                    trt_data(k,:) = []; %sort out the blanks (delete them)
                    bio_data = trt_data; %obtain vector with bio values         
                end

             %correct for blanks and calculate ln values 
             blanks = repelem(blank_data(:,4),3); %create vector that has 
             %the same number of values of blanks as there are bio 
             %measurements
             Chl = bio_data(:,4) - blanks; %correct for blanks 
             %some may become -ve
             days = bio_data(:,1) - bio_data(1,1); %time relative to day 0
             log_Chl = zeros(size(Chl)); 
                for l = 1:length(Chl)
                    if Chl(l) <= 0.1
                        log_Chl(l) = NaN; %avoid complex results
                    else
                        log_Chl = log(Chl); %calculate the ln of Chl
                    end
                end
                          
             %Uncomment the next section if would like to plot within
             %function

%              %reshape data into each set of measurements as columns to calculate 
%              %the means and standard deviations
%              Fe_data_columns = vec2mat(log_Chl,3)'; %returns array with 3 rows and 
%              %length(days) columns for the j-th treatment (since triplicates)
%              Fe_data_mean = mean(Fe_data_columns); %returns mean of columns as a 
%              %row vector for the j-th treatment
%              Fe_data_err = 2*std(Fe_data_columns); %returns 2*std dev of columns as
%              %a row vector for the j-th treatment
%              days_mean = vec2mat(days,3); 
%              days_mean = days_mean(:,1); %only keep every third datapoint (since 
%              %now in mean values)

%              %plot the data with time on x-axis and log(Chl) on y-axis
%              labels = ["7.1", "11", "55", "71", "110", "330", "550", "1100"];
%              lgd_columns = 2; %specify nr of columns in the legend
%              fontsize = 8; %specify the fontsize of the legend

%              subplot(2,1,1)
%              plot(days, log_Chl, 'o') %plotting automatically ignores imaginary nr
%              hold on
%              xlabel('Time (days)')
%              ylabel('log(Chl)')
%              title('Fe E.hux')
%              lgd = legend(labels, 'NumColumns', lgd_columns, 'Fontsize', fontsize, 'Location','NorthWestOutside');
%              title(lgd, 'Fe concentrations (pM)')
%              
%              
%              %plot the data with errorbars and mean values instead of points
%              subplot(2,1,2)
%              errorbar(days_mean, Fe_data_mean, Fe_data_err)
%              hold on
%              xlabel('Time (days)')
%              ylabel('log(Chl)')
%              title('Fe E.hux')
%              lgd = legend(labels, 'NumColumns', lgd_columns, 'Fontsize', fontsize, 'Location','NorthWestOutside');
%              title(lgd, 'Fe concentrations (pM)')


             TM_growth_pg(:,1,i) = days;
             TM_growth_pg(:,2,i) = Chl;
             TM_growth_pg(:,5,i) = log_Chl;

                 for m = 4:length(Chl) %over Chl values skipping first 3 measurements
                     if TM_growth_pg(m,2,i) - TM_growth_pg(m-3,2,i) <= 0 %would get imaginary, infinity or NaN
                         TM_growth_pg(m,3,i) = NaN;
                     else
                         TM_growth_pg(m,3,i) = log(TM_growth_pg(m,2,i)/TM_growth_pg(m-3,2,i))/(TM_growth_pg(m,1,i)-TM_growth_pg(m-3,1,i)); 
                     end
                 end

             TM_growth_pg_tr(:,:,i) = TM_growth_pg(:,:,i)'; %transpose for reshaping after loop    

        end
%         hold off  %uncomment if plotting is uncommented    

        %obtain final data matrix
        TM_growth_tr = reshape(TM_growth_pg_tr, 5, nr_trt*length(Chl)); 
        %reshape column wise into a wide matrix 
        TM_growth = TM_growth_tr'; %transpose into a long matrix

end

        
        