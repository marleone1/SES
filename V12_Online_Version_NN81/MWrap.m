function Mtrx=MWrap(O_Diag,NN)

jjj=1;
for X_indx=1:NN-1
    for Y_indx=X_indx+1:NN
        Mtrx(X_indx,Y_indx)=O_Diag(jjj,1);
        Mtrx(Y_indx,X_indx)=O_Diag(jjj,1);
        jjj=jjj+1;
    end
end

