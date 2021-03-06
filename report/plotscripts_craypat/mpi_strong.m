%% TIMINGS MPI - STRONG SCALING
% close all; clear all; clc
%For Npanels 20, error approx 5e-8

nbr_dompoints = 15*10^6;
nbr_panels = 20;

nbr_threads = [1; ...
               2; ...
               4; ...
               8; ...
               16; ...
               32];
               
time_sol = [75.118563; ...
            37.682591+0.001955; ...
            20.502258+0.002615; ...
            26.774974+0.000566;...
            6.020685+0.001120; ...
            3.010355+0.001462];
            
time_specq_loadimb = [0; ...
            31.918198; ...
            35.469121; ...
            26.774974; ... 
            16.840258; ...
            8.215223];

time_main = [0; ...
             68.246738; ...
             83.095999; ...
             67.975583; ...
             44.669388; ...
             25.026128];

time_main_loadimb = [0; ...
                     65.912622; ...
                     37.280168; ...
                     22.394291; ...
                     12.230543; ...
                     5.890728];
        
time_specqNoload = [72.098927; ...
                    35.666044; ...
                    19.806933; ...
                    11.697288; ...
                    6.360904; ...
                    3.069470];
            
time_tot = [170.997297; ...
            151.476633; ...
             130.839404; ...
           95.867782; ...
           59.563530; ...
           32.366726];


%%
figure(1); clf
loglog(nbr_threads,time_tot,'.-','LineWidth',2); 
hold on; grid on
loglog(nbr_threads,time_sol,'^-','LineWidth',2)
loglog(nbr_threads,time_specqNoload,'o-','LineWidth',2)
loglog(nbr_threads,time_main,'--','LineWidth',2);

xlabel('Number of MPI processes','FontSize',20,'interpreter','latex')
ylabel('time [s]','FontSize',20,'interpreter','latex')
set(gca,'FontSize',17)
h = legend('Total time','Comp. solution','Special quad.', ...
    'Main function');
set(h,'FontSize',17,'interpreter','latex')
title('Timings for MPI code, $N_{panels}=20$, $N_{dom}=15\cdot 10^6$','FontSize',20,'interpreter','latex')
% loglog(nbr_dompoints,nbr_dompoints*1e-5,'k:','LineWidth',2)
% h = legend('Total time','Density comp.','Comp. solution','Special quad.','O(N)');

%% BATCH 6 CRAYPAT
% close all; clear all; clc

%Calls 
figure(2); clf
callfun = [89.4 8.6 100-8.6-89.4];
H = pie(callfun);
h=legend('IPmultR', 'vandernewton','other');
title('Function calls, 32-thread MPI code - $N_{dom} = 15\cdot10^6$','FontSize',20,'interpreter','latex')
set(h,'FontSize',15)

figure(3); clf
timefun = [77.3 9.5 9.3 3.9]; %%timefun = [timefun 100-sum(timefun)];
H = pie(timefun);
h = legend('main','specialquadlapl','computeSolution','others');
% colormap(jet)
set(h,'FontSize',15)
title('Time, 32-thread MPI code - $N_{dom} = 15\cdot10^6$','FontSize',20,'interpreter','latex')


%% Save info table cache 32 threads

func = {'total','compSol','specQuad','vandernewton','ipmultr'};

D1_hit = [99.1; ...
          100; ...
          99.2; ...
          99; ...
          99.1];
          
D1_miss = [0.9; ...
          0; ...
          0.8; ...
          1; ...
          0.9];
          
D2_hit = [70.7; ...
          98.5; ...
          71.9; ...
          70.2; ...
          69.4];
          
D2_miss = [29.3; ...
            1.5; ...
            28.1; ...
            29.8; ...
            30.6];
            
D1D2_hit = [99.7; ...
            100; ...
            99.8; ...
            99.7; ...
            99.7];
            
D1D2_miss = [0.3; ...
            0; ...
            0.2; ...
            0.3; ...
            0.3];
        
 table(D1_hit,D1_miss,D2_hit,D2_miss,D1D2_hit,D1D2_miss,'RowNames',func)
            