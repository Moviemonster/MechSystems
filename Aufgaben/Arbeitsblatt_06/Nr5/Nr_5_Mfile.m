clear; clc;
%%
H=0.1;
L=0.5;
V=10;

mR= 31;
cA=20.2*1000;
cR=128*1000;
dA=1*1000;

%% ungedaempfte Eigenfrequenz
omegaR=sqrt((cA+cR)/mR);
fR=omegaR/(2*pi); %%pro sec
xiR=dA/(2*mR*omegaR);

%% gedaempfte Eigenfrequenz
omegaRd=omegaR*sqrt(1-xiR^2);
fRd=omegaRd/(2*pi);

%% Matrizen
omegaRR=sqrt(cR/mR);
A=[0 1;-omegaR^2 -2*xiR*omegaR];
B=[0;omegaRR^2];
C=[1 0;0 1;-omegaR^2 -2*xiR*omegaR];
D=[0; 0;omegaRR^2];

%%
C1=[1 0];
C2=[0 1];
C3=[-omegaR^2 -2*xiR*omegaR];
D1=[0];
D2=[0];
D3=[omegaRR^2];
