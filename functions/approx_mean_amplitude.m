function [mean_amplitude] = approx_mean_amplitude(time_vec, signal, b_param, window)
    if b_param < 0.5 || b_param > 3
        b_param = NaN;
    end

    if isnan(b_param)
        mean_amplitude = NaN;
        return
    end

    transformed_window = window * b_param;

    max_times = max(time_vec);
    min_times = 0;

    if transformed_window(2) > max_times
        transformed_window(2) = max_times;
    end    
    
    if transformed_window(1) < min_times
        transformed_window(1) = 0;
    end

    startTime = transformed_window(1);
    endTime = transformed_window(2);

    timeDiffStart = abs(time_vec - startTime);
    timeDiffEnd = abs(time_vec - endTime);

    [~, startIndex] = min(timeDiffStart);
    [~, endIndex] = min(timeDiffEnd);

    if startIndex > length(signal) || startTime >= endTime
        error('Invalid input arguments.');
    end
    
    signalWindow = signal(startIndex:endIndex);
    if length(signalWindow(signalWindow ~= 0)) < 20
        mean_amplitude = NaN;
        return
    end
    
    mean_amplitude = mean(signalWindow);
end