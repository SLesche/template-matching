function [params] = run_multi_start(problem)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
% Define possible start points
possible_bs = linspace(0.6, 1.8, 10) + randn(1, 10).*0.01;
possible_as = linspace(0.75, 1.5, 3) + randn(1, 3).*0.02;

% Run multistart
ms = MultiStart('MaxTime', 60, 'Display', 'off');
[params, ~] = run(ms, problem, CustomStartPointSet(get_start_point_matrix(possible_as, possible_bs)));
end