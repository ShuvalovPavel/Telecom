Fs = 1000; % частота дискретизации
t = 0:1/Fs:5; % временная ось

signal = sin(2*t); % сигнал

noised_signal = awgn(signal, 20); % зашумлённый сигнал

plots(Fs, t, noised_signal); % рисуем зашумлённый сигнал

Filter = thousand_filter; % объект фильтра

filtered_signal = filter(Filter.Numerator, 1, signal); % пропускаем сигнал через фильтр

plots(Fs, t, filtered_signal); % рисуем получившийся сигнал
