function Fidelity =FidelityFun(ChosenPatternIndex,Patterns_V,Num_Patterns,V_nm)
% clear all
% close all
% 
% 
% 
% load('Jij_Matrix_optInt_NN36__Pattern_30_V3','Patterns_V','ChosenPatternIndex','Num_Patterns');
% 
% load('G_Matrices_Coeffs_Experimental_PP376__NN_36','TV_nm_Final'); 
% V_nm=TV_nm_Final;


for ppp=1:Num_Patterns
   Pattern= Patterns_V(:,ppp);
   INT_Tests(ppp)=(Pattern.'*V_nm)*Pattern; 
end

INT_targ=INT_Tests(ChosenPatternIndex);
INT_Tests_s=INT_Tests;
INT_Tests_s(ChosenPatternIndex)=[];
INT_rand_AVG=mean(INT_Tests_s);

Fidelity=INT_targ/INT_rand_AVG;