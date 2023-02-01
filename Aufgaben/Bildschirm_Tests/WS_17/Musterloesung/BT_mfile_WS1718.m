clear; clc;
m1=30; m2=250;  %kg      
cp=0.5*1000; c1=120*1000; c2=20*1000;    %N/m 
d2=0.1*1000; dp= 0.5*1000;    %Ns/m 
zh=0.1; % m
% m1=1; m2=1;  %kg      
% cp=1; c1=1;  c2=1;    %N/m 
% d2=0; dp=1;  %Ns/m  

%A1 simulinkmodell und A4 Eigenwerte:
[A,B,C,D]=linmod('BT_Modell_WS1718');
Eigenwerte=eigs(A);
Eigenfrqcplx=eigs(A)/(2*pi);
ungedampfq=abs(Eigenfrqcplx);
gedampfq=imag(Eigenfrqcplx);
dampgrad=abs(real(Eigenfrqcplx)./ungedampfq);
%
%A3: A, B, C, D Matrizen herleiten 
A_mat= [0 0 1 0 0;
        0 0 0 1 0;
        -(c1+c2)/m1 c2/m1 -d2/m1 d2/m1 0;
        c2/m2 -c2/m2 d2/m2 -d2/m2 -cp/m2;
        0 0 0  1 -cp/dp];
[Wn,xin,pn]=damp(A_mat);
 %Wn/2/pi
 xin
 pn/2/pi
 figure(1);
 plot(real(pn),imag(pn),'r*') % Plot real and imaginary parts
 xlabel('Real'); ylabel('Imaginary'); grid;
 title('Eigenwerte der Systemmatrix A');
%
B_mat= [0; 0; c1/m1; cp/m2; cp/dp];
C_mat= [c2 -c2 0 0 0;
        0   1  0 0 -1];
D_mat= [0;0];
figure (2)
step(ss(A_mat,B_mat,C_mat,D_mat));grid;
axis([0 8 -0.5 0.5]);
% A5: Plot der Übertragungsfunktion
[Zaehler,Nenner]=ss2tf(A_mat,B_mat,C_mat,D_mat);
fhz=0:0.1:20*2*pi; % input frequenz
figure (3)
bode(Zaehler(1,:),Nenner,fhz);grid; % Bode Diagramm
% call bode
% bode(mysystem) % generates bode plot with default properties
% getroot = gcr; % Get the handle for the "plot object root"
% % which is a structure containing the plot properties
% Set frequency axis to Hz
% getroot.AxesGrid.Xunits = 'Hz';
%  Set mag axis to abs & phase axis to deg
% getroot.AxesGrid.Yunits = {'abs','deg'};
%  Turn on the grid
% grid on; % or getroot.AxesGrid.Grid = "on"
