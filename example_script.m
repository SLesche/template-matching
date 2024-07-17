clear all

% Setting paths
% Get the directory of the currently executing script
[filepath, ~, ~] = fileparts(mfilename('fullpath'));

% Set the current directory to that directory
cd(filepath);
addpath("./functions") % add template matching functions
addpath("./app") % add app functions

load("scripts_exp26/saved_data/kathrinexp26_times.mat");

condition_bins = [9, 10, 15, 35, 36, 37, 57, 58, 59];
n_conditions = length(condition_bins);

% Convert to cell array with conditionsXn_subject entries 
component_names = ["p3_kathrin"];
n_components = length(component_names);
electrodes = [11];
polarity = ["positive"];
windows = {[250 600]};

% For fitting
possible_approaches = ["maxcor", "minsq"];
possible_weights = ["get_normalized_weights"];
possible_normalization = ["none"];
possible_penalty = ["none"];
possible_derivative = [0, 1];

comb = combinations(possible_approaches, possible_weights, ...
    possible_penalty, possible_normalization, possible_derivative, ...
    component_names, polarity, electrodes, windows ...
    );

% add peak/area with no weights/normalization/penalty
comb(end+1, :) = {"peak", "none", "none", "none", 0, component_names, polarity, electrodes, windows};
comb(end+1, :) = {"area", "none", "none", "none", 0,  component_names, polarity, electrodes, windows};
comb(end+1, :) = {"liesefeld_area", "none", "none", "none", 0,  component_names, polarity, electrodes, windows};

column_names = {'approach', 'weight', 'penalty', 'normalization', 'use_derivative', 'component_name', 'polarity', 'electrodes', 'window'};
comb.Properties.VariableNames = column_names;

file = strcat("scripts_exp26/saved_data/", "average_t1_data.mat");
load(file)

fit_data = erp_mat(:, :, :, condition_bins);

erp_data = fit_data;
method_table = comb;
[n_subjects, n_chans, n_times, n_bins] = size(erp_data);

results_mat = run_template_matching(erp_data, time_vec, comb, 3);

review_app

%{
signal = squeeze(fit_data(2, 11, :, 2));
ga = squeeze(mean(erp_data(:, 11, :, 2), 1, 'omitnan'));
lat_ga = approx_peak_latency(time_vec, ga, [250 600], 'positive');

ms = @() run_multi_start(define_optim_problem(specify_objective_function(time_vec', signal, ga, [250 600], polarity, @get_normalized_weights, @eval_correlation, @(x) x ,@(a, b) 1, 0)));
gs = @() run_global_search(define_optim_problem(specify_objective_function(time_vec', signal, ga, [250 600], polarity, @get_normalized_weights, @eval_correlation, @(x) x ,@(a, b) 1, 0)));

timeit(ms)
timeit(gs)

plot(time_vec, signal)
%}