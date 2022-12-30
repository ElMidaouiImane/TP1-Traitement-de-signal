clear all
close all
clc
fe = 1e4;
te = 1/fe;
N = 10000; 
%% ---1---
t = (0:N-1)*te; 
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
plot(t,x);
title('le signal');
%% ---2---
 f =(0:N-1)*(fe/N); 
 y = fft(x); 
 plot(f,abs(y));
 title('le spectre Amplitude avec fft');
%% ---3---
fshift = (-N/2:N/2-1)*(fe/N)
plot(fshift,fftshift(2*abs(y)/N));
title('le spectre Amplitude centré avec fftshift');
%% ---4---
% bruit=5*randn(size(x)) % bruit avec petite amplitude
bruit = 20*randn(size(x));%bruit
xnoise = x+bruit; % signal+bruit
plot(xnoise);
title('le signal bruité');

%% ---5---
sound(x)
sound(xnoise)
%% ---6---
ybruit = fft(xnoise); % le spectre de signal+bruit
plot(fshift,fftshift(abs(ybruit)));
title('le spectre Amplitude de signal+bruit centré');
%% ---7---
bruit = 50*randn(size(x));%bruit
xnoise = x+bruit; % signal+bruit
ybruit = fft(xnoise); % le spectre de signal+bruit
plot(fshift,fftshift(abs(ybruit)));
title('le spectre Amplitude de signal+bruit centré');