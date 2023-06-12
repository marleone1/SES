clear all
close all
NN=81;

DIR=dir;

str=DIR(13).name;

numfiles=numel(DIR);
EffTresh=1-1/NN;
% EffTresh=0.9;


mmm=1;
load Patterns_NN81_5000_
        
Num_test_patt=numel(Patterns_V(1,:));
        
        
for fff=1:numfiles;
    
    str=DIR(fff).name;
    StrFindFile = strfind(str,'G_Matrices_Coeffs');
    if StrFindFile==1
        
        StrFind = strfind(str,'Random');
        Eigen=isempty(StrFind);
        
        StrFind = strfind(str,'_Exp');
        if StrFind==27
            ChosenPatternIndex_txt=str(StrFind-3:StrFind-1);
        elseif StrFind==26
            ChosenPatternIndex_txt=str(StrFind-2:StrFind-1);
        elseif StrFind==25
            ChosenPatternIndex_txt=str(StrFind-1:StrFind-1);
        end
        ChosenPatternIndex=str2num(ChosenPatternIndex_txt);
        

        [RecEff(mmm) RecFailure(mmm) efficiency_1diagSTD(mmm) efficiency_1diagAVG(mmm) PP_vect(mmm) INT_Targ_patt(mmm) INT_Tests_s_STD(mmm) ChosenPatternIndex_V(mmm) Eigen_V(mmm)]=S_5_Eff_Tests_Fun_V5(str,ChosenPatternIndex,Patterns_V,Num_test_patt,EffTresh);
        mmm=mmm+1;
    end
end


Rand_V=logical(abs(Eigen_V-1));

PP_vect_Eigen=PP_vect((logical(Eigen_V)));
PP_vect_Random=PP_vect(Rand_V);

RecEff_Random=RecEff(Rand_V);
RecEff_Eigen=RecEff(logical(Eigen_V));

RecFailure_Eigen=RecFailure(logical(Eigen_V));
RecFailure_Random=RecFailure(logical(Rand_V));

efficiency_1diagAVG_Eigen=efficiency_1diagAVG(logical(Eigen_V));
efficiency_1diagAVG_Random=efficiency_1diagAVG(logical(Rand_V));

efficiency_1diagSTD_Eigen=efficiency_1diagSTD(logical(Eigen_V));
efficiency_1diagSTD_Random=efficiency_1diagSTD(logical(Rand_V));


% figure
% plot(PP_vect_Eigen,RecEff_Eigen,'ob')
% hold on
% plot(PP_vect_Random,RecEff_Random,'or')
% title('Recog  perc')
% PP_vect_Eigen


% figure
% plot(PP_vect_Eigen,efficiency_1diagAVG_Eigen,'ob')
% hold on
% plot(PP_vect_Random,efficiency_1diagAVG_Random,'or')
% title('Eff AVG')

% figure
% plot(PP_vect_Eigen,efficiency_1diagSTD_Eigen,'ob')
% hold on
% plot(PP_vect_Random,efficiency_1diagSTD_Random,'or')
% title('Eff STD')


%% data clustering
%   PP_Cluster=[1 2 3 4 5 7 8 10 12 16 20 24 28 36 40 44 48 52 56 68 76 68 84 100 200 ];
% PP_Cluster=[1 4 8 10 16 20 24 28 36 40 44 48 52 56 ];
 PP_Cluster=[12 40 ];

