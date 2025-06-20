set JOBS; # jobs

# grid bounds
param x_grid >= 0;
param y_grid >= 0;
# anchor point is lower left on a standard cartesian plane
var x_anchor{i in JOBS} integer >= 1; # anchor point x_anchor
var y_anchor{i in JOBS} integer >= 1; # anchor point y_anchor

# switches for collision system
var a{i in JOBS, j in JOBS} binary;
var b{i in JOBS, j in JOBS} binary;
var c{i in JOBS, j in JOBS} binary;
var d{i in JOBS, j in JOBS} binary;
var f{i in JOBS, j in JOBS} binary;
var g{i in JOBS, j in JOBS} binary;

var start_time{i in JOBS} integer >= 0; # start time

param weight{JOBS}; # weight
param processing_time{JOBS}; # processing time
param M; # helper constant
param width{JOBS}; # width
param height{JOBS}; # height

minimize Weighted_Sum:
	sum{i in JOBS} weight[i]*(start_time[i]+processing_time[i]); 

# collision detection system
# makes sure that either the x_anchor is to the: 
subject to Start_Left {i in JOBS, j in JOBS: i < j}:
    x_anchor[i] + width[i] <= x_anchor[j] + M * (1 - a[i, j]); # left

subject to Start_Right {i in JOBS, j in JOBS: i < j}:
    x_anchor[i] >= x_anchor[j] + width[j] - M * (1 - b[i, j]); # right
    
# or the y_anchor is:
subject to Start_Below {i in JOBS, j in JOBS: i < j}:
    y_anchor[i] + height[i] <= y_anchor[j] + M * (1 - c[i, j]); # below
    
subject to Start_Above {i in JOBS, j in JOBS: i < j}:
    y_anchor[i] >= y_anchor[j] + height[j] - M * (1 - d[i,j]); # above

# or the job starts 
subject to Start_Before {i in JOBS, j in JOBS: i < j}:
    start_time[i] + processing_time[i] <= start_time[j] + M * (1 - f[i, j]);
    # before
    
subject to Start_After {i in JOBS, j in JOBS: i < j}:
    start_time[i] >= start_time[j] + processing_time[j] - M * (1 - g[i,j]);
	# after 
# any other job that overlaps

# requires at least one of the above collision constraints hold
subject to No_Clip {i in JOBS, j in JOBS: i < j}:
    a[i, j] + b[i, j] + c[i, j] + d[i,j] + f[i,j] + g[i,j] >= 1;

# makes sure that the rectangle doesn't clip off the edge of the grid
subject to x_bound_upper {i in JOBS}:
    x_anchor[i] + width[i] <= x_grid+1;
	
subject to y_bound_upper {i in JOBS}:
    y_anchor[i] + height[i] <= y_grid+1;


