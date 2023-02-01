close all; clear all;clc;

Jm = 0.125e-5;
dM= 1.0e-5;
rM=25/1000;
RM=1.5;
LM=1e-3;
OM= 0.1125;
Oi= 2.6e-2;
JL= 2e-5;
c=50;
d=0.05;
dL=5e-6;
rL=50.0/1000;
ML=0.25;
Uq0=24;

% Open Model
Nils_Modell

[Am,Bm,Cm,Dm]=linmod('Nils_Modell');


%eigs(Am)/2/pi 
 Eigenwerte = eigs(Am); 
 Eigenfrqcplx=eigs(Am)/(2*pi); % in Hz 
 ungedampfq=abs(Eigenfrqcplx);
 gedampfq=imag(Eigenfrqcplx); 
 dampgrad=abs(real(Eigenfrqcplx)./ungedampfq); 
% Das System ist stabil, weil sich alle Eigenwerte in der linken s-Halbebene befinden. 

% A5 
AE=[-dM/Jm 0 -rM/Jm OM/Jm; 
 0 -dL/JL rL/JL 0; 
 c*rM -c*rL -d*(rM^2/Jm+rL^2/JL) d*OM*rM/Jm; 
 -Oi/LM 0 0 -RM/LM]; 
BE=[0 0; 
 -1/JL 0; 
 -d*rL/JL 0; 
 0 1/LM]; 
CE=[1 -1 0 0; 
 0 0 1 0; 
 0 0 0 OM]; 
DE=[0 0; 0 0; 0 0]; 
plot(eigs(AE),'*'); grid; 

% A5: Plot der Übertragungsfunktion 
[Zaehler,Nenner]=ss2tf(AE,BE,CE,DE,2); 
fhz=0:0.1:400*2*pi; % input frequenz 
figure(2) 
bode(Zaehler(3,:),Nenner,fhz);grid; % Bode Diagramm 
title('Übertragungsfunktion |MA/Uq|');