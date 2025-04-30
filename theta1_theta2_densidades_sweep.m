% This code performs a parameter sweep over the theta1 and theta2 space of the model
% WITH phenotypic change, and generates a color diagram of the densities.
% To solve the ODE, we use the ODE45 function with different initial conditions.
% Solution by Vivi
% Parameter settings:

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
d1=0.8;
d2=0.1;
b=0.01;
%theta1=4;
%theta2=3;
theta3=3;
theta4=3;
p0=0.1;
q=0.05;
e=0.001;
cx=1;
cy=1;
cz=1;
G1=0.01;
G2=0.01;
G3=0.01;


theta1_end=4;
theta2_end=4;


%% Condiciones iniciales:
x1=15;
x2=9;
x3=6;
x4=0.01;
x5=0.01;
x6=0.01;

x0=[x1 x2 x3 x4 x5 x6];

theta1=1:0.1:theta1_end;
theta2=1:0.1:theta2_end;

m1=length(theta1);
m2=length(theta2);

attack_y = zeros(m1, m2);
attack_z = zeros(m1, m2);
competition_y = zeros(m1, m2);
competition_z = zeros(m1, m2);

R1 = zeros(m1, m2);
R2 = zeros(m1, m2);
R3 = zeros(m1, m2);
R4 = zeros(m1, m2);
R5 = zeros(m1, m2);
R6 = zeros(m1, m2);

for i=1:m1;
    for j=1:m2;

P=[r0 s0 K n c d1 d2 b theta1(i) theta2(j) theta3 theta4 p0 q e cx cy cz G1 G2 G3];


t_custom = linspace(0, 10000, 10000); 
options = odeset('AbsTol',1.0e-8,'RelTol',1.0e-10);
[tv,Yv]=ode45(@(t,Y) vivi(t,Y,P),t_custom, x0, options);


attack_y(i,j)=d1 / (1+exp(theta1(i)*(mean(Yv(end-1000:end,4))-mean(Yv(end-1000:end,5)))));
attack_z(i,j)=d2 / (1+exp(theta2(j)*(mean(Yv(end-1000:end,4))-mean(Yv(end-1000:end,6)))));
competition_y(i,j) = b / (1+exp(theta3*(mean(Yv(end-1000:end,5))-mean(Yv(end-1000:end,6)))));
competition_z(i,j) = b / (1+exp(theta4*(mean(Yv(end-1000:end,6))-mean(Yv(end-1000:end,5)))));


R1(i,j)=mean(Yv(end-1000:end,1)); % prey
R2(i,j)=mean(Yv(end-1000:end,2)); % native predator
R3(i,j)=mean(Yv(end-1000:end,3)); % exotic predator

R4(i,j)=mean(Yv(end-1000:end,4)); % prey trait
R5(i,j)=mean(Yv(end-1000:end,5)); % native predator trait
R6(i,j)=mean(Yv(end-1000:end,6)); % exotic predator trait

%R4(i,j)=Yv(end,4); % prey trait
%R5(i,j)=Yv(end,5); % native predator trait
%R6(i,j)=Yv(end,6); % exotic predator trait


R1(R1 < 0.0001) = 0;
R2(R2 < 0.0001) = 0;
R3(R3 < 0.0001) = 0;
R4(R4 < 0.0001) = 0;
R5(R5 < 0.0001) = 0;
R6(R6 < 0.0001) = 0;

R7 = attack_y;
R8 =  attack_z;
R9 = competition_y;
R10 = competition_z;


clear Yv

    end
end


max1=max(max(R1));
min1=min(min(R1));



% Definir una paleta de colores personalizada de verde a azul
% myColors = [0 1 0;   % Verde
%             0 0 1];  % Azul

