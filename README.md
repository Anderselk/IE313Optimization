Project Summary

This repository contains AMPL implementations of two integer programming models developed for a course project in **IEMS 313: Deterministic Models and Optimization**. The models address complex scheduling problems using mathematical optimization techniques.

### 1. Single-Machine Scheduling Problem
This model schedules a set of jobs on a single machine to **minimize total weighted completion time**. It includes:
- Binary and integer decision variables to track job start and completion times.
- Constraints that ensure each job is scheduled exactly once and no two jobs overlap.
- A comparison with heuristic results, which matched the optimal solution for a small dataset.

### 2. 3D Scheduling Problem
An advanced model that schedules jobs within a **2D spatial grid over time**, accounting for each job's dimensions and duration. It features:
- A collision detection system to prevent spatial and temporal overlaps.
- Binary variables to enforce spatial sequencing (left/right, above/below) and temporal sequencing (before/after).
- An objective to minimize total weighted completion time across all jobs.
- Results showing a ~5% improvement over heuristic methods in complex scenarios.

### Repository Contents
- `.mod` files: AMPL model files
- `.dat` files: Input datasets
- `.run` files: AMPL execution scripts
- `README.md`: Project overview and instructions

### Authors
Anders Elk, Humza Khan, Addison Simon, Hadrian Sobota  
Northwestern University – IEMS 313
