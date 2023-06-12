clear all
close all
NN=81;

DIR=dir;

% str=DIR(13).name;

numfiles=numel(DIR);
% EffTresh=1-1/NN;
% EffTresh=0.9;


mmm=1;
load Patterns_NN81_5000_
        
Num_test_patt=numel(Patterns_V(1,:));
        
        
for fff=1:numfiles;
    % for fff=103:103;
    
    
    filename=DIR(fff).name;
    StrFindFile = strfind(filename,'G_Matrices_Coeffs');
    if StrFindFile==1
        
        StrFind = strfind(filename,'Random');
        Eigen_V(mmm)=isempty(StrFind);
        
        %         StrFind = strfind(filename,'_Exp');
        load (filename)
        
        Pattern_Chosen=Patterns(:,:,ChosenPatternIndex);
        
        %         Pattern_RetrievalFun
        [Retrieval_Error(mmm) Inv(mmm)]=Pattern_RetrievalFun(Pattern_Chosen,TV_nm_Final,NN);
        PP_vect(mmm)=PP;
        %         [RecEff(mmm) RecFailure(mmm) efficiency_1diagSTD(mmm) efficiency_1diagAVG(mmm) PP_vect(mmm) INT_Targ_patt(mmm) INT_Tests_s_STD(mmm) ChosenPatternIndex_V(mmm) Eigen_V(mmm)]=S_5_Eff_Tests_Fun_V5(str,ChosenPatternIndex,Patterns_V,Num_test_patt,EffTresh);
        mmm=mmm+1;
    end
end

Eigen_V=logical(Eigen_V);
Rand_V=logical(abs(Eigen_V-1));

PP_vect_Eigen=PP_vect((Eigen_V));
PP_vect_Random=PP_vect(Rand_V);

Retrieval_Error_Random=Retrieval_Error(Rand_V);
Retrieval_Error_Eigen=Retrieval_Error(logical(Eigen_V));


 PP_Cluster=[ 12  40  ];

for ccc=1:numel(PP_Cluster)
    clear RecEff_Eigen_tmp RecEff_Random_tmp
    eee=1;
    rrr=1;
    for ttt=1:numel(Retrieval_Error_Random)
        if PP_vect_Eigen(ttt)==PP_Cluster(ccc)
            Retrieval_Error_Eigen_tmp(eee)=Retrieval_Error_Eigen(ttt);
            eee=eee+1;
        end
        if PP_vect_Random(ttt)==PP_Cluster(ccc)
            Retrieval_Error_Random_tmp(rrr)=Retrieval_Error_Random(ttt);
            rrr=rrr+1;
        end
    end
    Retrieval_Error_Eigen_AVG(ccc)=mean(Retrieval_Error_Eigen_tmp);
    Retrieval_Error_Eigen_ERR(ccc)=std(Retrieval_Error_Eigen_tmp)/(rrr-2);
    Retrieval_Error_Random_AVG(ccc)=mean(Retrieval_Error_Random_tmp);
    Retrieval_Error_Random_ERR(ccc)=std(Retrieval_Error_Random_tmp)/(rrr-2);
    
%     RecFailure_Eigen_AVG(ccc)=mean(RecFailure_Eigen_tmp);
%     RecFailure_Eigen_ERR(ccc)=std(RecFailure_Eigen_tmp)/(rrr-2);
%     RecFailure_Random_AVG(ccc)=mean(RecFailure_Random_tmp);
%     RecFailure_Random_ERR(ccc)=std(RecFailure_Random_tmp)/(rrr-2);;
    
    
end

%%
close all
figure
set(gcf,'position',[680   743   560   235],'color','w')
errorbar(PP_Cluster,Retrieval_Error_Random_AVG,Retrieval_Error_Random_ERR,'or','markersize',10)
hold on
errorbar(PP_Cluster,Retrieval_Error_Eigen_AVG,Retrieval_Error_Eigen_ERR,'^b','markersize',10)
plot([81 81],[10^-8 1.2],'--k')
set(gca,'linewidth',2,'fontsize',12)

ylabel('Storage Error Prob.')
% xlabel('Num of patterns $\mathcal{M}^*$  $\mathcal{N}$ $\otimes$','interpreter','latex')
xlabel('Num of patterns $\mathcal{M}^*$ ','interpreter','latex')

lll=legend('Random Decimation','Eigenvalues Decimation','location','southwest')
set(lll,'position',[0.52440476190476,0.731909402882635,0.367857134608286,0.172340420966453])
ylim([ 0 0.6])

xlim([ 10^0 2*10^2])


%%
figure
set(gcf,'position',[680   743   560   235],'color','w')
errorbar(PP_Cluster,Retrieval_Error_Random_AVG,Retrieval_Error_Random_ERR,'or','markersize',10)
hold on
errorbar(PP_Cluster,Retrieval_Error_Eigen_AVG,Retrieval_Error_Eigen_ERR,'^b','markersize',10)
plot([81 81],[10^-8 1.2],'--k')
set(gca, 'XScale','log', 'YScale','log','linewidth',2,'fontsize',12)


ylabel('Storage Error Prob.')
% xlabel('Num of patterns $\mathcal{M}^*$  $\mathcal{N}$ $\otimes$','interpreter','latex')
xlabel('Num of patterns $\mathcal{M}^*$ ','interpreter','latex')

lll=legend('Random Decimation','Eigenvalues Decimation','location','southwest')
set(lll,'position',[0.52440476190476,0.731909402882635,0.367857134608286,0.172340420966453])
ylim([ 5*10^-3 1])
xlim([ 10^0 5*10^2])

%%