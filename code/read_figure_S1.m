%% plot Elevation
clear
clc

load('lon_lat_ERA5.mat')
lat=flipud(lat);
id=find(lat==20);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id:end);
load('ERA5_025_mask.mat');
mask=mask(:,id:end);

dem_diff=[0:500:6000];
dem1=ones(size(dem,1),size(dem,2)).*nan;
for i=1:length(dem_diff)-1
    idx=find(dem>=dem_diff(i) & dem<dem_diff(i+1));
    dem1(idx)=i;
end
dem1=dem1-0.5;
lon=-179.8750:0.25:179.8750;

data=dem1'.*mask';
data1(:,721:1440)=data(:,1:720);
data1(:,1:720)=data(:,721:1440);
subplot(2,2,1)
h=imagesc(lon,lat(id:end),data1)
set(gca,'YDir','normal')
set(h, 'AlphaData', ~isnan(data1))
load('color32_5.mat')
caxis([0 12])
% colormap(flipud(color))
colormap(jet(12))
coast=load('coast.mat')
hold on
plot(coast.long,coast.lat,'k');
set(gca,'xticklabel',{' '},'yticklabel',{' '})
% shading interp
title('(a) Elevation (m)')
tick=num2cell([250:500:5750]);
colorbar('Ticks',0.5:12,...
         'TickLabels',tick)


%% plot temperature change
clear
clc

load('lon_lat_ERA5.mat')
lat=flipud(lat);
id=find(lat==20);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id:end);
load('ERA5_025_mask.mat');
mask=mask(:,id:end);
 load('ERA5_025_temperature_change.mat')

change_tas=flipud(change_tas');
change_tas=change_tas';
change_tas=change_tas(:,id:end);

lon=-179.8750:0.25:179.8750;

data=change_tas.*mask;
data1(1:720,:)=data(721:end,:);
data1(721:1440,:)=data(1:720,:);

subplot(2,2,2)
h=imagesc(lon,lat(id:end),data1')
set(gca,'YDir','normal')
set(h, 'AlphaData', ~isnan(data1'))
load('color32_5.mat')
caxis([-2 2])
colormap(color)
coast=load('coast.mat')
hold on
plot(coast.long,coast.lat,'k');
set(gca,'xticklabel',{' '},'yticklabel',{' '})
% shading interp
title('(b) Local temperature change (K)')
colorbar


%% plot extreme rainfall during the 1950-1979 period
clear
clc

load('lon_lat_ERA5.mat')
lat=flipud(lat);
id=find(lat==20);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id:end);
load('ERA5_025_mask.mat');
mask=mask(:,id:end);


load('Rf1day_absolute_change.mat')

lon=-179.8750:0.25:179.8750;

data=Rf1day_reference(:,id:end).*mask;
data1(1:720,:)=data(721:end,:);
data1(721:1440,:)=data(1:720,:);

subplot(2,2,3)
h=imagesc(lon,lat(id:end),data1')
set(gca,'YDir','normal')
set(h, 'AlphaData', ~isnan(data1'))
load('color32_5.mat')
caxis([0 150])
colormap(flipud(color))
coast=load('coast.mat')
hold on
plot(coast.long,coast.lat,'k');
set(gca,'xticklabel',{' '},'yticklabel',{' '})
% shading interp
title('(c) Rainfall [1950-1979, mm]')
colorbar



%% plot absolute change in extreme rainfall
clear
clc

load('lon_lat_ERA5.mat')
lat=flipud(lat);
id=find(lat==20);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id:end);
load('ERA5_025_mask.mat');
mask=mask(:,id:end);


load('Rf1day_absolute_change.mat')
lon=-179.8750:0.25:179.8750;
data=change_absolute(:,id:end).*mask;
data1(1:720,:)=data(721:end,:);
data1(721:1440,:)=data(1:720,:);

subplot(2,2,4)
h=imagesc(lon,lat(id:end),data1')
set(gca,'YDir','normal')
set(h, 'AlphaData', ~isnan(data1'))
load('color32_5.mat')
caxis([-50 50])
colormap(flipud(color))
coast=load('coast.mat')
hold on
plot(coast.long,coast.lat,'k');
set(gca,'xticklabel',{' '},'yticklabel',{' '})
% shading interp
title('(d) Absolute change rainfall [mm]')
colorbar

