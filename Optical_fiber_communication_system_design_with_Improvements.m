% Parameters
clear; clc;

% Transmitter Parameters
bit_rate = 1e9; % 1 Gbps
data_length = 1000; % Number of bits
data = randi([0, 1], 1, data_length); % Random binary data
P_input = 1; % Transmitter power in mW
signal_amplitude = sqrt(P_input); % Signal amplitude

% Modulation (On-Off Keying - OOK)
t = linspace(0, 1/bit_rate, 100); % Time per bit
modulated_signal = [];
for i = 1:data_length
    modulated_signal = [modulated_signal, data(i) * signal_amplitude * ones(1, length(t))];
end

% Fiber Parameters
fiber_length = 50; % in km
attenuation = 0.2; % dB/km
P_output = P_input * 10^(-attenuation * fiber_length / 10); % Output after fiber

% Optical Amplifier (EDFA)
amp_gain = 10; % Amplifier gain in dB
amp_gain_linear = 10^(amp_gain/10); % Linear gain
P_amplified = P_output * amp_gain_linear; % Amplified power

% Dispersion Compensation
dispersion_factor = 17e-6; % ps/(nm*km)
fiber_dispersion = dispersion_factor * fiber_length; % Total dispersion
dcf_dispersion_factor = -dispersion_factor; % Compensation factor
dcf_length = fiber_dispersion / abs(dcf_dispersion_factor); % DCF length

% Adding Noise (to simulate real-world channel)
SNR = 20; % Signal-to-Noise Ratio in dB
noisy_signal = awgn(modulated_signal, SNR, 'measured'); % Add white Gaussian noise

% Receiver (Demodulation)
threshold = signal_amplitude / 2; % Threshold for decision-making
received_signal = noisy_signal > threshold; % Threshold-based detection
received_data = received_signal(1:100:end); % Sample the received signal

% Bit Error Rate (BER) Before FEC
errors_before = sum(data ~= received_data(1:data_length));
ber_before = errors_before / data_length;

% Forward Error Correction (Hamming Code Example)
% Encoding
encoded_data = encode(data, 7, 4, 'hamming/binary');

% Adding Noise to Encoded Signal
encoded_noisy_signal = awgn(double(encoded_data), SNR, 'measured') > 0.5;

% Decoding
decoded_data = decode(encoded_noisy_signal, 7, 4, 'hamming/binary');

% BER After FEC
errors_after = sum(data ~= decoded_data(1:data_length));
ber_after = errors_after / data_length;

% Display Results
disp(['Input Power (mW): ', num2str(P_input)]);
disp(['Output Power After Fiber (mW): ', num2str(P_output)]);
disp(['Output Power After Amplifier (mW): ', num2str(P_amplified)]);
disp(['Dispersion Compensation Fiber Length (km): ', num2str(dcf_length)]);
disp(['Bit Error Rate Before FEC: ', num2str(ber_before)]);
disp(['Bit Error Rate After FEC: ', num2str(ber_after)]);

% Visualization
figure;
subplot(3,1,1);
plot(modulated_signal, 'b');
title('Transmitted Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(3,1,2);
plot(noisy_signal, 'r');
title('Noisy Signal After Transmission');
xlabel('Time'); ylabel('Amplitude');

subplot(3,1,3);
eyediagram(noisy_signal(1:2000), 200);
title('Eye Diagram of Noisy Signal');