# culture-data
A MATLAB toolbox for culture experiments to monitor cells &amp; obtain/plot growth rate data 

## Overview
This toolbox organizes the experimental culture data, obtained from a plate reader, into a form that is easily manipulated & navigated, it can be used to plot the daily measurements in order to monitor the cells. The functions also calculate the instantaneous, specific, and relative growth rates and can be used to plot the grwoth rate data. 
The toolbox is based on experiments in triplicates using the Spark multimode plate reader, which exports data as Excel files. The 'Growth rates' code is designed for experiments involving numerous (at least two) subcultures. 

1. Data table 
  1. Read Spark data
  1. Create data table 
1. Monitoring
  1. Organize data 
  1. Plot daily measurements
1. Growth rates
  1. Calculate specific and relative growth rates
  1. Plot growth rate data
  
## Data table 

Produce a long data matrix for each of the subcultures with four columns from Spark raw data (Excel files). 

### Read Spark data 

Functions to be written. 

Script 1 - creates string array containing the measurement times for each of the cultures. 

Script 2 - creates a .txt table containing the measured Chlorophyl values (as columns) for each of the cultures. 

Script 3 - creates a .txt table containing the corresponding blank values (as columns) for each of the cultures. 

### Create data table

data_table.m

Function to produce a data matrix with 4 columns, 1st one containing timesince the first measurement, 2nd one containing treatment factors (depending on how many different concentrations used), 3rd one containing value factors (1 for Chl values, 0 for blanks), 4th one containing the measurement values.

Function requires a matrix of blank values (daily measurements ascolumns), a separate matrix of Chl (daily measurements as columns) values,a vector containing the trace metal concentrations, and a string with thedates as the input. Function returns the data matrix.

TM - trace metal. 

Output is given in the format: 

measuremnt_time | treatment_factor | value_factor | value_num
--------------- | ---------------- | ------------ | --------- 
701865 | 1 | 1 | 5436
705886 | 2 | 1 | 9862
707992 | 3 | 1 | 12054
701865 | 1 | 0 | 17
705886 | 2 | 0 | 16
707992 | 3 | 0 | 19

## Monitoring

Script calculates the corrected Chlorophyl & log(Chlorophyl) values in order to plot and monitor the cultures. 

### Organize data 

org_data.m

Function to calculate corrected Chl values, log_Chl, and to produce a half empty data matrix, containing the times of easurements as the 1st column,and the corresponding Chl values as the 2nd column, and log_Chl is as the 5th column. The input data matrix has to be in the form as returned by the function data_table. Other inputs include a string array of dates, and a row vector containing the trace metal concentrations.

Calculations assume exponential growth of the cell number (as approximated by Chlorophyll fluorescence).

In order to observe the growth phase of organisms, plot the 1st column of the data matrix against the 5th column looping over the pages.

### Plot daily measurements

plot_daily.m

Plot the daily measurements to obtain time-log(Chl) scatter and errorbar plots.

## Growth rates

Script calculates the specific and relative growth rates and can be used to plot the pooled values for selected subcultures. 

### Calculate specific & relative growth rates

calc_growth.m

Function to calculate specific growth rates (SGR), their means (mean) and standard deviations (std) between triplicates, given the time period in mid exponential (assumes that measurements were taken every day during this period of time, or this should be at least considered when setting the phase), and a half empty data matrix, containing the times of measurements as the 1st column, and the corresponding Chl values as the 2nd column.

Function returns array with 5 columns as: 

TM_conc | mean_SGR | std_of_SGR | mean_RGR | std_of_RGR
------- | -------- | ---------- | -------- | ---------- 
565 | 0.8643 | 0.0976 | 0.7769 | 0.1034
1025 | 0.9876 | 0.1245 | 1.0000 | 0.1245

### Plot growth rate data

plot_growth.m

Script for plotting the relative pooled growth rates of different organisms against Cu/Fe concentrations.

Plot the pooled means of relative growth rates with error bars on a semilogx plot.
