function Decimator_Eigen_Fun5_Pos(V1_M,Num_Patterns,Patterns_V,PP_Full,NN,Num_chosen_patterns,Cam_ROI_Side,V_nm_Store,ChosenPatternIndex,Randomize_Pattern)

% Decimation=['off'];
    Decimation=['eig'];
% Decimation=['coe'];
% Decimation=['ran'];

if Randomize_Pattern
    ChosenPatternIndex=randi([1 Num_Patterns]);
end
Pattern_Chosen=Patterns_V(:,ChosenPatternIndex);


for PPindx=1:PP_Full
    
%     [V,D] = eig(V_nm_Store(:,:,PPindx));
%     Eigens = diag(D);
     V1=V1_M(:,PPindx);
    
    Similarity1(PPindx)=sum(V1.*Pattern_Chosen);

end


[Similarity1_sortD,Similarity1_sort_indicesD] = sort(Similarity1,'descend');
[Similarity1_sortA,Similarity1_sort_indicesA] = sort(Similarity1,'ascend');


if Num_chosen_patterns>7
Similarity1_sort_indicesD_cut=Similarity1_sort_indicesD(1:Num_chosen_patterns);


Selected_Indices_NS=[Similarity1_sort_indicesD_cut   ];
Selected_Coeffs1=ones(1,Num_chosen_patterns);
Selected_Coeffs_NS=[Selected_Coeffs1 ];


Num_Real_chosen_patterns=Num_chosen_patterns;
[Selected_Indices_Eigen Selected_Indices_indices]=sort(Selected_Indices_NS);
Start_Coeffs_Eigen=Selected_Coeffs_NS(Selected_Indices_indices);
Start_Coeffs_Eigen=Start_Coeffs_Eigen.';


else
    Num_Real_chosen_patterns=Num_chosen_patterns;
    Selected_Indices_Eigen=Similarity1_sort_indicesD(1:Num_chosen_patterns);
    Start_Coeffs_Eigen=ones(1,Num_chosen_patterns);
end
    
    


Selected_Indices_Eigen_Log=zeros(1,PP_Full);
Selected_Indices_Eigen_Log(Selected_Indices_Eigen)=1;
Selected_Indices_Eigen_Log=logical(Selected_Indices_Eigen_Log);
T_mtrx_Indices_old=1:PP_Full;
Selected_Indices_Eigen_V=Selected_Indices_Eigen_Log.*T_mtrx_Indices_old;
Selected_Indices_Eigen_M=reshape(Selected_Indices_Eigen_V,[Cam_ROI_Side Cam_ROI_Side]);

clear Similarity1_sortD Similarity1_sortA Similarity2_sortD Similarity2_sortA Similarity1_sort_indicesD_cut Similarity2_sort_indicesD_cut Similarity1_sort_indicesD Similarity1_sort_indicesA Similarity2_sort_indicesD Similarity2_sort_indicesA

V_nm_Store_Eigen=V_nm_Store(:,:,Selected_Indices_Eigen_Log);
V_nm_SM_Eigen=zeros(NN,NN);
for ppp=1:Num_Real_chosen_patterns
    
    V_nm_SM_Eigen=V_nm_SM_Eigen+Start_Coeffs_Eigen(ppp)*(V_nm_Store_Eigen(:,:,ppp));
%         V_nm_SM_Eigen=V_nm_SM_Eigen+(V_nm_Store_Eigen(:,:,ppp));

end

O_Diag_Vnm=MUnwrap(V_nm_SM_Eigen,NN); %%
O_Diag_Vnm_STD=std(O_Diag_Vnm);
V_nm_SM_Eigen=V_nm_SM_Eigen/O_Diag_Vnm_STD;


% figure
% imagesc(V_nm_SM_Eigen)


%% random part

SelectedMAtrices_rand=zeros(1,PP_Full);
selectedcounts=0;
Selected_Indices_Rand_Log=zeros(1,PP_Full);
while selectedcounts<Num_Real_chosen_patterns
    tmp=randi([1 PP_Full]);
    Selected_Indices_Rand_Log(tmp)=1;
    selectedcounts=sum(Selected_Indices_Rand_Log);
end
Selected_Indices_Rand_Log=logical(Selected_Indices_Rand_Log);
Selected_Indices_Rand=T_mtrx_Indices_old.*Selected_Indices_Rand_Log;
Selected_Indices_Rand_M=reshape(Selected_Indices_Rand,[Cam_ROI_Side Cam_ROI_Side]);

V_nm_Store_rand=V_nm_Store(:,:,Selected_Indices_Rand_Log);


V_nm_SM_rand=zeros(NN,NN);
for ppp=1:Num_Real_chosen_patterns
%     Start_Coeffs_rand(ppp,1)=(randi([0 1])*2-1);
    Start_Coeffs_rand(ppp,1)=1;
    V_nm_SM_rand=V_nm_SM_rand+Start_Coeffs_rand(ppp)*(V_nm_Store_rand(:,:,ppp));
    
end


O_Diag_Vnm=MUnwrap(V_nm_SM_rand,NN); %%
O_Diag_Vnm_STD=std(O_Diag_Vnm);
V_nm_SM_rand=V_nm_SM_rand/O_Diag_Vnm_STD;



% figure
% imagesc(V_nm_SM_rand)

D_PP=Num_chosen_patterns;

%%
Savefilename=['Vnm_Matrices_Experimental_Decimated_Eigen_DPP_' num2str(Num_chosen_patterns)  '_Tdigit' num2str(ChosenPatternIndex)  '__NN_'  num2str(NN) '.mat' ]

save(Savefilename,'V_nm_SM_rand','V_nm_SM_Eigen','V_nm_Store_Eigen','V_nm_Store_rand','Start_Coeffs_Eigen','Start_Coeffs_rand','NN','D_PP','ChosenPatternIndex','Pattern_Chosen','Num_Real_chosen_patterns','Num_chosen_patterns','Decimation','Selected_Indices_Eigen_Log','Selected_Indices_Rand_Log','Selected_Indices_Eigen_M','Selected_Indices_Rand_M','-v7.3')

