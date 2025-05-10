clear all
close all
% set the transition probabilities of the Markov chain
p11=0.2; p22=0.2;
P=[p11 1-p11; 1-p22 p22];
% create the Markov chain model
mc = dtmc(P,'StateNames',{'S1','S2'});

% plot the transition graph
figure;
graphplot(mc,'ColorEdges',true);
title('Markov chain state diagram')
% make the plot nicer
makeItNicer

% generate the samples of the Markov chain
N=1000;
x = simulate(mc,N);
% plot the samples of the Markov chain
figure;
stem(x-1)
title('Outcome of a Markov chain')
ylabel('$x[n]$')
xlabel('$n$')
% make the plot nicer
makeItNicer

% center the samples of the Markov chain
x0=x-mean(x);
% estimate the correlation
% notice that in order to use the biased correlation the process needs to
% be centered! 
Rx=xcorr(x0,'biased');
% plot the correlation
figure;
stem(-N:N,Rx)
title('Correlation of a Markov chain')
ylabel('$R_x[k]$')
xlabel('$k$')
% make the plot nicer
makeItNicer

figure;
stem(-100:100,Rx(((N+1)-100):((N+1)+100)))
title('Correlation of a Markov chain (zoom)')
ylabel('$R_x[k]$')
xlabel('$k$')
% make the plot nicer
makeItNicer

% function to change the properties of the figure to to make the plot look
% nicer
function makeItNicer
    axisProperties=gca; % get the pointer to the axis properties 
    axisProperties.FontSize=18; % set the font size 
    axisProperties.Title.Interpreter='latex'; % set the text interpreter 
    axisProperties.YLabel.Interpreter='latex'; 
    axisProperties.XLabel.Interpreter='latex';
end
