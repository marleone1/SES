clear all
close all

DIR=dir;
load Patterns_NN81_500_
Opt_Bits=4;
FFFi=figure
set(gcf,'position',[ 9         196        1826         380],'color','w');
Random_basis=logical(1);


parfor fff=11:numel(DIR)

%         Savefilename=S_3_TM_Engineer_E(Random_basis, NN, Num_Patterns, Patterns,Patterns_V,filename)
%         Savefilename=S_3_TM_Engineer_Eb(Random_basis, NN, Num_Patterns, Patterns,Patterns_V,filename,Opt_Bits,FFFi)     
        Savefilename{fff}=S_3_TM_Engineer_Eb_par(Random_basis, NN, Num_Patterns, Patterns,Patterns_V,fff,Opt_Bits,FFFi,DIR)     
%         Savefilename=S_3_TM_Engineer_Fid_b(Random_basis, NN, Num_Patterns, Patterns,Patterns_V,filename,Opt_Bits,FFFi)      

        
        savestr=[ './All_Optimized/' Savefilename{fff}]
        movefile (Savefilename{fff},savestr)

end



