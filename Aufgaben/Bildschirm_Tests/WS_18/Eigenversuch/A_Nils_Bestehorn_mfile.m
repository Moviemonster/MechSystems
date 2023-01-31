close all;clear all;clc;

% Werte
m1= 30;
m2 = 250;
c1=120*(1/10^-3);
c2=20*(1/10^-3);
cP=0.5*(1/10^-3);
d2=0.25*(1/10^-3);
dP=0.5*(1/10^-3);
zh=10*10^-2;

% Open Modell
A_Nils_Bestehorn_modell

% A1 Modell Data
[Am,Bm,Cm,Dm]=linmod('A_Nils_Bestehorn_modell');

%% A3_Eigenwerte
figure ('Name','A3_Eigenwerte')
plot(eigs(Am),'*'); grid; 
Eigenwerte=eigs(Am); 
Eigenfrqcplx=eigs(Am)/(2*pi); 
ungedampfq=abs(Eigenfrqcplx); 
gedampfq=imag(Eigenfrqcplx); 
dampgrad=abs(real(Eigenfrqcplx)./ungedampfq);

%% A2_Matrize A B C D
A=[ 0,0,1,0,0;
    0,0,0,1,0;
    -(c1+c2)/m1,c2/m1,-d2/m1,d2/m1,-cP/m1;
    c2/m2,-c2/m2,d2/m2,-d2/m2,0;
    0,0,1,0,-cP/dP];

B=[ 0; 0; (c1+cP)/m1; 0; cP/dP];

C=[ c2,-c2,0,0,0;
    1,0,0,0,-1];

D=[ 0;0];

%% A4_Plotten_Uebertragungsfunktion durch A2
[Zaehler,Nenner]=ss2tf(A,B,C,D,1); %Äquivalten zu State Space Block
fhz=0:0.1:20*2*pi; % input frequenz
figure ('Name',"A4_Uebertagungsfunktion Bode durch A2")
bode(Zaehler(2,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |F2/Zh|')

%% A4_Alternative_ mit_A3
[Zaehler,Nenner]=ss2tf(Am,Bm,Cm,Dm,1); %Äquivalten zu State Space Block
fhz=0:0.1:20*2*pi; % input frequenz
figure ('Name',"A4_Uebertagungsfunktion Bode durch A3")
bode(Zaehler(2,:),Nenner,fhz);grid; % Bode Diagramm
title('Übertragungsfunktion |F2/Zh|')