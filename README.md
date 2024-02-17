This folder contains the main codes, sample input data and main result files to reproduce the analysis and results presented in Sun et al, 2024

“data”: A folder that contains input data which is used in the codes for plotting all figures in the paper. 
Rf1day_tas_change_regrid_025dg.mat is data for percentage changes in extreme rainfall relative to changes in global or local temperature change；
Rx1day_tas_change_regrid_025dg.mat is data for percentage changes in extreme precipitation relative to changes in global or local temperature change at individual grid；
Tx1day_tas_change_regrid_025dg.mat is data for percentage changes in precipitable water relative to changes in global or local temperature change at individual grid；
Rf1day_absolute_change.mat is data for absolute change in extreme rainfall at individual grid；
ERA5_025_temperature_change.mat is data for local temperature change at individual grid;
dem.mat is elevation derived from ERA-5 dataset;
lon_lat.mat is longitude and latitude  at individual grid derived from ERA-5 dataset;
area_weight_025dg.mat is area weight at individual grid;


“code”: A folder that contains the codes for plotting all figures in the paper. 
read_figure1.m is the code to plot  Figure 1 in Sun et al. (2024)；
read_figure2.m is the code to plot  Figure 2 in Sun et al. (2024)；
read_figure_S1.m is the code to plot Supplementary Fig. 1 in Sun et al. (2024)；
wprctile.m is the code to estimate weighted percentiles of a sample.
