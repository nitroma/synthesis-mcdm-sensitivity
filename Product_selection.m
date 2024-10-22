close all;clear all

% Sensitivity analysis
E0 = 0.286;
P0 = 0.140;
S0 = 0.574;
W0 = [E0 P0 S0];

AHP_product = [0.197128633	0.149059334	0.178571429;
0.145962897	0.136034732	0.238095238;
0.246109396	0.221418234	0.142857143;
0.076050534	0.208393632	0.142857143;
0.098510344	0.149059334	0.119047619;
0.236238196	0.136034732	0.178571429];

TOPSIS_product = [0.44984600	0.35744286	0.42631532;
0.33308619	0.32620999	0.56842042;
0.56161972	0.53095882	0.34105225;
0.17354672	0.49972594	0.34105225;
0.22479984	0.35744286	0.28421021;
0.53909372	0.32620999	0.42631532];


W = []; %deifne matrix of unknown size
R = [];
T = [];
Smax = [];
Smin = [];
Pi = [];

for E = [0:0.005:1]
for P = [0:0.005:1-E]
   
    S = 1-E-P;
    W = [W; E P S]; % use ";" to go to next row of matix

    R = [R; (AHP_product*W(end,:)')']; % AHP score calculation
    
    T = TOPSIS_product.*W(end,:);
    
    Vmax = max(T);
    Vmin = min(T);

    Smax = [(sum(((T-Vmax).^2),2)).^0.5]';
    Smin = [(sum(((T-Vmin).^2),2)).^0.5]';
    
    Pi = [Pi; Smin./(Smax+Smin)];
end 
end

%AHP
[C,I] = maxk(R,3,2);

I_AHP = sort(I,2);

[B,~,ib] = unique(I_AHP,'rows');
numoccurences = accumarray(ib,1);
indices = accumarray(ib, find(ib), [], @(rows){rows});  %the find(ib) simply generates (1:size(a,1))'

A = [W ib];

%TOPIS
[C2,I2] = maxk(Pi,3,2);

I_TOPSIS = sort(I2,2);

[B2,~,ib2] = unique(I_TOPSIS,'rows');
numoccurences2 = accumarray(ib2,1);
indices2 = accumarray(ib2, find(ib2), [], @(rows){rows});  %the find(ib) simply generates (1:size(a,1))'

A2 = [W ib2];

%if not same combinations in B and B2
% D = [I_AHP;I_TOPSIS];
% 
% [F,~,ib3] = unique(D,'rows');
% 
% n = ceil(numel(ib3)/2);
% ib4 = ib3(1:n);
% ib5 = ib3(n+1:end);
% 
% numoccurences4 = accumarray(ib4,1);
% indices4 = accumarray(ib4, find(ib4), [], @(rows){rows});
% 
% A4 = [W ib4];
% 
% numoccurences5 = accumarray(ib5,1);
% indices5 = accumarray(ib5, find(ib5), [], @(rows){rows});
% 
% A5 = [W ib5];


%AHP plot
l=length(A);
A(l+1,:)=[1 0 0 1];
A(l+2,:)=[0 1 0 7];
A(l+3,:)=[0 0 1 1];

figure;
colormap(brewermap(7,'Paired'))
[hg,htick,hcb] = tersurf(A(:,1),A(:,2),A(:,3),A(:,4));
hlabels=terlabel('Economic potential','Process complexity','Safety and Environment');
set(gcf,'paperpositionmode','auto','inverthardcopy','off')
 set(gcf, 'color', [1 1 1])
figExport(12,8,'AHP_product')

%TOPSIS plot
l=length(A2);
A2(l+1,:)=[1 0 0 1];
A2(l+2,:)=[0 1 0 7];
A2(l+3,:)=[0 0 1 1];

figure;
colormap(brewermap(7,'Paired'))
[hg,htick,hcb] = tersurf(A2(:,1),A2(:,2),A2(:,3),A2(:,4));
hlabels=terlabel('Economic potential','Process complexity','Safety and Environment');
set(gcf,'paperpositionmode','auto','inverthardcopy','off')
 set(gcf, 'color', [1 1 1])
figExport(12,8,'TOPSIS_product')





