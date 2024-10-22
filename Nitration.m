close all;clear all

% Sensitivity analysis
E0n = 0.140; 
P0n = 0.574;
S0n = 0.286;
W0n = [E0n P0n S0n];

AHP_nitration = [0.338806791	0.336065574	0.2;
0.352953382	0.295081967	0.2;
0.308239827	0.352459016	0.2;
0	0.016393443	0.4];

TOPSIS_nitration = [0.585913235	0.589943325	0.377964473;
0.610377549	0.517999017	0.377964473;
0.533052463	0.618721048	0.377964473;
0	0.028777723	0.755928946];


Wn = []; %deifne matrix of unknown size
Rn = [];
Tn = [];
Smaxn = [];
Sminn= [];
Pin = [];

for En= [0:0.005:1]
for Pn = [0:0.005:1-En]
   
    Sn = 1-En-Pn;
    Wn = [Wn; En Pn Sn]; % use ";" to go to next row of matix

    Rn = [Rn; (AHP_nitration*Wn(end,:)')']; % AHP score calculation
    
    Tn = TOPSIS_nitration.*Wn(end,:);
    
    Vmaxn = max(Tn);
    Vminn= min(Tn);

    Smaxn = [(sum(((Tn-Vmaxn).^2),2)).^0.5]';
    Sminn = [(sum(((Tn-Vminn).^2),2)).^0.5]';
    
    Pin = [Pin; Sminn./(Smaxn+Sminn)];
end 
end

%AHP
[Cn,In] = max(Rn,[],2);

%I_AHPn = sort(In,2);

% [Bn,~,ibn] = unique(In,'rows');
% numoccurencesn = accumarray(ibn,1);
% indicesn = accumarray(ibn, find(ibn), [], @(rows){rows});  %the find(ib) simply generates (1:size(a,1))'

An = [Wn In];

%TOPIS
[C2n,I2n] = max(Pin,[],2);

%I_TOPSISn = sort(I2n,2);

%[B2n,~,ib2n] = unique(I2n,'rows');
%numoccurences2n = accumarray(ib2n,1);
%indices2n = accumarray(ib2n, find(ib2n), [], @(rows){rows});  %the find(ib) simply generates (1:size(a,1))'

A2n = [Wn I2n];


%AHP plot
l=length(An);
An(l+1,:)=[1 0 0 1];
An(l+2,:)=[0 1 0 4];
An(l+3,:)=[0 0 1 1];

figure;
colormap(brewermap(4,'Paired'))
[hg,htick,hcb] = tersurf(An(:,1),An(:,2),An(:,3),An(:,4));
hlabels=terlabel('Economic potential','Performance','Safety and Environment');
set(gcf,'paperpositionmode','auto','inverthardcopy','off')
ax = gca;
c = ax.Colorbar;
c.Ticks = 1:4;
c.TickLabels = {'H-ZSM-5','H-Y','H-Mordenite','No catalyst'};
figExport(12,8,'AHP_nitration')

%TOPSIS plot
l=length(A2n);
A2n(l+1,:)=[1 0 0 1];
A2n(l+2,:)=[0 1 0 4];
A2n(l+3,:)=[0 0 1 1];

figure;
colormap(brewermap(4,'Paired'))
[hg,htick,hcb] = tersurf(A2n(:,1),A2n(:,2),A2n(:,3),A2n(:,4));
hlabels=terlabel('Economic potential','Performance','Safety and Environment');
set(gcf,'paperpositionmode','auto','inverthardcopy','off')
ax = gca;
c = ax.Colorbar;
c.Ticks = 1:4;
c.TickLabels = {'H-ZSM-5','H-Y','H-Mordenite','No catalyst'};
figExport(12,8,'TOPSIS_nitration')