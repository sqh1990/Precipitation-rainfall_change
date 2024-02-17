%% Results for temperate latitudes (20°N-60°N)

clear
clc
load('area_weight_025dg.mat')
load('lon_lat_ERA5.mat')
lat=flipud(lat);
id=find(lat>=20 & lat<=60);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id);
load('ERA5_025_mask.mat');
mask=mask(:,id);
W=W(:,id);

load('Rf1day_tas_change_025dg.mat'); %% Extreme rainfall change
Rf1day_tas=Rf1day_tas(:,id); %% Extreme rainfall change scaled by local temperature change
Rf1day_tas_global=Rf1day_tas_global(:,id);  %% Extreme rainfall change scaled by global temperature change


load('Rx1day_tas_change_025dg.mat'); %% Extreme precipitation change
Rx1day_tas=Rx1day_tas(:,id); %% Extreme precipitation change scaled by local temperature change
Rx1day_tas_global=Rx1day_tas_global(:,id); %% Extreme precipitation change scaled by global temperature change


load('Tx1day_tas_change_025dg.mat'); %% Precipitable water change
Tx1day_tas=Tx1day_tas(:,id);  %% Precipitable water change scaled by local temperature change
Tx1day_tas_global=Tx1day_tas_global(:,id); %% Precipitable water change scaled by global temperature change
change_tas=change_tas(:,id);
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
    change_estimate(i,1)=wprctile(c2,50,W(idx2));
    change_boot(i,1,:) =bootstrp(1000,@wprctile,c2,50,w1);


    %% Extreme rainfall change at different elevation category
    c1=Rf1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,2)=wprctile(c2,50,W(idx2));
    change_boot(i,2,:) =bootstrp(1000,@wprctile,c2,50,w1);


    %% Extreme precipitable water change at different elevation category
    c1=Tx1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,3)=wprctile(c2,50,W(idx2));
    change_boot(i,3,:) =bootstrp(1000,@wprctile,c2,50,w1);


    %% Extreme temperature change at different elevation category
    c1=change_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,4)=wprctile(c2,50,W(idx2));
    change_boot(i,4,:) =bootstrp(1000,@wprctile,c2,50,w1);

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

%% plot temperature change for temperate latitudes (20°N-60°N)
subplot(2,2,1)

h=plot([0 13],[0.6231 0.6231],'--','color',[0.3 0.3 0.3]) %% global temperature change
hold on

plot((1:12),change_estimate(:,4),'.','color','m'); %% local temperature change
hold on

for i=1:12
    h1=plot([i i],[change_5(i,4) change_95(i,4)],'color','m'); %% Range between the 5th and the 95th percentiles of area weighted median changes in local temperature
    hold on
end

xlim([0 13])
ylim([0 2])
ylabel('Changes in temperature (K)')
xlabel('Elevation')
tick=num2cell([250:500:5750]);
set(gca,'xtick',1:12,'XTickLabel',tick);
title('(a) 20°N-60°N')
legend([h h1],{'Global temperature change' 'Local temperature change'})



%% plot extreme rainfall/precipitation change for temperate latitudes (20°N-60°N)
subplot(2,2,3)

plot([0 13],[7 7],'--','color',[0.3 0.3 0.3])
hold on

h1=plot((1:12)-0.15,change_estimate(:,1),'.','color','blue');
hold on

for i=1:12
    plot([i-0.15 i-0.15],[change_5(i,1) change_95(i,1)],'color','blue');
end


h2=plot((1:12),change_estimate(:,2),'.','color','r');
hold on

for i=1:12
    plot([i i],[change_5(i,2) change_95(i,2)],'color','r');
end

h3=plot((1:12)+0.15,change_estimate(:,3),'.','color','k');
hold on

for i=1:12
    plot([i+0.15 i+0.15],[change_5(i,3) change_95(i,3)],'color','k');
end


ylim([-5 50])
ylabel('Changes rate (%/K)')
xlabel('Elevation')
tick=num2cell([250:500:5750]);
set(gca,'xtick',1:12,'XTickLabel',tick);
title('(c) 20°N-60°N')
xlim([0 13])

legend([h1 h2 h3],{'Precipitation' 'Rainfall' 'Precipitable water'})


