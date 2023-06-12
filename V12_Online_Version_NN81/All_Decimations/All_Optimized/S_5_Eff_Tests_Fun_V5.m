% clear all
% close all
% 
% % load('Vnm_Matrices_Experimental_Tdigit501_Decimated_Eigen_PP_328__NN_81')
% load Patterns_NN81_5000_
% % load Vnm_Matrices_Experimental_Tdigit244_Decimated_Rand_PP_52__NN_81
% 
% 
% % load('G_Matrices_Coeffs_Targ_501_Experimental_Eigen_eff_PP328__NN_81')
% ChosenPatternIndex=81;
% PP=23;
% Eigen=logical(0)
% 
% if Eigen
%     str=['G_Matrices_Coeffs_Targ_' num2str(ChosenPatternIndex)  '_Experimental_Eigen_eff_PP' num2str(PP)  '__NN_81' ]
% else
%     str=['G_Matrices_Coeffs_Targ_' num2str(ChosenPatternIndex)  '_Experimental_Random_eff_PP' num2str(PP)  '__NN_81' ]
% end
% 
% StrFind = strfind(str,'Random');
% Eigen_=isempty(StrFind);
% 
% 

function [RecEff RecFailure efficiency_1diagSTD efficiency_1diagAVG  Num_chosen_patterns INT_Targ_patt INT_Tests_s_STD ChosenPatternIndex Eigen]=S_5_Eff_Tests_Fun_V5(str,ChosenPatternIndex,Patterns_V,Num_test_patt,EffTresh);
load(str)
StrFind = strfind(str,'Random');
Eigen=isempty(StrFind);

externalpattern=logical(0);

if externalpattern
    load ('External_pattern_9X9_.mat')
    Pattern_ext=Pattern_ext.*2-1;
    Patterns(:,:,2500)=Pattern_ext;
end



%% test for full matrix

% figure
% imagesc(TV_nm_Final)
% colormap hot

for ppp=1:Num_test_patt
    Pattern_Chosen=Patterns_V(:,ppp);
    Pattern_Chosen=Pattern_Chosen.';
    INT_Tests(ppp)=(Pattern_Chosen*TV_nm_Final)*Pattern_Chosen.';
%     INT_Tests_Abs(ppp)=abs(INT_Tests(ppp));
    

end
INT_Targ_patt=INT_Tests(ChosenPatternIndex);

% figure
% plot(INT_Tests)
% hold on
% plot(ChosenPatternIndex,INT_Targ_patt  ,'or')
% ylabel('Intensity')
% xlabel('Pattern Index')
% str=['efficiency exp diag  ' num2str(efficiency_1diag)]
% title(str)

% frame = getframe(gcf);
% writeVideo(v,frame);
INT_Tests_s=INT_Tests;
INT_Tests_s(ChosenPatternIndex)=[];
% INT_Tests_s_Avg=mean(INT_Tests_s);
INT_Tests_s_STD=std(INT_Tests_s);
INT_Tests_s_AVG=mean(INT_Tests_s);
efficiency_1diagSTD=INT_Targ_patt/INT_Tests_s_STD;
efficiency_1diagAVG=INT_Targ_patt/INT_Tests_s_AVG;

separation_Tresh=INT_Targ_patt*EffTresh;
RecPAtt=INT_Tests>separation_Tresh;
NumRecPAtt=sum(RecPAtt);
RecFailure=(NumRecPAtt-1)/Num_test_patt;
RecEff=1-RecFailure;

if exist('Num_chosen_patterns')==0
Num_chosen_patterns=PP
end


