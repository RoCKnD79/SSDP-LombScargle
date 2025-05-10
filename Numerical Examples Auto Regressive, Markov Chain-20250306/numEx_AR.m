close all
clear all
%
% Created an AR model x[n]=0.7x[n-1]+0.25x[n-3]+W[n]
% where W[n] is a centered whote noise with variance .1
%
% Feel free to change the order and rhe value of the coefficients 
%
% Try to create and AR process corresponding to an instable filter P(z) ..
% what do you expect to get?
%

% set the roots (zeros) of P(z), i.e.,
% P(z)=(1-z1*z^(-1)) .. (1-zM*z^(-1))
% Order 2 -> 2 roots
 rootsAR=0.5*[exp(i*pi/4) exp(-i*pi/4)];
% compute the coefficients of P(z), i.e.,
% P(z)=1+a1*z^(-1)+..+aMz^(-M)
 a=poly(rootsAR);
 
% a=[1 .5];
% generate the AR model. Since a(1)=1, get rid of it a=a(2:end);
model = arima('Constant',0,'AR',a(2:end),'Variance',.1);

% generate the AR samnples
N=10000;
x=simulate(model,N);

% estimated order of the model
K=10;
%
[a_est,a_error,a_refCoef]=aryule(x,K); 



return

w=randn(1,N);
Rw=xcorr(w,'biased');

% plot the samples of the AR process
figure
plot(x)
title('AR process')
ylabel('$x[n]$')
xlabel('$n$')
% make the plot nicer
makeItNicer

figure
plot(w)
title('White Noise')
ylabel('$w[n]$')
xlabel('$n$')
% make the plot nicer
makeItNicer
% compute the empirical mean and center the AR process

mx=mean(x);
x0=x-mx;

% Ccmpute the biased correlation of the centered process
Rx=xcorr(x0,'biased');

% plot the correlation
figure; 
stem(-(N-1):(N-1),Rx)
title('Correlation AR process')
ylabel('$R_x[k]$')
xlabel('$k$')
% make the plot nicer
makeItNicer

% plot the correlation
zoomN=50;
figure; 
stem(-zoomN:zoomN,Rx(((N+1)-zoomN):((N+1)+zoomN)))
title('Correlation AR process (zoom)')
ylabel('$R_x[k]$')
xlabel('$k$')
% make the plot nicer
makeItNicer

figure; 
stem(-(N-1):(N-1),Rw)
title('Correlation White Noise')
ylabel('$R_w[k]$')
xlabel('$k$')
% make the plot nicer
makeItNicer

figure; 
stem(-zoomN:zoomN,Rw(((N+1)-zoomN):((N+1)+zoomN)))
title('Correlation White Noise (zoom)')
ylabel('$R_w[k]$')
xlabel('$k$')
% make the plot nicer
makeItNicer


function makeItNicer
    axisProperties=gca; % get the pointer to the axis properties 
    axisProperties.FontSize=18; % set the font size 
    axisProperties.Title.Interpreter='latex'; % set the text interpreter 
    axisProperties.YLabel.Interpreter='latex'; 
    axisProperties.XLabel.Interpreter='latex';
end