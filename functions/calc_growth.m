%Function to calculate specific growth rates, their means and standard
%deviations between tripliates, given the time period in mid exponential
%(assumes that measurements were taken every day during this period of
%time), and a half empty data matrix, containing the times of measurements
%as the 1st column, and the corresponding Chl values as the 2nd column. 

%Function returns array with 3 columns, 1st one containing TM_conc, 2nd
%one containing mean SGR, and 3rd one std of SGR 

function TM_SGR = calc_growth(TM_conc, dates, phase, TM_growth)
        
    %Conditional statement to test whether the number of input arguments is
    %correct

        nr_trt = length(TM_conc); %Number of different treatments
        num = length(dates)*3; %Number of biological measurements

        %Do a check for when running the script and having not specified the
        %selected mid exp data points

        if phase == 0
            disp('Cannot calculate SGR, specify the beginning of mid exponential, i.e. phase');
            %The mid exponential days have not be chosen
        else
            
            %% Calculate 'SGR' for all data points
            %Loop over the treatments (with num number of data rows each)
                for i = 0:(nr_trt-1)
                    %Loop over the individual measurements
                    for j = 4:(num-phase) 
                        
                        %Calculate SGR for data points, skipping the first
                        %(3+phase)
                        %Then calculate the mean aand std between the triplicates
                        %and use the max function to actually find the maximum
                        %specific growth rates, this is done for each treatment
                        %The maximum SGR (mean and its std) can then be stored in
                        %the Fe_SGR_s3 array

                        k = i*num + j + phase; %go through each measurement, skipping the first three for each treatment

                            if TM_growth(k,2) - TM_growth(k-phase,2) <= 1 
                                TM_growth(k,4) = NaN; %avoid complex results
                            else
                                TM_growth(k,4) = log(TM_growth(k,2)/TM_growth(k-phase,2))/(TM_growth(k,1)-TM_growth(k-phase,1));    
                            end 

                    end

                end 
              
                %Reshape the row with SGR values into a wide matrix with
                %columns of triplicates and pages of different treatments (3 rows,
                %num/3 columns, and nr_trt pages)
                TM_growth_wide = reshape(TM_growth(:,4),3,num/3, nr_trt);
                
                
                %Calculate mean and std, outputs are both 1-by-num/3-by-nr_trt
                %arrays, reshape into nr_trt*num/3-by-1 arrays and store in
                %SGR_mean
                mean_data = mean(TM_growth_wide, 1, 'omitnan'); 
                std_data = std(TM_growth_wide, 1, 'omitnan');
                SGR_mean = reshape([mean_data, std_data, zeros(size(mean_data)), zeros(size(mean_data))], num/3, 4, nr_trt);
                %Replace NaNs and Inf values with zeros
                SGR_mean(isinf(SGR_mean)|isnan(SGR_mean)) = 0; 

                %Preallocate output array
                TM_SGR = zeros(nr_trt,5); 
                %Add concentrations to the output array
                TM_SGR(:,1) = TM_conc;
                
                
                %% Find SGR for each of the treatments
                for p = 1:nr_trt %Loop over the treatments (as pages)

                    %Find the index of maximum mean value
                    max_mean = max(SGR_mean(:,1,p));
                    row_max = find(SGR_mean(:,1,p) == max_mean); 
                    row_max = row_max(1); %in case there are many == max 
                    SGR_mean(row_max,3,p) = SGR_mean(row_max,1,p); 
                    SGR_mean(row_max,4,p) = SGR_mean(row_max,2,p); 
                    %If would like to see the SGR data array, add 
                    %disp(SGR_mean) to script

                    %Store maximum mean values and corresponding std values
                    %in output array
                    TM_SGR(p,2) = SGR_mean(row_max,1,p);
                    TM_SGR(p,3) = SGR_mean(row_max,2,p); 
                    
                end  
                
                
                %% Calculate relative growth rates (SGR/m_max)
                m_max = max(TM_SGR(:,2));
                TM_SGR(:,4) = TM_SGR(:,2)./m_max; %relative mean
                TM_SGR(:,5) = TM_SGR(:,3)./m_max; %relative std
                
        end
end

