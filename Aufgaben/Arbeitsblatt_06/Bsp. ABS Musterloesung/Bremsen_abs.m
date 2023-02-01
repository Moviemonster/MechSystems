clc; clear;
v0=100/3.6; %Anfangsgeschwindigkeit [m/s]
JR=0.8;%Massenträgheitsmoment Rad [kg/m^2] 
rR=0.3; %Reifenradius [m]
cw=0.3; %Luftwiderstandsbeiwert[-]
A=2; %Stirnfläche [m^2]
rho=1.2; %Luftdichte [kg/m^3]
m=1500; %Fahrzeugmasse [kg]
g=9.81; %Erdbeschleunigung [m/s^2]
% c1=0.86;%Reibbeiwertberechnung [-]
% c2=33.82; %Reibbeiwertberechnung [-]
% c3=0.36;%Reibbeiwertberechnung [-]
% ?x=c1*(1-exp(-c2*u))-c3*u
%Koeffizienten für Paceijka_Magic_Formula1 1
%µx=mfD*sin(mfC*atan(mfB*u-mfE*(mfB*u-atan(mfB*u))))
mfB=5; mfC=2.3; mfD=1.05; mfE=1.04;% Asphalt trocken
lab=0.22 % µx_max bei lambda=0.22
% Asphalt nass
%mfB=5; mfC=2.2; mfD=0.87; mfE=0.98;
%lab=0.22 % µx_max bei lambda=0.22

