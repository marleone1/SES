# SES
Data and Software for Stochastic Emergent Storage

By Marco Leonetti Ph.D., realized on June 12 2023
Soft and Living Matter Laboratory, Institute of Nanotechnology Consiglio Nazionale delle Ricerche, 00185 Rome, Italy

Readme File for data and software for the Stocastic Emergent Learning .

The software enable to extract the Transmission matrices V_nm
Decimate them by similarity with a given target pattern \phi^*
Store an arbitrary memory pattern \phi^*
Retrieve the average storege efficiency
Obtain simulated Classification efficiency

All these features are obtained with matlab written routines

Data from experimentally measured (example ) intensity values are in the file: 

M_Jij=1904-1326_CamFrameSD_256_Nspins_81_Binning_1.mat

Containign the measured intensities for 
NN=81 (N elements in the pattern)
PP=65536 (M^L measured optical modes)


1)
Transmission matrices are found by the routine:
S_5_Transm_Matrix_extractor_V4.m
employng the equation

V^\nu_{nm}=(I_{nm}^\nu -I_{n}^\nu -I_{m}^\nu )/2

2)
V_nm Decimation  for Stocastic Emergent Learning  is performed by routine: 
S_7_Decimator_Launcher_V2.m
This software decimates the modes repoitory in order to introduce the pattern
\phi^* indicated by the index "ChosenPatternIndex" and extracted from teh patterns repository 
Patterns_NN81_500_.mat
or 
Patterns_NN81_5000_.mat
containing respectively 500 and 5000 digits pattern with random rotation 
Digits are extracted by the matlab repository
https://it.mathworks.com/help/deeplearning/ug/data-sets-for-deep-learning.html

3) 
 \mathbf{\lambda} parameters are retrived 
S_3_TM_Engineer_Simil_Launcher_par.m  (in the \All_Decimations directory)
minimizing function \mathcal{F}({\bm{\mathcal{M}}},\bm\lambda) with a monte routine 

4) 
Data analysis: Pattern storage error is quantified by routine:
Pattern_Retrival_Err_Probability_Launcher.m

5) 
Data analysis: classification efficiency (simulated) is retreived by routine:
Classification_Probability_Launcher




