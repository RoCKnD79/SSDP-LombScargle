import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as ssig
import neurokit2 as nk


fs = 250
Ts = 1/fs

def smooth(a, window_size):
    filter = np.ones(window_size) / window_size
    avg = np.convolve(a, filter, mode='same')

    return avg


def main():
    ecg_signal = np.genfromtxt('/home/rocknd79/EPFL/MA4/SSDP/SSDP-LombScargle/Roman-Recording-2.csv', delimiter=',')[1:]
    N = ecg_signal.shape[0]
    fig, ax = plt.subplots()
    ax.set_title("values of RR intervals")

    sample_start = 500
    sample_end = N - 500
    nb_samples = sample_end - sample_start
    t_axis = np.arange(nb_samples) * Ts + sample_start

    eff_data = ecg_signal[sample_start: sample_end, 1]
    # eff_data = nk.ecg_simulate(duration=15, sampling_rate=250, heart_rate=70)
    # eff_data = smooth(eff_data, 10)
    # eff_data = smooth(eff_data, 10)
    # eff_data = smooth(eff_data, 10)

    # plt.subplot(1,3,1)
    # plt.plot(t_axis, eff_data)
    # plt.xlabel('time [s]')
    # plt.ylabel('amplitude')

    # plt.subplot(1,3,2)
    # print(1/fs)
    # freqs , Sper = ssig.periodogram(eff_data, fs=fs, return_onesided=False)  
    # # freqs = np.arange(nb_samples) / (nb_samples * Ts)
    # # spectrum = np.fft.fft(y_axis)
    # plt.plot(freqs, np.abs(Sper))
    # plt.xlabel('frequency [Hz]')
    # plt.ylabel('amplitude')

    # plt.subplot(1,3,3)
    # # plt.plot(freqs, np.fft.ifft(Sper))
    # ecgs, info = nk.ecg_process(eff_data, fs)
    # rr_signal = np.diff(info["ECG_R_Peaks"]) / fs
    # plt.plot(np.arange(rr_signal.size), rr_signal)

    # plt.show()

    ecgs, info = nk.ecg_process(eff_data, fs)
    nk.ecg_plot(ecgs, info)
    plt.show()

    # ecgs, info = nk.ecg_process(eff_data, fs)
    # rr_signal = np.diff(info["ECG_R_Peaks"]) / fs
    # print(rr_signal)

    # np.save('RR-1', rr_signal)


if __name__ == '__main__':
    main()