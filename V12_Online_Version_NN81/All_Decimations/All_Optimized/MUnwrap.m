function O_Diag=MUnwrap(Mtrx,NN)

jjj=1;
for X_indx=1:NN-1
    for Y_indx=X_indx+1:NN
        O_Diag(jjj,1)=Mtrx(X_indx,Y_indx);
        jjj=jjj+1;
    end
end
