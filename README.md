# Parameter Sweep for Phenotypic Change Model

This repository contains MATLAB scripts designed to perform parameter sweeps and generate bifurcation diagrams or heatmaps for a mathematical model **with phenotypic change**, using the `ODE45` solver.

## Overview

The codes:
- Solve a system of ordinary differential equations (ODEs) using `ODE45`
- Explore different parameter combinations (e.g., `theta1`, `theta2`, `d1`, `d2`, `cy`, `cz`, `Gy`, `Gz`)
- Store and visualize the resulting population densities and trait dynamics
- Output **time series**, **bifurcation diagrams**, or **color maps**, depending on the script

Each script allows for easy customization of:
- **Parameter ranges** to be swept
- **Step sizes** for each parameter
- **Initial conditions**
- **Simulation time span and resolution**

## Files

Example scripts include:
- `sweep_theta1_theta2.m`: Parameter sweep over `theta1` and `theta2`
- `sweep_d1_d2.m`: Sweep over dispersal rates `d1` and `d2`
- `sweep_cy_cz.m`: Sweep over cost parameters `cy` and `cz`
- `sweep_Gy_Gz.m`: Sweep over growth rates `Gy` and `Gz`
- `time_series_plot.m`: Plots time series of density, trait, attack rate, and competition coefficient

## How to Use

1. Open the script in MATLAB.
2. Modify the parameter ranges:
   ```matlab
   theta1_vals = 0.1:0.05:1.0;
   d1_vals = 0.01:0.01:0.1;
   cy_vals = [0.2 0.5 0.8];
   % etc.
