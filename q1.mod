# Sets and Parameters
set JOBS;
param processing_time{JOBS};                # Processing time for each job
param weight{JOBS};                # Weight for each job

# Define max_time as the sum of all processing times
param max_time := sum {j in JOBS} processing_time[j];

# Adjust TIME to go from 1 to max_time
set TIME := 1..max_time;

# Decision Variables
var if_start{JOBS, TIME} binary;     # 1 if job j starts at time t, 0 otherwise
var comp_time{JOBS} >= 0;             # completion time for each job
var start_time{JOBS} >= 0;             # Start time for each job
var a{i in JOBS, j in JOBS} binary;
var b{i in JOBS, j in JOBS} binary;
param M; # helper constant

# Objective: Minimize Weighted Sum of comp_timeompletion Times
minimize Total_Weighted_Completion_Time:
    sum {j in JOBS} weight[j] * comp_time[j];

# comp_timeonstraints

# 1. Each job starts exactly once
subject to Job_Start_Once {j in JOBS}:
    sum {t in TIME: t <= max_time - processing_time[j] + 1} if_start[j, t] = 1;

# 2. Define start time for each job
subject to Start_Time {j in JOBS}:
    start_time[j] = sum {t in TIME: t <= max_time - processing_time[j] + 1} t * if_start[j, t];

# 3. Define completion time for each job
subject to Completion_Time {j in JOBS}:
    comp_time[j] = start_time[j] + processing_time[j] - 1;

# 4. Job sequencing to prevent overlap
subject to Start_Before {j in JOBS, k in JOBS: j < k}:
    start_time[j] + processing_time[j] <= start_time[k] + M * (1 - a[j, k]);

subject to Start_After {j in JOBS, k in JOBS: j < k}:
    start_time[j] >= start_time[k] + processing_time[k] - M * (1 - b[j, k]);
   
subject to Either_Before_Or_After {j in JOBS, k in JOBS: j < k}:
    a[j, k] + b[j, k] >= 1;
   
   
   
   
   