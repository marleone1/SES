clear all
close all

% load ('G_Matrices_Coeffs_Targ_470_Experimental_Random_eff_DPP100__NN_81','TV_nm_Final','NN','ChosenPatternIndex')
load ('G_Matrices_Coeffs_Targ_470_Experimental_Eigen_eff_DPP100__NN_81','TV_nm_Final','NN','ChosenPatternIndex')

% load ('G_Matrices_Coeffs_Targ_76_Experimental_Random_eff_DPP40__NN_81','TV_nm_Final','NN','ChosenPatternIndex')

% load G_Matrices_Coeffs_Targ_38_Experimental_Eigen_eff_DPP30__NN_81
%  load G_Matrices_Coeffs_Targ_41_Experimental_Eigen_eff_DPP80__NN_81
load('Patterns_NN81_5000_','Patterns')


Pattern_Chosen=Patterns(:,:,ChosenPatternIndex);



[V,D] = eig((TV_nm_Final));
Eigens = diag(D);

figure

plot(Eigens,'o')

figure
subplot(1,2,1)
imagesc(Pattern_Chosen)
title('Original Pattern $\phi$','interpreter',' latex')

Eig_1=V(:,NN);


Retrieved_pattern_1=reshape(Eig_1,sqrt(NN),sqrt(NN));
Retrieved_pattern_1=sign(Retrieved_pattern_1)
Retrieved_pattern_1_inv=-(Retrieved_pattern_1)

subplot(1,2,2)
imagesc(Retrieved_pattern_1)
title('pattern retrieved from the $J_{nm}$','interpreter',' latex')


Error_pattern=Retrieved_pattern_1.*Pattern_Chosen;
Error_pattern=(Error_pattern+1)/2;
figure
imagesc(Error_pattern)

Error=sum(sum(Error_pattern));
Error_N=Error/NN;


Error_pattern_inv=Retrieved_pattern_1_inv.*Pattern_Chosen;
Error_pattern_inv=(Error_pattern_inv+1)/2;
figure
imagesc(Error_pattern_inv)

Error_inv=sum(sum(Error_pattern_inv));
Error_N_inv=Error_inv/NN;

