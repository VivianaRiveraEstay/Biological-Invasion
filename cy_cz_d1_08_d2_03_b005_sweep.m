clc 
close all
clear all
tic;
%% Parametros
format long
r0=1.2;
s0=0.2;
K=100;
n=10;
c=5;
d1=0.8;
d2=0.1;
b=0.01;
theta1=3;
theta2=3;
theta3=3;
theta4=3;
p=0.1;
q0=0.05;
e=0.001;
cx=0.2;
%cy=1;
%cz=1;
G1=0.01;
G2=0.01;
G3=0.01;

cy_end=2;
cz_end=2;


%% Condiciones iniciales:
x1=15;
x2=9;
x3=6;
x4=0.01;
x5=0.01;
x6=0.01;

x0=[x1 x2 x3 x4 x5 x6];

umbral = 1e-6;

cy=0:0.05:cy_end;
cz=0:0.05:cz_end;

m1=length(cy);
m2=length(cz);

% Inicializar matrices para almacenar resultados y colores
R1 = zeros(m1, m2);

for i=1:m1
    for j=1:m2
        P=[r0 s0 K n c d1 d2 b theta1 theta2 theta3 theta4 p q0 e cx cy(i) cz(j) G1 G2 G3];

        % Simulación del Modelo
        options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
        [tv,Yv] = ode45(@(t,Y) vivi(t,Y,P),[0 10000],x0);

        % Determinar el color según las condiciones dadas
        if Yv(end,1) > 0.00001 && Yv(end,2) > 0.00001 && Yv(end,3) > 0.00001 %coexistencia
            R1(i,j) = 1;
        elseif Yv(end,1) > 0.00001 && Yv(end,2) < 0.00001 && Yv(end,3) > 0.00001 %Exz
            R1(i,j) = 2;
        elseif Yv(end,1)  < 0.00001  && Yv(end,2)  < 0.00001  && Yv(end,3) > 0.00001 %Ez
            R1(i,j) = 3;
        else
            R1(i,j) = 4; %Exy
        end

        clear Yv
    end
end

tiempo_transcurrido = toc


figure(1);

customColorMap = [
    0, 0, 1;  % Azul pastel para el valor 1
    1, 1, 0;  % Amarillo pastel para el valor 2
    1, 0, 0;  % Rojo pastel para el valor 3
    0, 1, 0   % Verde pastel para el valor 4
];



[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R1', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 20;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);

