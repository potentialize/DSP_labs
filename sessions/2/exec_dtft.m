%% Task 2
dtft([1 0 0 0 0], [0:0.0001:0.5]);

%% Task 3
dtft([0 0 0 0 1 0 0 0 0], [0:0.0001:0.5]);

%% Task 4
x = ones(10, 1);
dtft(x, [0:0.0001:0.5]);

%% Task 5
x = ones(100, 1);
dtft(x, [0:0.0001:0.5]);

%% Task 6
x = ones(100, 1);
dtft(x, [-4:0.0001:4]);

% => discrete = periodic in other domain
% => aperiodic = continuous in other domain
% aliasing???

%% Task 7
x = sin(2*pi*0.01*[0:999]);
fs = 44100; % Hz
soundsc(x, fs);
dtft(x, [0:0.0001:0.5]);

%% Task 8


%% Task 9