% 
% figure(1);
% 
% 
% subplot(1,3,1);
% [X, Y] = meshgrid(theta1, theta2);
% contourf(X, Y, R1', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R1(:)), max(R1(:))]);
% clim([min(R1(:)), max(R1(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 14;
% xlim([1, theta1_end]);
% ylim([1, theta2_end]);
% axis square;
% 
% 
% 
% subplot(1,3,2);
% 
% [X, Y] = meshgrid(theta1, theta2);
% contourf(X, Y, R2', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R2(:)), max(R2(:))]);
% clim([min(R2(:)), max(R2(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 14;
% xlim([1, theta1_end]);
% ylim([1, theta2_end]);
% axis square;
% 
% 
% subplot(1,3,3);
% 
% [X, Y] = meshgrid(theta1, theta2);
% contourf(X, Y, R3', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R3(:)), max(R3(:))]);
% clim([min(R3(:)), max(R3(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 14;
% xlim([1, theta1_end]);
% ylim([1, theta2_end]);
% axis square;
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure(2);
% 
% 
% subplot(1,3,1);
% [X, Y] = meshgrid(theta1, theta2);
% contourf(X, Y, R4', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R1(:)), max(R1(:))]);
% clim([min(R1(:)), max(R1(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 14;
% xlim([1, theta1_end]);
% ylim([1, theta2_end]);
% axis square;
% 
% 
% 
% subplot(1,3,2);
% 
% [X, Y] = meshgrid(theta1, theta2);
% contourf(X, Y, R5', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R2(:)), max(R2(:))]);
% clim([min(R2(:)), max(R2(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 14;
% xlim([1, theta1_end]);
% ylim([1, theta2_end]);
% axis square;
% 
% 
% subplot(1,3,3);
% 
% [X, Y] = meshgrid(theta1, theta2);
% contourf(X, Y, R6', 2000, 'LineStyle', 'none');
% colormap(jet);
% caxis([min(R3(:)), max(R3(:))]);
% clim([min(R3(:)), max(R3(:))]);
% colorbar;
% ax = gca;
% ax.FontSize = 14;
% xlim([1, theta1_end]);
% ylim([1, theta2_end]);
% axis square;
% 
% 
% 
% 

% Figura 1: Ajustar el color rojo para el mínimo valor de R1, R2, R3
min_val1 = min([R1(:); R2(:); R3(:)]);
max_val1 = max([R1(:); R2(:); R3(:)]);

% Invertir colormap de jet para que el rojo esté asociado al valor mínimo
cmap1 = flipud(jet(2000)); % Invertir la colormap

figure(1);
subplot(1,3,1);
[X, Y] = meshgrid(theta1, theta2);
contourf(X, Y, R1', 2000, 'LineStyle', 'none');
colormap(cmap1);
caxis([min_val1, max_val1]);
cb = colorbar;
set(cb, 'TickLabelInterpreter', 'latex'); % LaTeX 
ax = gca;
ax.FontSize = 14;
xlim([1, theta1_end]);
ylim([1, theta2_end]);
axis square;
xticks([0, 1, 2, 3, 4, 5]);
yticks([0, 1, 2, 3, 4, 5]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);

subplot(1,3,2);
contourf(X, Y, R2', 2000, 'LineStyle', 'none');
colormap(cmap1);
caxis([min_val1, max_val1]);
cb = colorbar;
set(cb, 'TickLabelInterpreter', 'latex'); % Aquí se aplica LaTeX
ax = gca;
ax.FontSize = 14;
xlim([1, theta1_end]);
ylim([1, theta2_end]);
axis square;
xticks([0, 1, 2, 3, 4, 5]);
yticks([0, 1, 2, 3, 4, 5]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);

subplot(1,3,3);
contourf(X, Y, R3', 2000, 'LineStyle', 'none');
colormap(cmap1);
caxis([min_val1, max_val1]);
cb = colorbar;
set(cb, 'TickLabelInterpreter', 'latex'); % Aquí se aplica LaTeX
xlim([1, theta1_end]);
ylim([1, theta2_end]);
axis square;
xticks([0, 1, 2, 3, 4, 5]);
yticks([0, 1, 2, 3, 4, 5]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);




% Figura 2: Ajustar el color rojo para el mínimo valor de R4, R5, R6
min_val2 = min([R4(:); R5(:); R6(:)]);
max_val2 = max([R4(:); R5(:); R6(:)]);

% Invertir colormap de jet para que el rojo esté asociado al valor mínimo
cmap2 = flipud(jet(2000)); % Invertir la colormap

figure(2);

subplot(1,3,1);
contourf(X, Y, R4', 2000, 'LineStyle', 'none');
colormap(cmap2);
caxis([min_val2, max_val2]);
cb = colorbar;
set(cb, 'TickLabelInterpreter', 'latex'); % Aplica LaTeX en la barra de color
ax = gca;
ax.FontSize = 14;
xlim([1, theta1_end]);
ylim([1, theta2_end]);
axis square;
xticks([0, 1, 2, 3, 4, 5]);
yticks([0, 1, 2, 3, 4, 5]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);

subplot(1,3,2);
contourf(X, Y, R5', 2000, 'LineStyle', 'none');
colormap(cmap2);
caxis([min_val2, max_val2]);
cb = colorbar;
set(cb, 'TickLabelInterpreter', 'latex'); % Aplica LaTeX en la barra de color
ax = gca;
ax.FontSize = 14;
xlim([1, theta1_end]);
ylim([1, theta2_end]);
axis square;
xticks([0, 1, 2, 3, 4, 5]);
yticks([0, 1, 2, 3, 4, 5]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);

subplot(1,3,3);
contourf(X, Y, R6', 2000, 'LineStyle', 'none');
colormap(cmap2);
caxis([min_val2, max_val2]);
cb = colorbar;
set(cb, 'TickLabelInterpreter', 'latex'); % Aplica LaTeX en la barra de color
ax = gca;
ax.FontSize = 14;
xlim([1, theta1_end]);
ylim([1, theta2_end]);
axis square;
xticks([0, 1, 2, 3, 4, 5]);
yticks([0, 1, 2, 3, 4, 5]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 30);