for ccc=1:numel(PP_Cluster)
    clear RecEff_Eigen_tmp RecEff_Random_tmp
    eee=1;
    rrr=1;
    for ttt=1:numel(RecEff_Eigen)
        if PP_vect_Eigen(ttt)==PP_Cluster(ccc)
            RecEff_Eigen_tmp(eee)=RecEff_Eigen(ttt);
            RecFailure_Eigen_tmp(eee)=RecFailure_Eigen(ttt);
            eee=eee+1;
        end
        if PP_vect_Random(ttt)==PP_Cluster(ccc)
            RecEff_Random_tmp(rrr)=RecEff_Random(ttt);
            RecFailure_Random_tmp(rrr)=RecFailure_Random(ttt);
            rrr=rrr+1;
        end
    end
    RecEff_Eigen_AVG(ccc)=mean(RecEff_Eigen_tmp);
    RecEff_Eigen_ERR(ccc)=std(RecEff_Eigen_tmp)/(rrr-2);
    RecEff_Random_AVG(ccc)=mean(RecEff_Random_tmp);
    RecEff_Random_ERR(ccc)=std(RecEff_Random_tmp)/(rrr-2);
    
    RecFailure_Eigen_AVG(ccc)=mean(RecFailure_Eigen_tmp);
    RecFailure_Eigen_ERR(ccc)=std(RecFailure_Eigen_tmp)/(rrr-2);
    RecFailure_Random_AVG(ccc)=mean(RecFailure_Random_tmp);
    RecFailure_Random_ERR(ccc)=std(RecFailure_Random_tmp)/(rrr-2);;
    
    
end

%%
% figure
% errorbar(PP_Cluster,RecEff_Random_AVG,RecEff_Random_ERR,'or','markersize',10)
% hold on
% 
% errorbar(PP_Cluster,RecEff_Eigen_AVG,RecEff_Eigen_ERR,'^b','markersize',10)
% ylabel('Classification Efficiency')
% xlabel('Num Patterns')

% legend('Random Decimation','Eigenvalues Decimation','location','southeast')
% ylim([0.2 1.04])


figure
errorbar(PP_Cluster,RecFailure_Random_AVG,RecFailure_Random_ERR,'or','markersize',10)
hold on
errorbar(PP_Cluster,RecFailure_Eigen_AVG,RecFailure_Eigen_ERR,'^b','markersize',10)


ylabel('Number of errors')
xlabel('Num Patterns')

legend('Random Decimation','Eigenvalues Decimation','location','southeast')
% ylim([0.2 1.04])


%%


RecFailure_Eigen_AVG_mod=RecFailure_Eigen_AVG;
RecFailure_Eigen_AVG_mod(RecFailure_Eigen_AVG_mod==0)=1.81*10^-5;
RecFailure_Eigen_ERR_mod=RecFailure_Eigen_ERR;
RecFailure_Eigen_ERR_mod(RecFailure_Eigen_ERR_mod==0)=6.7*10^-6;
figure
set(gcf,'position',[680   743   560   235],'color','w')
errorbar(PP_Cluster,RecFailure_Random_AVG,RecFailure_Random_ERR,'or','markersize',10)
hold on
errorbar(PP_Cluster,RecFailure_Eigen_AVG_mod,RecFailure_Eigen_ERR_mod,'^b','markersize',10)
plot([81 81],[10^-8 1.2],'--k')
set(gca, 'XScale','log', 'YScale','log','linewidth',2,'fontsize',12)


ylabel('Classification Error %')
xlabel('Num of patterns $\mathcal{M}^*$  $\mathcal{N}$ $\otimes$','interpreter','latex')
lll=legend('Random Decimation','Eigenvalues Decimation','location','southwest')
set(lll,'position',[0.613690476190475,0.80424982841455,0.367857134608286,0.172340420966453])
ylim([ 10^-5 5])
xlim([ 10^0 3*10^2])


%%


clear TV_nm_Final
% load G_Matrices_Coeffs_Targ_256_Experimental_Eigen_eff_DPP80__NN_81

% load G_Matrices_Coeffs_Targ_239_Experimental_Random_eff_DPP16__NN_81
% load G_Matrices_Coeffs_Targ_239_Experimental_Eigen_eff_DPP16__NN_81
%%
% load G_Matrices_Coeffs_Targ_114_Experimental_Eigen_eff_DPP40__NN_81
% load G_Matrices_Coeffs_Targ_67_Experimental_Eigen_eff_DPP10__NN_81
load G_Matrices_Coeffs_Targ_27_Experimental_Eigen_eff_DPP12__NN_81_BITS_4


