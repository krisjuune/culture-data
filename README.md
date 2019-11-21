# culture-data
A MatLAB toolbox to do daily culture monitoring &amp; obtain/plot biological growth rate data 

## Overview
This toolbox organizes the culture data into a form that is easily manipulated & navigated, it can be used to plot the daily measurements in order to monitor the cultures. The functions also calculate the instantaneous, specific, and relative growth rates and can be used to plor the grwoth rate data. The toolbox is based on experiments in triplicates using the Spark multimode plate reader, which exports data as Excel files. The 'Growth rate' scripts are for numerous subcultures.  

1. Data table 
  1. Read Spark data
  - [] write script
  1. Create data table 
1. Monitoring
  1. Organize data 
  1. Plot daily measurements
  - [] write script (commented in org_data.m)
1. Growth rates
  1. Calculate specific and relative growth rates
  1. Plot growth rate data
  
## Data table 
Produce a long data matrix with four columns from Spark raw data (Excel files). 
### Read Spark data 
Functions to be written. 
Script 1 - creates string array containing the measurement times for each of the cultures. 
Script 2 - creates a .txt table containing the measured Chlorophyl values (as columns) for each of the cultures. 
Script 3 - creates a .txt table containing the corresponding blank values (as columns) for each of the cultures. 
### Create data table
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
Function to calculate corrected Chl values, log_Chl, and to produce a half empty data matrix, containing the times of easurements as the 1st column,and the corresponding Chl values as the 2nd column, and log_Chl is as the 5th column. The input data matrix has to be in the form as returned by the unction data_table. Other inputs include a string array of dates, and a row vector containing the trace metal concentrations.

In order to observe the growth phase of organisms, plot the 1st column of the data matrix against the 5th column.
### Plot daily measurements
Script to be written but exists already in the org_data.m function (is commented out). 

## Growth rates
Script calculates the specific and relative growth rates and can be used to plot the pooled values for selected subcultures. 
### Calculate specific & relative growth rates
Function to calculate specific growth rates (SGR), their means (mean) and standard deviations (std) between triplicates, given the time period in mid exponential (assumes that measurements were taken every day during this period of time, or this should be at least considered when setting the phase), and a half empty data matrix, containing the times of measurements as the 1st column, and the corresponding Chl values as the 2nd column.

Function returns array with 5 columns as: 
TM_conc | mean SGR | std of SGR | mean RGR | std of RGR
------- | -------- | ---------- | -------- | ----------
565 | 0.8643 | 0.0976 | 0.7769 | 0.1034
### Plot growth rate data
Script for plotting the relative pooled growth rates of different organisms against Cu/Fe concentrations.

Plot the pooled means of relative growth rates with error bars on a semilogx plot.