%% Results for Arctic latitudes (60°N-90°N)
clear
clc
load('area_weight_025dg.mat')
load('lon_lat_ERA5.mat')
lat=flipud(lat);
id=find(lat>60 & lat<=90);
load('dem.mat')
dem=flipud(dem'); dem=dem';
dem=dem(:,id);
load('ERA5_025_mask.mat');
mask=mask(:,id);
W=W(:,id)

load('Rf1day_tas_change_025dg.mat');
Rf1day_tas=Rf1day_tas(:,id);
Rf1day_tas_global=Rf1day_tas_global(:,id);

load('Rx1day_tas_change_025dg.mat');
Rx1day_tas=Rx1day_tas(:,id);
Rx1day_tas_global=Rx1day_tas_global(:,id);

load('Tx1day_tas_change_025dg.mat');
Tx1day_tas=Tx1day_tas(:,id);
Tx1day_tas_global=Tx1day_tas_global(:,id);
change_tas=change_tas(:,id);
dem_diff=[0:500:3000];


for i=1:length(dem_diff)-1
    idx=find(dem>=dem_diff(i) & dem<dem_diff(i+1));
    dem1=dem;
    dem1(isnan(dem1)~=1)=nan;
    dem1(idx)=1;

    %% Extreme precipitation
    c1=Rx1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,1)=wprctile(c2,50,W(idx2));
    change_boot(i,1,:) =bootstrp(1000,@wprctile,c2,50,w1);


    %% Extreme rainfall
    c1=Rf1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,2)=wprctile(c2,50,W(idx2));
    change_boot(i,2,:) =bootstrp(1000,@wprctile,c2,50,w1);

    %% Precipitable water
    c1=Tx1day_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,3)=wprctile(c2,50,W(idx2));;
    change_boot(i,3,:) =bootstrp(1000,@wprctile,c2,50,w1);


    %% tas
    c1=change_tas.*mask.*dem1; cc1=c1;
    idx2=find(isnan(c1)==0); c2=c1(idx2);
    w1=W(idx2);
    change_estimate(i,4)=wprctile(c2,50,W(idx2));
    change_boot(i,4,:) =bootstrp(1000,@wprctile,c2,50,w1);

end


%%
for i=1:6
    for j=1:4
        a=squeeze(change_boot(i,j,:));
        change_best(i,j)=mean(a);
        change_5(i,j)=prctile(a,5);
        change_95(i,j)=prctile(a,95);
    end
end


%% plot temperature change for Arctic latitudes (60°N-90°N)
subplot(2,2,2)

h=plot([0 7],[0.6231 0.6231],'--','color',[0.3 0.3 0.3])
hold on
% plot([0 14],[0 0],'-','color','k')

plot((1:6),change_estimate(:,4),'.','color','m');
hold on

for i=1:6
    h1=plot([i i],[change_5(i,4) change_95(i,4)],'color','m');
end

xlim([0 7])
ylim([0 2])
ylabel('Changes in temperature (K)')
xlabel('Elevation')
tick=num2cell([250:500:2750]);
set(gca,'xtick',1:6,'XTickLabel',tick);
title('(b) 60°N-90°N')
legend([h h1],{'Global temperature change' 'Local temperature change'})




%% plot extreme rainfall/precipitation change for Arctic latitudes (60°N-90°N)

subplot(2,2,4)

plot([0 7],[7 7],'--','color',[0.3 0.3 0.3]);
hold on

plot((1:6)-0.15,change_estimate(:,1),'.','color','blue');
hold on

for i=1:6
    plot([i-0.15 i-0.15],[change_5(i,1) change_95(i,1)],'color','blue');
end


plot((1:6),change_estimate(:,2),'.','color','r');
hold on

for i=1:6
    plot([i i],[change_5(i,2) change_95(i,2)],'color','r');
end

plot((1:6)+0.15,change_estimate(:,3),'.','color','k');
hold on

for i=1:6
    plot([i+0.15 i+0.15],[change_5(i,3) change_95(i,3)],'color','k');
end

ylim([-5 50])
ylabel('Changes rate (%/K)')
xlabel('Elevation')
tick=num2cell([250:500:5750]);
set(gca,'xtick',1:12,'XTickLabel',tick);
title('(d) 60°N-90°N')
xlim([0 7])




