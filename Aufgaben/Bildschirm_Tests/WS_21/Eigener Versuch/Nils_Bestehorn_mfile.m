clc; clear all;
% Werte imput
mA = 229; %[kg]
mR = 31;
cE=56115;
cR=128000;
dE=3195;
cy=70000;
calp=20000;
alpha=15*pi/180; %[°]
r=300*10^(-3); %[m]
lR=0.7; %[m]
lE=0.42; %[m]
Zh=0.15;    %[m]
v=10;   %[m/s]

% Werte Bremsschwelle
H=0.15; %[m]
L=0.6;  %[m]
V=7.5;  %[m/s]
delta_t=0.02; %[sec]

% Tipp für die A4 hier Rechnungen zusammenfassen und in der Simulation
% abkürzen, mach es übersichtlicher und leichter für die A4
%Siehe A4 Zwischenlösungen!!!

% A1_Model
Nils_Bestehorn_mdl;
[Am,Bm,Cm,Dm]=linmod('Nils_Bestehorn_mdl');

%% A2_Eigenwerte
figure ('Name','A2_Eigenwerte')
plot(eigs(Am),'*'); grid; 
Eigenwerte=eigs(Am); 
Eigenfrqcplx=eigs(Am)/(2*pi); 
ungedampfq=abs(Eigenfrqcplx); 
gedampfq=imag(Eigenfrqcplx); 
dampgrad=abs(real(Eigenfrqcplx)./ungedampfq);

%% A3_Plotten der Übertragungsfunktion 
[Zaehler,Nenner]=ss2tf(Am,Bm,Cm,Dm,1);
fhz=0:0.1:20*2*pi; % input frequenz
figure ('Name',"A3_Uebertagungsfunktion Bode")
bode(Zaehler(1,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |Fy/Zh|')

%% A4:Herleiten Sie anhand der Systemgleichungen
% zwischen Lösung
cA=cE*(lE*cos(alpha)/lR)^2; % Ersatzfederrat
dA=dE*(lE/lR)^2; % Ersatzdämpfungskonstant
ir=r/lR;         % 
cya=cy/calp;       % rad

%richtige A4
A=[0,    0,           1,     0,     0;
   0,    0,           0,     1,     0;
  -cA/mA,cA/mA,      -dA/mA, dA/mA, ir/mA;
   cA/mR,-(cA+cR)/mR, dA/mR,-dA/mR,-ir/mR;
   0,    0,           cy*ir,-cy*ir,-cya*v];

figure('Name','A4_Eigenwerte')
plot(eig(A),'*'); grid;
eigs(A);

B=[0; 0; 0; cR/mR; 0];
C=[0, 0, dA, -dA   0;
   0, 0, 0,   0,   1 ];
D=[0;0];

[Zaehler,Nenner]=ss2tf(A,B,C,D,1); %Äquivalten zu State Space Block
fhz=0:0.1:20*2*pi; % input frequenz
figure ('Name',"A4_Uebertagungsfunktion Bode")
bode(Zaehler(2,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |Fy/Zh|')