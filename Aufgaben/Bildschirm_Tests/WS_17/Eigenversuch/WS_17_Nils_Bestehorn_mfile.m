close all; clear all; clc;

% Werte
m1=30;
m2=250;
c1=120*(1/10^-3);
c2=20*(1/10^-3);
cp=0.5*(1/10^-3);
d2=0.5*(1/10^-3);
dp=0.1*(1/10^-3);
zh=10*10^-2;

% Open Modell
WS_17_Nils_Bestehorn_modell

% Data from Modell
[Am,Bm,Cm,Dm]=linmod('WS_17_Nils_Bestehorn_modell');

%% A_3 Eigenwerte
figure ('Name','A3_Eigenwerte')
plot(eigs(Am),'*'); grid; 
Eigenwerte=eigs(Am); 
Eigenfrqcplx=eigs(Am)/(2*pi); 
ungedampfq=abs(Eigenfrqcplx); 
gedampfq=imag(Eigenfrqcplx); 
dampgrad=abs(real(Eigenfrqcplx)./ungedampfq);

%% A_4 Bodediagramm
[Zaehler,Nenner]=ss2tf(Am,Bm,Cm,Dm,1); %Äquivalten zu State Space Block
fhz=0:0.1:20*2*pi; % input frequenz
figure ('Name',"A4_Uebertagungsfunktion Bode")
bode(Zaehler(1,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |Ff/Zh|')


%% A_2 Matrix
A= [0 0 1 0 0;
    0 0 0 1 0;
    -(c1+c2)/m1 c2/m1 -d2/m1 d2/m1 0;
    c2/m2 -c2/m2 d2/m2 -d2/m2 -cp/m2;
    0 0 0  1 -cp/dp];

B= [0; 0; c1/m1; cp/m2; cp/dp];

C= [c2 -c2 0 0 0;
    0   1  0 0 -1];

D= [0;0];

% Open Model for Matrix
WS_17_Nils_Bestehorn_modell_ABCD