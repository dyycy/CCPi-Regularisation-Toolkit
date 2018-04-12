% Image (2D) denoising demo using CCPi-RGL
clear
close all
addpath('../mex_compile/installed');
addpath('../../../data/');

Im = double(imread('lena_gray_512.tif'))/255;  % loading image
u0 = Im + .05*randn(size(Im)); u0(u0 < 0) = 0;
figure; imshow(u0, [0 1]); title('Noisy image');

%%
fprintf('Denoise using the ROF-TV model (CPU) \n');
lambda_rof = 0.03; % regularisation parameter
tau_rof = 0.0025; % time-marching constant 
iter_rof = 2000; % number of ROF iterations
tic; u_rof = ROF_TV(single(u0), lambda_rof, iter_rof, tau_rof); toc; 
figure; imshow(u_rof, [0 1]); title('ROF-TV denoised image (CPU)');
%%
% fprintf('Denoise using the ROF-TV model (GPU) \n');
% lambda_rof = 0.03; % regularisation parameter
% tau_rof = 0.0025; % time-marching constant 
% iter_rof = 2000; % number of ROF iterations
% tic; u_rofG = ROF_TV_GPU(single(u0), lambda_rof, iter_rof, tau_rof); toc;
% figure; imshow(u_rofG, [0 1]); title('ROF-TV denoised image (GPU)');
%%
fprintf('Denoise using the FGP-TV model (CPU) \n');
lambda_fgp = 0.03; % regularisation parameter
iter_fgp = 1000; % number of FGP iterations
epsil_tol =  1.0e-06; % tolerance
tic; u_fgp = FGP_TV(single(u0), lambda_fgp, iter_fgp, epsil_tol); toc; 
figure; imshow(u_fgp, [0 1]); title('FGP-TV denoised image (CPU)');
%%
% fprintf('Denoise using the FGP-TV model (GPU) \n');
% lambda_fgp = 0.03; % regularisation parameter
% iter_fgp = 1000; % number of FGP iterations
% epsil_tol =  1.0e-05; % tolerance
% tic; u_fgpG = FGP_TV_GPU(single(u0), lambda_fgp, iter_fgp, epsil_tol); toc; 
% figure; imshow(u_fgpG, [0 1]); title('FGP-TV denoised image (GPU)');
%%
fprintf('Denoise using the FGP-dTV model (CPU) \n');
% create another image (reference) with slightly less amount of noise
u_ref = Im + .01*randn(size(Im)); u_ref(u_ref < 0) = 0;
% u_ref = zeros(size(Im),'single'); % pass zero reference (dTV -> TV)

lambda_fgp = 0.03; % regularisation parameter
iter_fgp = 1000; % number of FGP iterations
epsil_tol =  1.0e-06; % tolerance
eta =  0.2; % Reference image gradient smoothing constant
tic; u_fgp_dtv = FGP_dTV(single(u0), single(u_ref), lambda_fgp, iter_fgp, epsil_tol, eta); toc; 
figure; imshow(u_fgp_dtv, [0 1]); title('FGP-dTV denoised image (CPU)');
%%
% fprintf('Denoise using the FGP-dTV model (GPU) \n');
% % create another image (reference) with slightly less amount of noise
% u_ref = Im + .01*randn(size(Im)); u_ref(u_ref < 0) = 0;
% % u_ref = zeros(size(Im),'single'); % pass zero reference (dTV -> TV)
% 
% lambda_fgp = 0.03; % regularisation parameter
% iter_fgp = 1000; % number of FGP iterations
% epsil_tol =  1.0e-06; % tolerance
% eta =  0.2; % Reference image gradient smoothing constant
% tic; u_fgp_dtvG = FGP_dTV_GPU(single(u0), single(u_ref), lambda_fgp, iter_fgp, epsil_tol, eta); toc; 
% figure; imshow(u_fgp_dtvG, [0 1]); title('FGP-dTV denoised image (GPU)');
%%