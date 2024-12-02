%% Baseline Optical Communication System Simulation

% Clear workspace
clear; clc;

% Parameters
data_rate = 1e9; % Data rate in bps
bit_period = 1 / data_rate; % Bit duration
num_bits = 1000; % Number of bits to transmit
time = linspace(0, num_bits * bit_period, num_bits * 100); % Time vector
fiber_length = 50; % Fiber length in km
attenuation = 0.2; % Attenuation in dB/km
input_power = 1; % Input power in mW
pulse_width = 10e-12; % Initial pulse width in seconds
dispersion = 17e-12 / 1e-6; % Dispersion parameter in ps/nm/km

% Transmitter: Generate Random Binary Data and Modulate Using OOK
data = randi([0, 1], 1, num_bits); % Generate random binary data
signal = repelem(data, 100); % OOK modulation (repeating each bit)
time_signal = linspace(0, num_bits * bit_period, length(signal));

% Channel: Apply Attenuation and Dispersion
output_power = input_power * 10^(-attenuation * fiber_length / 10);
disp(['Output Power after ', num2str(fiber_length), ' km: ', num2str(output_power), ' mW']);

broadening = sqrt((dispersion * fiber_length)^2 + pulse_width^2);
disp(['Pulse Width after Dispersion: ', num2str(broadening * 1e12), ' ps']);

% Add noise to the received signal
received_signal = signal * output_power; % Attenuated signal
noisy_signal = received_signal + 0.01 * randn(size(received_signal)); % Add Gaussian noise

% Receiver: Threshold-based Demodulation
threshold = 0.5 * max(noisy_signal); % Decision threshold
demodulated_signal = noisy_signal > threshold;

% Eye Diagram
figure;
eyediagram(noisy_signal(1:2000), 200);
title('Eye Diagram (Baseline System)');

% Calculate BER
errors = sum(data ~= demodulated_signal(1:100:end));
ber = errors / num_bits;
disp(['Bit Error Rate (BER): ', num2str(ber)]);

% Plot Signals
figure;
subplot(3, 1, 1);
stem(data, 'LineWidth', 1.5);
title('Transmitted Data'); xlabel('Bit Index'); ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
plot(time_signal, noisy_signal, 'LineWidth', 1.5);
title('Noisy Signal at Receiver'); xlabel('Time (s)'); ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
stem(demodulated_signal(1:100:end), 'LineWidth', 1.5);
title('Demodulated Signal'); xlabel('Bit Index'); ylabel('Amplitude');
grid on;
