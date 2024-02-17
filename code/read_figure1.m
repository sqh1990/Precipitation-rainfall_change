%% Changes in temperature, and percentage changes in extreme precipitation (Rx1day), extreme rainfall (Rf1day_tas), and precipitable water (Tx1day) during days of extreme rainfall occurrence, relative to local temperature change.

clear
clc
load('area_weight_025dg.mat')
load('lon_lat_ERA5.mat')
lat=flipud(lat);
[LAT LON]=meshgrid(lat,lon);

id=find(lat==20);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id:end);
load('ERA5_025_mask.mat');
mask=mask(:,id:end);
W=W(:,id:end);
LAT=LAT(:,id:end);
load('Rf1day_tas_change_025dg.mat'); %% Extreme rainfall change
Rf1day_tas=Rf1day_tas(:,id:end);  %% Extreme rainfall change scaled by local temperature change
Rf1day_tas_global=Rf1day_tas_global(:,id:end); %% Extreme rainfall change scaled by global temperature change

load('Rx1day_tas_change_025dg.mat'); %% Extreme precipitation change
Rx1day_tas=Rx1day_tas(:,id:end); %% Extreme precipitation change scaled by local temperature change
Rx1day_tas_global=Rx1day_tas_global(:,id:end);  %% Extreme precipitation change scaled by global temperature change

load('Tx1day_tas_change_025dg.mat'); %% Precipitable water change
Tx1day_tas=Tx1day_tas(:,id:end); %% Precipitable water change scaled by local temperature change
Tx1day_tas_global=Tx1day_tas_global(:,id:end); %% Precipitable water change scaled by global temperature change
change_tas=change_tas(:,id:end);
dem_diff=[0:500:6000];

for i=1:length(dem_diff)-1
    idx=find(dem>=dem_diff(i) & dem<dem_diff(i+1));
    dem1=dem;
    dem1(isnan(dem1)~=1)=nan;
    dem1(idx)=1;

    %% Extreme precipitation change at different elevation category
    c1=Rx1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,1)=wprctile(c2,50,W(idx2),4);
    change_boot(i,1,:) = bootstrp(1000,@wprctile,c2,50,w1,4);


    %% Extreme rainfall change at different elevation category
    c1=Rf1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,2)=wprctile(c2,50,W(idx2),4);
    change_boot(i,2,:) = bootstrp(1000,@wprctile,c2,50,w1,4);


    %% Extreme precipitable water change at different elevation category
    c1=Tx1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);

    change_estimate(i,3)=wprctile(c2,50,W(idx2),4);
    change_boot(i,3,:) = bootstrp(1000,@wprctile,c2,50,w1,4);

    %% Extreme temperature change at different elevation category
    c1=change_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);

    change_estimate(i,4)=wprctile(c2,50,W(idx2),4);
    change_boot(i,4,:) = bootstrp(1000,@wprctile,c2,50,w1,4);

    %% LAT
    c1=LAT.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    LAT_estimate(i)=nanmedian(c2);
    LAT_25(i)=prctile(c2,25);
    LAT_75(i)=prctile(c2,75);
    LAT_95(i)=max(c2);
    LAT_5(i)=min(c2);

    num_idx(i)=length(find(isnan(c1)==0));

end


%%
for i=1:12
    for j=1:4
        a=squeeze(change_boot(i,j,:));
        change_best(i,j)=mean(a);
        change_5(i,j)=prctile(a,5);
        change_95(i,j)=prctile(a,95);
    end
end


%% plot temperature change
subplot(2,1,1)
for i=1:12
    plot([i i],[LAT_5(i) LAT_95(i)],'color','k','LineStyle','-')
    hold on
    h3=rectangle('Position',[i-0.1 LAT_25(i) 0.2 LAT_75(i)-LAT_25(i)],'FaceColor',[0.3 0.7 1])
    plot([i-0.1 i+0.1],[LAT_estimate(i) LAT_estimate(i)],'LineStyle','-','color','b');
end

ylim([20 90])
ylabel('Latitude (°N)')
tick=num2cell([250:500:5750]);

ax1 = gca;
set(ax1,'XColor','k','YColor','b','YAxisLocation','right','xtick',1:12,'Color','none','XAxisLocation','top',...
    'xticklabel',{'  '})
xlim([0 13])
box off


ax2=axes('Position',get(ax1,'Position'),...
    'XAxisLocation','bottom',...
    'YAxisLocation','left',...
    'Color','none',...
    'XColor','k','YColor','k',...
    'xtick',1:12,...
    'xticklabel',tick);
hold on; 
h=plot([0 13],[0.6231 0.6231],'--','color',[0.3 0.3 0.3])
hold on
plot((1:12),change_estimate(:,4),'.','color','m','MarkerSize',20);
hold on

for i=1:12
    h1=plot([i i],[change_5(i,4) change_95(i,4)],'color','m');
end

ylim([0 2])
xlim([0 13])
ylabel('Changes in temperature (K)')
xlabel('Elevation')
ax2.Color='none'
title('(a)')
legend([h h1],{'Global temperature change' 'Local temperature change'})
ax.TitleHorizontalAlignment = 'left'


%% plot extreme rainfall/precipitation/precipitable water change
subplot(2,1,2)

plot([0 13],[7 7],'--','color',[0.3 0.3 0.3])
hold on

plot((1:12)-0.15,change_estimate(:,1),'.','color','b');
hold on

for i=1:12
    plot([i-0.15 i-0.15],[change_5(i,1) change_95(i,1)],'color','b');
end

plot((1:12),change_estimate(:,2),'.','color','r');
hold on

for i=1:12
    plot([i i],[change_5(i,2) change_95(i,2)],'color','r');
end

plot((1:12)+0.15,change_estimate(:,3),'.','color','k');
hold on

for i=1:12
    plot([i+0.15 i+0.15],[change_5(i,3) change_95(i,3)],'color','k');
end

ylim([-5 15])
ylabel('Changes rate (%/K)')
xlabel('Elevation')
tick=num2cell([250:500:5750]);
set(gca,'xtick',1:12,'XTickLabel',tick);
title('(b)')
ax.TitleHorizontalAlignment = 'left'
xlim([0 13])


