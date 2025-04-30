clc 
close all
clear all
tic;

load('R1.mat');
load('R2.mat');
load('R3.mat');
load('R4.mat');
load('R5.mat');
load('R6.mat');

cy_end=2;
cz_end=2;

cy=0:0.01:cy_end;
cz=0:0.01:cz_end;

m1=length(cy);
m2=length(cz);


a = [0 2];
b = [0 2];


customColorMap = [
    0, 0, 1;  % Azul pastel para el valor 1
    1, 1, 0;  % Amarillo pastel para el valor 2
    1, 0, 0;  % Rojo pastel para el valor 3
    0, 1, 0   % Verde pastel para el valor 4
];


customColorMap2 = [
    0, 0, 1;  % Azul pastel para el valor 1
    1, 1, 0;  % Amarillo pastel para el valor 2
    1, 0, 0;  % Rojo pastel para el valor 3
    ];



figure (1)

[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R1', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 30;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);
hold on
plot(a, b, '-k', 'LineWidth', 2);

figure (2)

[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R2', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 30;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);
hold on
plot(a, b, '-k', 'LineWidth', 2);

figure (3)

[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R3', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 30;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);
hold on
plot(a, b, '-k', 'LineWidth', 2);


figure (4)

[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R4', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 30;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);
hold on
plot(a, b, '-k', 'LineWidth', 2);

figure (5)

[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R5', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 30;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);
hold on
plot(a, b, '-k', 'LineWidth', 2);

figure (6)

[X, Y] = meshgrid(cy, cz);
contourf(X, Y, R6', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 30;
xlim([0, cy_end]);
ylim([0, cz_end]);
axis square;
xticks([0, 0.5, 1, 1.5, 2]);
yticks([0, 0.5, 1, 1.5, 2]);
hold on
plot(a, b, '-k', 'LineWidth', 2);