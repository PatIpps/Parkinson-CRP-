function extended_signal = extendSignal(signal, factor)
    % Extend the signal using spline interpolation
    
    % Determine the new length of the signal
    original_length = numel(signal);
    new_length = round(factor * original_length);
    
    % Generate the indices for the original and extended signals
    original_indices = 1:original_length;
    extended_indices = linspace(1, original_length, new_length);
    
    % Perform spline interpolation
    extended_signal = interp1(original_indices, signal, extended_indices, 'spline');
end
