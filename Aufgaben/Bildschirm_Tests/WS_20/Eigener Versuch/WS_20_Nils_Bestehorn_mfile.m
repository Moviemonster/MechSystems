close all; clear all; clc;

% Werte
Jm=0.5;
JTm=5;
m=40;
r=250*10^-3;
iG=10;
c=5000; %[Nm/rad]
d=4; %[Nm/rad]
%d=2;
g=9.81;
LM=0.1;
RM=1;
phiM=0.9;
phii=2;
Uqmax=240;

% Momente Rechnung
ML=m*g*r;

% Open Modell
WS_20_Nils_Bestehorn_modell
% Get Modell Data
[Am,Bm,Cm,Dm]=linmod('WS_20_Nils_Bestehorn_modell');
%%
% A2_Eigenwerte
figure ('Name','A2_Eigenwerte')
plot(eigs(Am),'*'); grid; 
Eigenwerte=eigs(Am); 
Eigenfrqcplx=eigs(Am)/(2*pi); 
ungedampfq=abs(Eigenfrqcplx); 
gedampfq=imag(Eigenfrqcplx); 
dampgrad=abs(real(Eigenfrqcplx)./ungedampfq);


%% A3_Bodediagramm
[Zaehler,Nenner]=ss2tf(Am,Bm,Cm,Dm,1); %Äquivalten zu State Space Block
fhz=0:0.1:10*2*pi; % input frequenz
figure ('Name',"A3_Uebertagungsfunktion Bode")
bode(Zaehler(2,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |MA/Uq|')

%% A4_Matrix
A=[0, 0, 1, 0, 0; 
    0, 0, 0, 1, 0; 
    -c/(Jm*iG^2), c/(Jm*iG), -d/Jm, 0, phiM/Jm; 
    c/(iG*JTm), -c/JTm, 0, 0, 0; 
    0, 0, -phii/LM, 0, -RM/LM];
figure ('Name',"A4_Eigenwerte")
plot(eig(A),'*'); grid; 

B=[ 0, 0; 
    0, 0; 
    0, 0; 
    -m*r/JTm, 0; 
    0, 1/LM];

C=[0, 0, 1, -1 0; 
    0, 0, 0, 0 phiM]; 

D=[0,0;0,0];

%% A3_Bodediagramm mit A4
[Zaehler,Nenner]=ss2tf(A,B,C,D,1); %Äquivalten zu State Space Block
fhz=0:0.1:10*2*pi; % input frequenz
figure ('Name',"A3_Uebertagungsfunktion Bode durch A4")
bode(Zaehler(2,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |MA/Uq|')