for ppp=1:600
    Pattern_Chosen=Patterns_V(:,ppp);
    Pattern_Chosen=Pattern_Chosen.';
    INT_Tests(ppp)=(Pattern_Chosen*TV_nm_Final)*Pattern_Chosen.';
%     INT_Tests_Abs(ppp)=abs(INT_Tests(ppp));
    

end
INT_Tests=INT_Tests/max(INT_Tests) ;
INT_Targ_patt=INT_Tests(ChosenPatternIndex);



figure
set(gcf,'color','w')
set(gcf,'position',[680   762   560   216])
subplot(1,2,1)
plot(INT_Tests)
hold on
plot(ChosenPatternIndex,INT_Targ_patt ,'or')
set(gca,'fontsize',10')
ylim([ -0.2 1.05])

ylabel('\textit{Transf. Int. }: $I^{P*,\overrightarrow{\lambda}}$ (a.u.)','interpreter','latex')
xlabel('Pattern Index, \textit{j} ','interpreter','latex')

clear TV_nm_Final
%%
% load G_Matrices_Coeffs_Targ_114_Experimental_Random_eff_DPP40__NN_81
load G_Matrices_Coeffs_Targ_27_Experimental_Random_eff_DPP12__NN_81_BITS_4


for ppp=1:600
    Pattern_Chosen=Patterns_V(:,ppp);
    Pattern_Chosen=Pattern_Chosen.';
    INT_Tests(ppp)=(Pattern_Chosen*TV_nm_Final)*Pattern_Chosen.';
%     INT_Tests_Abs(ppp)=abs(INT_Tests(ppp));
    

end
INT_Tests=INT_Tests/max(INT_Tests) ;

INT_Targ_patt=INT_Tests(ChosenPatternIndex);


set(gcf,'color','w')
% set(gcf,'position',[])
subplot(1,2,2)
plot(INT_Tests )
hold on
plot(ChosenPatternIndex,INT_Targ_patt ,'or')
set(gca,'fontsize',10')


ylabel('\textit{Transf. Int. }: $I^{P*,\overrightarrow{\lambda}}$ (a.u.)','interpreter','latex')
xlabel('Pattern Index, \textit{j} ','interpreter','latex')
% ylim([ -0.2 1.05])



Patter_chosen_M=Patterns(:,:,ChosenPatternIndex);

% load G_Matrices_Coeffs_Targ_114_Experimental_Eigen_eff_DPP40__NN_81
load G_Matrices_Coeffs_Targ_27_Experimental_Eigen_eff_DPP12__NN_81_BITS_4

figure
set(gcf,'color','w')
set(gcf,'position',[680   762   560   216])
subplot(1,2,1)
imagesc(Patter_chosen_M)
axis off
str=['Pattern to be stored $\mathbf{\phi}^{*}$']
title(str,'interpreter', 'latex')

[V,D] = eig(TV_nm_Final);
Eigens = diag(D);
V1_M(:,1)=V(:,NN);

Patter_Stored_M=reshape(V1_M,[sqrt(NN) sqrt(NN) ])
Patter_Stored_MS=sign(Patter_Stored_M);

figure
set(gcf,'color','w')
set(gcf,'position',[680   762   560   216])
subplot(1,2,1)
imagesc(Patter_Stored_MS)
axis off
str=['Pattern actually stored $\mathbf{\xi}_{\Sigma}$']
title(str,'interpreter', 'latex')

title('Pattern actually stored')

figure
set(gcf,'color','w')
set(gcf,'position',[680   762   560   216])
subplot(1,2,1)
imagesc(TV_nm_Final)
axis off
colormap hot
str=['Transmission matrix $\mathbf{J}^{\mathbf{\mathcal{M}},\mathbf{\lambda}}_{\mathbf{T}}$']

% str=['Transmission matrix $\bm{J}^{\bm{\mathcal{M}},\bm{\lambda}}_{\bm{T}}$']
title(str,'interpreter', 'latex')
