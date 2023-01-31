clear all; clc;
mA=229;   %kg   Einbaumasse
mR=31;    %kg   Radmasse
cE=56115; %N/m  Einbaufederrate
cR=128000;%N/m  Reifenfederrate
dE=3195;  %Ns/m Einbaudämpfung
cy=70000; %M/m  Seitensteifigkeit
ca=20000; %N/radm Schräglaufsteifigkeit
alp=15*pi/180;%15° Einbauwinkel
r=0.3;    %m    Reifenradius
LR=0.7;   %m    Hebellänge
LE=0.42;  %m    Einbauhebellänge% 
Zh=0.15;  %m    Wegamplitude
v=10;     %m/s  Fahrgeschwindigkeit
% zwischen Lösung
cA=cE*(LE*cos(alp)/LR)^2; % Ersatzfederrat
dA=dE*(LE/LR)^2; % Ersatzdämpfungskonstant
ir=r/LR;         % 
cya=cy/ca;       % rad 
%A1 & A2:
[Am,Bm,Cm,Dm]=linmod('MS_BT_mdl_WS21');
plot(eigs(Am),'*'); grid;
Eigenwerte=eigs(Am);
Eigenfrqcplx=eigs(Am)/(2*pi);
ungedampfq=abs(Eigenfrqcplx);
gedampfq=imag(Eigenfrqcplx);
dampgrad=abs(real(Eigenfrqcplx)./ungedampfq);
% A3:Plot der Übertragungsfunktion
[Zaehler,Nenner]=ss2tf(Am,Bm,Cm,Dm,1);
fhz=0:0.1:20*2*pi; % input frequenz
figure (3)
bode(Zaehler(1,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |Fy/Zh|')
%
%A4:Herleiten Sie anhand der Systemgleichungen
% einen formelmäßigen Ausdruck in A, B, C, D Matrizen:
A=[0,    0,           1,     0,     0;
   0,    0,           0,     1,     0;
  -cA/mA,cA/mA,      -dA/mA, dA/mA, ir/mA;
   cA/mR,-(cA+cR)/mR, dA/mR,-dA/mR,-ir/mR;
   0,    0,           cy*ir,-cy*ir,-cya*v];
plot(eig(A),'*'); grid;
eigs(A);
B=[0; 0; 0; cR/mR; 0];
C=[0, 0, dA, -dA   0;
   0, 0, 0,   0,   1 ];
D=[0;0];
[Zaehler,Nenner]=ss2tf(A,B,C,D,1);
fhz=0:0.1:20*2*pi; % input frequenz
figure (2)
bode(Zaehler(2,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |Fy/Zh|')

