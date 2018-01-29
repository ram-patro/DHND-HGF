function [accuracy,FA,MD]=performance_measure_noise_detection(M,N)
M_=M(:);%vectorising the noise mask 'M'
N_=N(:);%vectorising the noise mask 'N'
TP=0;FN=0;FP=0;TN=0;%initialization 
for i=1:numel(M_)
    if(M_(i)==1 && N_(i)==1)
        TP=TP+1;
    elseif (M_(i)==1 && N_(i)==0)
        FN=FN+1;
    elseif (M_(i)==0 && N_(i)==1)
        FP=FP+1;
    else
        TN=TN+1;
    end
end
FA=FP;%False alarm is False positive
MD=FN;%Miss detection is False negative
accuracy=(TP+TN)/(TP+TN+FP+FN);
