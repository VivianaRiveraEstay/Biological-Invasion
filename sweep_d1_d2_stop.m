% This code performs a parameter sweep and generates a bifurcation diagram
% of the model with phenotypic change.
% To solve the ODE, we use the ODE45 function with different initial conditions.
% The code is optimized, as it stops shortly after the solution has converged.
% Solution by Vivi
% Parameter settings:
clc 
close all
clear all
tic;
%% Parameters
format long
r0=1.2;
s0=0.2;
K=100;
n=10;
c=5;
%d1=0.4;
%d2=0.6
b=0.075;
theta1=2;
theta2=2;
theta3=6;
theta4=6;
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


%% Initial Conditions
x1=15;
x2=9;
x3=6;
x4=0.01;
x5=0.01;
x6=0.01;

x0=[x1 x2 x3 x4 x5 x6];

d1=0:0.1:d1_end;
d2=0:0.1:d2_end;
m1=length(d1);
m2=length(d2);
R1 = zeros(m1, m2);


for k=1:m1
    for j=1:m2

x1=15;
x2=9;
x3=6;
x4=0.01;
x5=0.01;
x6=0.01;

x0=[x1 x2 x3 x4 x5 x6];       
  
P=[r0 s0 K n c d1(k) d2(j) b theta1 theta2 theta3 theta4 p q0 e cx cy cz G1 G2 G3];

% Define the total interval and the time step size
total_time = 10000;
time_step = 200;
 
% Threshold to adjust small or negative values
umbral = 1e-6;
 
% Define the tolerance to compare consecutive solutions
tolerancia = 0.000001;
 
% Initialize a cell array to store the solutions in each range
soluciones = cell(1, total_time / time_step);

% Configuration of the differential equation and ode45 options      
ode_func = @(t, Y) vivi(t, Y, P);
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @(t, Y) checkEvents(t, Y, umbral));

% Bucle para ejecutar ode45 en cada rango y almacenar las soluciones
for i = 0:time_step:total_time
    t = [ ];
    y = [ ];

% Define the time interval for the current run
    tspan = i:0.1:i + time_step;
 
% Call ode45 for the current range
[t, y] = ode45(ode_func, tspan, x0);
 
% Adjust small or negative values
if y(end,1)< umbral
    y(end,1)=0;
end

if y(end,2)<umbral 
    y(end,2)=0;
end

if y(end,3)<umbral 
   y(end,3)=0;
end

    % Store the solution in the cell array
    index = floor(i / time_step) + 1;
    %soluciones{index} = [tspan', y_interp];
    soluciones{index} = y;
    tsol{index}=t;
 
% Check if consecutive solutions are very similar
if index > 1
    error01=mean(abs(soluciones{index}(:,1)-soluciones{index-1}(:,1)));
    error02=mean(abs(soluciones{index}(:,2)-soluciones{index-1}(:,2)));
    error03=mean(abs(soluciones{index}(:,3)-soluciones{index-1}(:,3)));
    %error=max(abs(soluciones{index}(end,1:3)-soluciones{index-1}(end,1:3)));
    error=mean([error01,error02,error03]);
    if error < tolerancia
    % && any(max(abs(soluciones{index}(:, 2:end) - soluciones{index-1}(:, 2:end))) < tolerancia)
    %fprintf('Las soluciones consecutivas son muy parecidas. Se detendra la simulacion);
    break;
    end
end
 
% Update the initial conditions for the next iteration
    x0 = y(end, :);

end

 clear x0


% Determine the color according to the given conditions

        if y(end,1) > 0.00001 && y(end,2) > 0.00001 && y(end,3) > 0.00001 
            R1(k,j) = 1;%coexistencd
        elseif y(end,1) > 0.00001 && y(end,2) < 0.00001 && y(end,3)> 0.00001 %Exz
            R1(k,j) = 2; %Exz
        elseif y(end,1)  < 0.00001  && y(end,2)  < 0.00001  && y(end,3) > 0.00001 %Ez
            R1(k,j) = 3; %Ez
        elseif y(end,1)  > 0.00001  && y(end,2) > 0.00001  && y(end,3) < 0.00001
            R1(k,j) = 4; %Exy
        end

        clear y
    end
end

tiempo_transcurrido = toc


figure(1);

customColorMap = [
    0 0 1; % azul para coexistencia
    0 1 0; % Verde para Exz
    1 0 0; % Rojo para Ez
    0 0 0  % Negro para Exy
];


[X, Y] = meshgrid(d1, d2);
contourf(X, Y, R1', 1:4, 'LineStyle', 'none');
colormap(customColorMap);
ax = gca;
ax.FontSize = 14;
xlim([0, d1_end]);
ylim([0, d2_end]);
axis square;
xticks([0.2, 0.4, 0.6, 0.8, 1]);
yticks([0.2, 0.4, 0.6, 0.8, 1]);
print('presa.png', '-depsc');
