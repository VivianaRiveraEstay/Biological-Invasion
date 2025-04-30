% En este codigo realiza un barrido en el espacio de parametros d1 y d2 del modelo 
% con cambio fenotipico y genera un diagrama de color de las densidades.
% para resolver la edo utilizamos la funcion ODE45, con distintas condiciones iniciales.
%Solucion vivi
%Fijacion de Parametros:
clc 
close all
clear all
%% Parametros
format long
r0=1.2;
s0=0.2;
K=100;
n=10;
c=5;
%d1=0.4;
%d2=0.6
b=0.005;
theta1=3;
theta2=6;
theta3=6;
theta4=3;
p=0.1;
q0=0.05;
e=0.001;
cx=1;
cy=1;
cz=1;
G1=0.01;
G2=0.01;
G3=0.01;

d1_end=1;
d2_end=1;

%% Condiciones iniciales:
x1=15;
x2=9;
x3=6;
x4=0.01;
x5=0.01;
x6=0.01;

x0=[x1 x2 x3 x4 x5 x6];

umbral = 1e-6;

d1=0:0.03:d1_end;
d2=0:0.03:d2_end;

m1=length(d1);
m2=length(d2);

for i=1:m1;
    for j=1:m2;

P=[r0 s0 K n c d1(i) d2(j) b theta1 theta2 theta3 theta4 p q0 e cx cy cz G1 G2 G3];


%% Simulacion del Modelo
%options = odeset('AbsTol',1.0e-6,'RelTol',1.0e-6);
%options = odeset('AbsTol',1.000000000000000e-10,'RelTol',1.000000000000000e-08);
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
[tv,Yv]=ode45(@(t,Y) vivi(t,Y,P),[0 10000],x0);


    R1(i,j)=Yv(end,1);
% Ajustar valores pequeños o negativos
    R1(R1< umbral) = 0;
    R1(R1>100) = 100;

    R2(i,j)=Yv(end,2);
% Ajustar valores pequeños o negativos
    R2(R2 < umbral) = 0;

    R3(i,j)=Yv(end,3);
% Ajustar valores pequeños o negativos
    R3(R3 < umbral) = 0;


clear Yv

    end
end


% Definir una paleta de colores personalizada de verde a azul
% myColors = [0 1 0;   % Verde
%             0 0 1];  % Azul

% Crear la figura
figure(1);

% Subplot 1
subplot(1,3,1);

% Crear la cuadrícula de datos
[X, Y] = meshgrid(d1, d2);

% Graficar los datos como un mapa de contorno con colores
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(jet);

% Establecer los límites de los datos para la barra de color
caxis([min(R1(:)), max(R1(:))]);

% Ajustar los límites de la barra de color sin normalización
clim([min(R1(:)), max(R1(:))]);

% Mostrar la barra de color
colorbar;

% Ajustar el tamaño de la fuente del gráfico
ax = gca;
ax.FontSize = 14;

% Establecer los límites de los ejes X y Y
xlim([0, d1_end]);
ylim([0, d2_end]);


% Ajustar el aspecto del gráfico a cuadrado
axis square;

% Establecer las marcas en los ejes X y Y
xticks([0, 0.2, 0.4, 0.6, 0.8, 1]);
yticks([0.2, 0.4, 0.6, 0.8, 1]);

% Guardar la figura como un archivo EPS
print('presa.png', '-depsc');


% Subplot 2
subplot(1,3,2);

% Crear la cuadrícula de datos
[X, Y] = meshgrid(d1, d2);

% Graficar los datos como un mapa de contorno con colores
contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(jet);

% Establecer los límites de los datos para la barra de color
caxis([min(R2(:)), max(R2(:))]);

% Ajustar los límites de la barra de color sin normalización
clim([min(R2(:)), max(R2(:))]);

% Mostrar la barra de color
colorbar;

% Ajustar el tamaño de la fuente del gráfico
ax = gca;
ax.FontSize = 14;


% Establecer los límites de los ejes X y Y
xlim([0, d1_end]);
ylim([0, d2_end]);


% Ajustar el aspecto del gráfico a cuadrado
axis square;

% Establecer las marcas en los ejes X y Y
xticks([0, 0.2, 0.4, 0.6, 0.8, 1]);
yticks([0.2, 0.4, 0.6, 0.8, 1]);

% Guardar la figura como un archivo EPS
print('depredador_nativo.png', '-depsc');



% Subplot 3
subplot(1,3,3);

% Crear la cuadrícula de datos
[X, Y] = meshgrid(d1, d2);

% Graficar los datos como un mapa de contorno con colores
contourf(X, Y, R3', 2000, 'LineStyle', 'none');
colormap(jet);

% Establecer los límites de los datos para la barra de color
caxis([min(R3(:)), max(R3(:))]);

% Ajustar los límites de la barra de color sin normalización
clim([min(R3(:)), max(R3(:))]);

% Mostrar la barra de color
colorbar;

% Ajustar el tamaño de la fuente del gráfico
ax = gca;
ax.FontSize = 14;


% Establecer los límites de los ejes X y Y
xlim([0, d1_end]);
ylim([0, d2_end]);

% Ajustar el aspecto del gráfico a cuadrado
axis square;

% Establecer las marcas en los ejes X y Y
xticks([0, 0.2, 0.4, 0.6, 0.8, 1]);
yticks([0.2, 0.4, 0.6, 0.8, 1]);

% Guardar la figura como un archivo EPS
print('depredador_exotico.png', '-depsc');