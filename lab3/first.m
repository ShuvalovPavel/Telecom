Fs = 1000; % ������� �������������
t = 0:1/Fs:5; % ��������� ���

signal = sin(2*t); % ������

noised_signal = awgn(signal, 20); % ���������� ������

plots(Fs, t, noised_signal); % ������ ���������� ������

Filter = thousand_filter; % ������ �������

filtered_signal = filter(Filter.Numerator, 1, signal); % ���������� ������ ����� ������

plots(Fs, t, filtered_signal); % ������ ������������ ������
