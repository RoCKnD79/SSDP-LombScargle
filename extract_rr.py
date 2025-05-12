import numpy as np
import matplotlib.pyplot as plt
import neurokit2 as nk

def main():
    
    # Set this variable to False if you want to generate the RR intervals. Set it to True if you want
    # to plot the signal and the RR intervals
    generate_rr = False
    
    # Sampling frequency actually used for the recording
    fs = 250
    
    # Retrieve the recording
    ecg_signal = np.genfromtxt('Roman-Recording-2.csv', delimiter=',')[1:]
    
    # Size of the signal
    N = ecg_signal.shape[0]
    
    # Plot the signal
    fig, ax = plt.subplots()
    ax.set_title("RR intervals")

    # Remove very noisy samples
    sample_start = 500
    sample_end = N - 500

    # Get the actual signal
    eff_data = ecg_signal[sample_start: sample_end, 1]
    ecgs, info = nk.ecg_process(eff_data, fs)

    if generate_rr:
        nk.ecg_plot(ecgs, info)
        plt.show()

    else:
        rr_signal = np.diff(info["ECG_R_Peaks"]) / fs
        print(rr_signal)

        np.save('RR-2', rr_signal)


if __name__ == '__main__':
    main()