%Function to produce a data matrix with 4 columns, 1st one containing time
%since the first measurement, 2nd one containing treatment factors (1-8 or
%1-12), 3rd one containing value factors (1 for Chl values, 0 for blanks),
%4th one containing the measurement values. 

%Function requires a matrix of blank values (daily measurements as 
%columns), a separate matrix of Chl values (daily measurements as columns),
%a vector containing the trace metal concentrations, and a string with the 
%dates as the input. Function returns the data matrix. 

%Substitue TM for the tace metal of interest.

function TM_data = data_table(TM_conc, dates, blank, TM)
        
    %Conditional statement to test whether the number of input arguments is
    %correct
    if nargin < 4
        disp('Not enough input arguments')
    end
        
        nr_trt = length(TM_conc); %Nr of treatments
        nr_value = nr_trt + 3*length(TM_conc); 
        %Nr of values per day, length(Fe_conc) blanks values + 
        %3*length(Fe_conc) biological values since triplicates
        TM_data_tr = zeros(4, nr_value, length(dates)); 
        %preallocate the data matrix, 4 rows and 24+8 columns, as many
        %pages as there are daily measurements, wide as it will later be 
        %transposed into long
        
            for i=1:length(dates) %loop over the daily measurements
                days = datenum(dates(i));

                data = [blank(:,i); TM(:,i)]; 
                %choose the measurements corresponding to the i-th day only
                treatment_blank = 1:length(TM_conc);
                %blank measurement factors
                treatment_Chl = repelem(1:length(TM_conc),3); 
                %biological measurement factors, all cultures in
                %triplicates
                treatment = [treatment_blank,treatment_Chl]';
                %concatenate the arrays and transpose into a column of
                %treatment factors
                factor = [zeros(size(blank(:,i))); ones(size(TM(:,i)))];
                %create a column of value factors

                %store the data in a matrix  
                TM_data_ind= [ones(size(data))*days, treatment, factor, data]'; 
                TM_data_tr(:,:,i) = TM_data_ind; %assign the i-th page

            end

        TM_data_tr = reshape(TM_data_tr, 4, nr_value*length(dates)); 
        %reshape column wise into a wide, 4*(nr of data points) matrix
        TM_data = TM_data_tr'; %transpose into a long matrix

end
