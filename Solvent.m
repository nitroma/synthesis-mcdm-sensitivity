close all;clear all

% Sensitivity analysis
% C0s = ; 
% P0s= ;
% S0s = ;
% E0s = ;
% W0s = [C0s P0s S0s E0s];

AHP_solvent = [0.280193304	0.259491783	0.166666667	0.25;
0.20547509	0.190557615	0.233333333	0.18;
0.16764704	0.189424856	0.233333333	0.2;
0.213125758	0.074196941	0.266666667	0.21;
0.133558808	0.286328805	0.1	0.16];

TOPSIS_solvent = [0.608405566	0.544618244	0.357142857	0.55269711;
0.446164081	0.399940038	0.5	0.397941919;
0.364025087	0.397562616	0.5	0.442157688;
0.462776574	0.15572365	0.571428571	0.464265573;
0.290006653	0.600943463	0.214285714	0.353726151];


Ws = []; %define matrix of unknown size
Rs = [];
Ts = [];
Smaxs = [];
Smins= [];
Pis = [];

for Cs= [0:0.1:1]
for Ps = [0:0.1:1-Cs]
for Ss = [0:0.1:1-Cs-Ps]
   
    Es = 1-Cs-Ps-Ss;
    Ws = [Ws; Cs Ps Ss Es]; % use ";" to go to next row of matix

    Rs = [Rs; (AHP_solvent*Ws(end,:)')']; % AHP score calculation
    
    Ts = TOPSIS_solvent.*Ws(end,:);
    
    Vmaxs = max(Ts);
    Vmins= min(Ts);

    Smaxs = [(sum(((Ts-Vmaxs).^2),2)).^0.5]';
    Smins = [(sum(((Ts-Vmins).^2),2)).^0.5]';
    
    Pis = [Pis; Smins./(Smaxs+Smins)];
end 
end
end

%AHP
[Cs,Is] = max(Rs,[],2);

%I_AHPn = sort(In,2);

%[Bs,~,ibs] = unique(Is,'rows');
numoccurencesn = accumarray(Is,1);
%indicesn = accumarray(ibs, find(ibs), [], @(rows){rows});  %the find(ib) simply generates (1:size(a,1))'

As = [Ws Is];

ind3 = As(:,5) == 2;
A3s = As(ind3,:);

%TOPIS
[C2s,I2s] = max(Pis,[],2);

%I_TOPSISn = sort(I2n,2);

%[B2s,~,ib2s] = unique(I2s,'rows');
numoccurences2n = accumarray(I2s,1);
%indices2n = accumarray(ib2s, find(ib2s), [], @(rows){rows});  %the find(ib) simply generates (1:size(a,1))'

A2s = [Ws I2s];

ind4 = A2s(:,5) == 2;
A4s = A2s(ind4,:);



% %if not same combinations in B and B2
% % D = [I_AHP;I_TOPSIS];
% % 
% % [F,~,ib3] = unique(D,'rows');
% % 
% % n = ceil(numel(ib3)/2);
% % ib4 = ib3(1:n);
% % ib5 = ib3(n+1:end);
% % 
% % numoccurences4 = accumarray(ib4,1);
% % indices4 = accumarray(ib4, find(ib4), [], @(rows){rows});
% % 
% % A4 = [W ib4];
% % 
% % numoccurences5 = accumarray(ib5,1);
% % indices5 = accumarray(ib5, find(ib5), [], @(rows){rows});
% % 
% % A5 = [W ib5];
% 
% 
% %AHP plot
% l=length(As);
% As(l+1,:)=[1 0 0 1];
% As(l+2,:)=[0 1 0 4];
% As(l+3,:)=[0 0 1 1];
% 
% figure;
% colormap(brewermap(4,'Paired'))
% [hg,htick,hcb] = tersurf(As(:,1),As(:,2),As(:,3),As(:,4));
% hlabels=terlabel('Economic potential','Performance','Safety and Environment');
% set(gcf,'paperpositionmode','auto','inverthardcopy','off')
% figExport(12,8,'AHP_nitration')
% 
% %TOPSIS plot
% l=length(A2s);
% A2s(l+1,:)=[1 0 0 1];
% A2s(l+2,:)=[0 1 0 4];
% A2s(l+3,:)=[0 0 1 1];
% 
% figure;
% colormap(brewermap(4,'Paired'))
% [hg,htick,hcb] = tersurf(A2s(:,1),A2s(:,2),A2s(:,3),A2s(:,4));
% hlabels=terlabel('Economic potential','Performance','Safety and Environment');
% set(gcf,'paperpositionmode','auto','inverthardcopy','off')
% figExport(12,8,'TOPSIS_nitration')