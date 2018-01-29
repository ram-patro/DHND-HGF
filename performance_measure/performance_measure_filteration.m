function [psn,ssi,ie,fsi]=performance_measure_filteration(S,F,X)
psn=psnr(S,F);
ssi=ssim(S,F);
ie=IEF(S,X,F); 
fsi=FeatureSIM(S,F);   
end

function [out]=IEF(orgimg,nimg,dimg)
% IEF is Image enhancement factor.
% orgimg    = Orignal Image
% nimg      = Noisy Image
% dimg      = Denoised Image
% Size of three images must be same.
orgimg =im2double(orgimg); 
nimg   =im2double(nimg);
dimg   =im2double(dimg);
out=sum(sum((nimg-orgimg).^2))/(sum(sum((dimg-orgimg).^2)));
end
