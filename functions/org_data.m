%Function to calculate corrected Chl values, log_Chl, and to produce a half
%empty data array, containing the times of measurements as the 1st column,
%and the corresponding Chl values as the 2nd column, and log_Chl is as the
%5th column over num(TM_conc) pages. The input data matrix has to be in the
%form as returned by the function data_table. Other inputs include a string
%array of dates, and a row vector containing trace metal concentrations. 

%In order to observe the growth phase of organisms, plot the 1st column of
%the data matrix against the 5th column looping over the pages. 

%Substitue TM for the tace metal of interest.

function TM_growth = org_data(TM_conc, dates, TM_data)
        
    %Conditional statement to test whether the number of input arguments is
    %correct
    if nargin < 3
        disp('Not enough input arguments')
    end
        
    nr_trt = length(TM_conc);
    
    %Calculate nr of Chl values
    num = length(dates)*3;
    
    %Pre-allocate growth data array columns for dates, Chl, IGR&SGR values,
    %and log_Chl, pages for treatments
    TM_growth = zeros(num,5,8);
    
    %Uncomment if would like to change the output to a long matrix, instead
    %of one with pages. Pages needed to use plot_daily.m
%     %Pre-allocate array with the matrices in each page transposed rel to 
%     %Fe_growth_pg
%     TM_growth_tr = zeros(5,num,8); 


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

         TM_growth(:,1,i) = days;
         TM_growth(:,2,i) = Chl;
         TM_growth(:,5,i) = log_Chl;

             for m = 4:length(Chl) %over Chl values skipping first 3 measurements
                 if TM_growth(m,2,i) - TM_growth(m-3,2,i) <= 0 %would get imaginary, infinity or NaN
                     TM_growth(m,3,i) = NaN;
                 else
                     TM_growth(m,3,i) = log(TM_growth(m,2,i)/TM_growth(m-3,2,i))/(TM_growth(m,1,i)-TM_growth(m-3,1,i)); 
                 end
             end
             
       %Uncomment if would like to change the output to a long matrix, instead
       %of one with pages. 
%       TM_growth_pg_tr(:,:,i) = TM_growth_pg(:,:,i)'; %transpose for reshaping after loop    

    end
    
    %Uncomment if would like to change the output to a long matrix, instead
    %of one with pages. 
%         %obtain final data matrix
%         TM_growth_tr = reshape(TM_growth_pg_tr, 5, nr_trt*length(Chl)); 
%         %reshape column wise into a wide matrix 
%         TM_growth = TM_growth_tr'; %transpose into a long matrix

end
