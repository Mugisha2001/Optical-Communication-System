Optical Communication System with Forward Error Correction (FEC)
Overview
This project demonstrates the design, simulation, and analysis of an optical communication system. It explores two main configurations:

Baseline System: Simulates the optical channel with attenuation, dispersion, and noise, analyzing its impact on the transmitted signal.
Improved System: Implements Forward Error Correction (FEC) using Hamming (7,4) codes to enhance signal integrity and reduce the Bit Error Rate (BER).
The project aims to highlight the importance of FEC and dispersion compensation in modern communication systems.

Objectives
Simulate optical signal transmission over a fiber channel.
Analyze the effects of attenuation, dispersion, and noise.
Compare system performance with and without FEC using BER as the key metric.
Visualize the transmitted, received, and reconstructed signals alongside eye diagrams.
Features
Baseline System:
Transmitter:
Generates random binary data.
Implements On-Off Keying (OOK) modulation to convert bits into optical signals.
Channel:
Simulates signal degradation due to attenuation and dispersion.
Adds Gaussian noise to the signal to model real-world conditions.
Receiver:
Demodulates the noisy signal using threshold detection.
Computes the BER to measure system performance.
Enhanced System with FEC:
FEC Coding:
Uses Hamming (7,4) error correction to encode data before transmission.
Decodes the received signal and corrects errors caused by channel impairments.
Dispersion Compensation:
Models compensation using Dispersion Compensation Fiber (DCF) to reduce pulse broadening.
Improved BER:
Demonstrates significant error reduction due to FEC and dispersion compensation.
Simulation Results
Baseline System:
BER: High due to the combined effects of noise, attenuation, and dispersion.
Eye Diagram: Shows significant distortion and inter-symbol interference.
Enhanced System:
BER: Substantially reduced after FEC and dispersion compensation.
Eye Diagram: Improved clarity, indicating better signal integrity.
File Structure
plaintext
Copy code
|-- README.md
|-- src/
    |-- transmitter/
        |-- data_generation.m       # Generates random binary data.
        |-- modulation.m            # Implements OOK modulation.
    |-- channel/
        |-- attenuation.m           # Simulates power loss due to attenuation.
        |-- dispersion.m            # Models pulse broadening due to dispersion.
        |-- noise.m                 # Adds Gaussian noise to the signal.
    |-- receiver/
        |-- detection.m             # Performs threshold detection.
        |-- demodulation.m          # Recovers binary data from the received signal.
    |-- fec/
        |-- encoding.m              # Encodes data using Hamming (7,4) code.
        |-- decoding.m              # Decodes data and corrects errors.
|-- plots/
    |-- eye_diagrams/
        |-- without_fec.png         # Eye diagram of baseline system.
        |-- with_fec.png            # Eye diagram after FEC.
    |-- signals/
        |-- transmitted_signal.png  # Original modulated signal.
        |-- noisy_signal.png        # Signal after channel impairments.
        |-- received_signal.png     # Signal after amplification and compensation.
|-- LICENSE
|-- .gitignore
Getting Started
Prerequisites
MATLAB or GNU Octave with the following toolboxes:
Communications Toolbox
Signal Processing Toolbox
Installation
Clone this repository:

bash
Copy code
git clone https://github.com/username/optical-communication-fec.git
cd optical-communication-fec
Open MATLAB or GNU Octave and navigate to the src/ directory.

Usage
Run the baseline system simulation:

Transmitter: transmitter/data_generation.m and transmitter/modulation.m
Channel: channel/attenuation.m, channel/dispersion.m, channel/noise.m
Receiver: receiver/detection.m, receiver/demodulation.m
View the results:
Eye diagram: plots/eye_diagrams/without_fec.png
BER output in the console.
Run the enhanced system simulation:

Add FEC: fec/encoding.m and fec/decoding.m
Apply dispersion compensation: channel/dispersion.m with DCF parameters.
View the improved results:
Eye diagram: plots/eye_diagrams/with_fec.png
BER output in the console.
Comparison
Metric	Baseline System	Enhanced System
BER	High	Significantly lower
Signal Integrity	Distorted	Improved with FEC
Eye Diagram	Blurred and closed eye	Clearer and open eye
Dispersion Handling	None	Compensated with DCF
Results
Key Observations:
Baseline System:

High error rate due to noise and dispersion.
Poor eye diagram indicating significant inter-symbol interference.
Enhanced System:

FEC effectively corrects most errors.
Dispersion compensation restores pulse shape, improving BER and signal clarity.
