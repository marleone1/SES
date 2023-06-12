function Savefilename=S_3_TM_Engineer_Eb_par(Random_basis, NN, Num_Patterns, Patterns,Patterns_V,fff,Opt_Bits,FFFi,DIR)

% load Vnm_Matrices_Experimental_Tdigit134_Decimated_Eigen_DPP_16__NN_81  
% % load Vnm_Matrices_Experimental_Tdigit77_Decimated_Eigen_DPP_200__NN_81
% Random_basis=logical(0);
% load Patterns_NN81_500_


filename=DIR(fff).name
load(filename);


Opt_Values_Num=2^Opt_Bits;
Opt_Values_V=linspace(0,1,Opt_Values_Num);
PP=Num_Real_chosen_patterns;


if Random_basis 
    clear V_nm_SM  Start_Coeffs V_nm_Store
    
    V_nm_Store= V_nm_Store_rand;
%     Coeffs=Start_Coeffs_rand;
else
    V_nm_Store= V_nm_Store_Eigen;
%     Coeffs=Start_Coeffs_Eigen;
end


Coeffs=ones(PP,1);
Coeffs=Coeffs*0.5;


clear V_nm_SM
V_nm_SM=zeros(NN,NN);

for ppp=1:PP
    
    V_nm_SM=V_nm_SM+Coeffs(ppp)*(V_nm_Store(:,:,ppp));
    
end


[Fidelity INT_Tests]=FidelityFunI(ChosenPatternIndex,Patterns_V,Num_Patterns,V_nm_SM)
[V,D] = eig(V_nm_SM);
V1=V(:,NN);
Similarity=sum(Pattern_Chosen.*V1)/NN;


% if Fidelity<0
%     clear Coeffs
%     if Random_basis 
%         Coeffs=-Start_Coeffs_rand;
%     else
%         Coeffs=-Start_Coeffs_Eigen;
%     end
% end

clear V_nm_SM
V_nm_SM=zeros(NN,NN);

for ppp=1:PP
    
    V_nm_SM=V_nm_SM+Coeffs(ppp)*(V_nm_Store(:,:,ppp));
    
end

% figure
% imagesc(V_nm_SM)
% colormap hot
[V,D] = eig(V_nm_SM);
V1=V(:,NN);
Similarity=sum(Pattern_Chosen.*V1)/NN;





MC_Step_size_indx=1;
V_nm=V_nm_SM;
tt=2;
tt_ds=1;
Shown_Frames=1000;

while  MC_Step_size_indx<4;
    
%     Sign=randi([0 1])*2-1;
        %modify TV_nm
    TMP_Coeff1=Opt_Values_V(randi([1 Opt_Values_Num]));
    
    Mod_ind=randi([1 PP]); 
    
    V_nm_TMP=V_nm+(TMP_Coeff1-Coeffs(Mod_ind))*V_nm_Store(:,:,Mod_ind);
    

    [V,D] = eig(V_nm_TMP);
    V1=V(:,NN);
    Similarity(tt)=sum(Pattern_Chosen.*V1)/NN;
    
    if Similarity(tt)>Similarity(tt-1)
        Coeffs(Mod_ind)=TMP_Coeff1;
        V_nm=V_nm_TMP;
    else
        Similarity(tt)=Similarity(tt-1);
    end
    
    if mod(tt,Shown_Frames)==0
        [Fidelity INT_Tests]=FidelityFunI(ChosenPatternIndex,Patterns_V,Num_Patterns,V_nm);

        
%         plot(Similarity)
%         str=['Similarity   ' num2str(MC_Step_size_indx)];
%         title(str)
%         subplot(1,3,2)
%         imagesc(V_nm)
%         str=['Random_basis: ' num2str(Random_basis) '  Pattern: ' num2str(ChosenPatternIndex) '  N_basis M*: ' num2str(PP) ]
%         title(str)
%         colormap hot
%         subplot(1,3,3)
%         plot(INT_Tests)
%         hold on
%         plot(ChosenPatternIndex,INT_Tests(ChosenPatternIndex),'ro')
%         title('target INT_targ')
%         hold off
%         drawnow

        
        
        if numel(Similarity)>Shown_Frames
              if (Similarity(tt)-Similarity(tt-Shown_Frames))/Similarity(tt)<0.000001
                


                  
                  
                MC_Step_size_indx=MC_Step_size_indx+1;
            end
        end
    end
        
        tt=tt+1;
        if tt>20000
            break
        end
        
end

%%
% figure(FFFi)
% subplot(1,3,1)
% plot(Similarity)
% str=['Similarity   ' num2str(MC_Step_size_indx)];
% title(str)
% subplot(1,3,2)
% imagesc(V_nm)
% str=['Random_basis: ' num2str(Random_basis) '  Pattern: ' num2str(ChosenPatternIndex) '  N_basis M*: ' num2str(PP) ]
% title(str)
% colormap hot
% subplot(1,3,3)
% plot(INT_Tests)
% hold on
% plot(ChosenPatternIndex,INT_Tests(ChosenPatternIndex),'ro')
% title('target INT_targ')
% hold off
% drawnow

%%
TV_nm_Final=zeros(NN,NN);
for PPindx=1:PP
    
    TV_nm_Final=TV_nm_Final+Coeffs(PPindx)*V_nm_Store(:,:,PPindx);
    
    
end


% figure
% imagesc(TV_nm_Final)
% colormap hot
%%
[V,D] = eig(V_nm_TMP);
V1=V(:,NN);
Final_Similarity=sum(Pattern_Chosen.*V1)/NN
Final_Norm_Similarity=sum(Pattern_Chosen.*sign(V1))/NN


Savefilename=['G_Matrices_Coeffs_Targ_' num2str(ChosenPatternIndex)  '_Experimental_Eigen_eff_DPP' num2str(Num_chosen_patterns) '__NN_'  num2str(NN) '_BITS_'  num2str(Opt_Bits) '.mat' ]

if Random_basis
    Savefilename=['G_Matrices_Coeffs_Targ_' num2str(ChosenPatternIndex)  '_Experimental_Random_eff_DPP' num2str(Num_chosen_patterns) '__NN_'  num2str(NN) '_BITS_'  num2str(Opt_Bits) '.mat' ]
end

save(Savefilename,'TV_nm_Final','NN','PP','Coeffs','Similarity','Decimation','ChosenPatternIndex','Num_chosen_patterns','Final_Similarity','Final_Norm_Similarity');




