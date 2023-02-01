clc; clear;
% Setup Achtung immer lieber *e-3 benutzen!!!
JM  =  0.125*exp(-5); %
dM  =   1.0*exp(-5); 
rM  =   25*10^(-3);
RM  =   1.5;
LM  =   1.0*exp(-3);

PHIi=2.6e-2;
PHIM=0.1125;
OL = 2.6*exp(-2);
OL=PHIi;
OM = 0.1125;

JL  =   2*exp(-5);
c   =   50;
d   =   0.05;
dL  =   5*exp(-6);
rL  =   50*10^(-3);
ML  =   0.25;
Uq  =   24;

Nils_Bestehorn_WS19_modell %Achtung Modell geht leider nicht richtig!!! irgenwo die Verbindung falsch
% A2 
%% Problem im Modell!!!
[Am,Bm,Cm,Dm]=linmod('Nils_Bestehorn_WS19_modell');


%eigs(Am)/2/pi 
 Eigenwerte = eigs(Am); 
 Eigenfrqcplx=eigs(Am)/(2*pi); % in Hz 
 ungedampfq=abs(Eigenfrqcplx) 
 gedampfq=imag(Eigenfrqcplx); 
 dampgrad=abs(real(Eigenfrqcplx)./ungedampfq); 
% Das System ist stabil, weil sich alle Eigenwerte in der linken s-Halbebene befinden. 

% A5 
AE=[-dM/JM 0 -rM/JM PHIM/JM; 
 0 -dL/JL rL/JL 0; 
 c*rM -c*rL -d*(rM^2/JM+rL^2/JL) d*PHIM*rM/JM; 
 -PHIi/LM 0 0 -RM/LM]; 
BE=[0 0; 
 -1/JL 0; 
 -d*rL/JL 0; 
 0 1/LM]; 
CE=[1 -1 0 0; 
 0 0 1 0; 
 0 0 0 PHIM]; DE=[0 0; 0 0; 0 0]; 
plot(eigs(AE),'*'); grid; 

% A5: Plot der Übertragungsfunktion 
[Zaehler,Nenner]=ss2tf(AE,BE,CE,DE,2); 
fhz=0:0.1:400*2*pi; % input frequenz 
figure(2) 
bode(Zaehler(3,:),Nenner,fhz);grid; % Bode Diagramm 
title('Übertragungsfunktion |MA/Uq|');