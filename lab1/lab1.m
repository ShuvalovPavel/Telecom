clc
clear all

% Дискретные сигналы

Fs = 8e3;     %частота дискретизации 8 кГц
t = 0:1/Fs:1; %одна чекунда дискретных значений времени
t = t';       %преобразуем строку в столбец
 
A = 2;                            %амплитуда - два вольта
f0 = 1e3;                         %частота - 1 кГц
phi = pi/4;                       %начальная фаза - 45 градусов
s1 = A * cos(2*pi*f0*t + phi);    %гармонический сигнал
alpha = 1e3;                      %скорость затухания
s2 = exp(-alpha*t) .* s1;         %затухающая синусоида

figure
subplot(2, 2, 1); plot(s2(1:100))      %линейная интерполяция
subplot(2, 2, 2); plot(s2(1:100))      %отсчетные точки
subplot(2, 2, 3); stem(s2(1:100))      %"стебельки"
subplot(2, 2, 4); stairs(s2(1:100))    %"ступеньки"

% Ось времени по горизонтали
figure
plot( t(1:100), s2(1:100));

% Многоканальный сигнал
f = [600 800 1000 1200 1400];
s3 = cos(2*pi*t*f);

figure
plot( t(1:100), s3(1:100,:) )

% Экспоненциальный импульс
f = 0.1e3;
T = 1 / f;

s = A * exp(-alpha * t) .* (t >= 0);
figure
plot( t(1:100), s(1:100));

% Прямоугольный импульс
s = A * (abs(t) <= T/2);
figure
plot( t(1:100), s(1:100));

% Несимметричный треугольный импульс
s = A * t / T .* (t >= 0) .* (t <= T);
figure
plot( t(1:100), s(1:100));

% Другой способ задания
% Односторонний экспоненциальный импульс
s = zeros(size(t));
inds = find(t >= 0);
s( inds ) = A * exp( -alpha * t( inds ) );
figure
plot( t(1:100), s(1:100));

% Прямоугольный видеоимпульс
s = zeros(size(t));
s( find( abs(t) <= T/2 ) ) = A;
figure
plot( t(1:100), s(1:100));

% Несимметричный треугольный импульс
s = zeros(size(t));
inds = find( (t >= 0) & (t <= T) );
s( inds ) = A * t( inds ) / T;
figure
plot( t(1:100), s(1:100));

% Пара разнополярных прямоугольных импульсов
Fs = 1e3;
t = -40e-3:1/Fs:40e-3;
T = 20e-3;
A = 5;
s = -A * rectpuls( t + T/2, T ) + A * rectpuls( t - T/2, T );
plot( t, s);
ylim([-6 6]);

% Симметричный трапециевидный импульс 
Fs = 1e3;
t = -50e-3:1/Fs:50e-3;
A = 10;
T1 = 20e-3;
T2 = 60e-3;
s = A * (T2 * tripuls(t, T2) - T1 * tripuls(t, T1)) / (T2 - T1);
figure
plot( t, s);


% Гауссов радиоимпульс и его амплитудный спектр
Fs = 16e3;
t = -10e-3:1/Fs:10e-3;
Fc = 4e3;
bw = 0.1;
bwr = -20;
s = gauspuls( t, Fc, bw, bwr );
Nfft = 2 ^ nextpow2( length(s) );
sp = fft( s, Nfft );
sp_dB = 20 * log10( abs(sp) );
f = (0:Nfft - 1) / Nfft * Fs;
figure
subplot(2, 1, 1); 
plot( t, s);
title('Гауссов радиоимпульс');
subplot(2, 1, 2); 
plot(f( 1:Nfft / 2 ), sp_dB( 1:Nfft / 2 ));
title('Амплитудный спектр радиоимпульса');
sp_max_db = 20 * log10( max(abs(sp)) );
edges = Fc * [1 - bw /2 1 + bw / 2];
hold on
plot( edges, sp_max_db( [1 1] )+bwr);
hold off
gauspuls( 'cutoff', Fc, bw, bwr, -6 )

% Последовательность из пяти симметричных треугольных импульсов
Fs = 1e3;
t = 0:1/Fs:0.5;
tau = 20e-3;
d = [20 80 160 260 380]' * 1e-3;
d(:,2) = 0.8.^(0:4)';
y = pulstran( t, d, 'tripuls', tau );
figure
plot( t, y );
y = pulstran( t, d, p, Fs, 'method' );


% Последовательность треугольных импульсов
Fs = 1e3;
t = -25e-3:1/Fs:125e-3;
A = 5;
T = 50e-3;
t1 = 5e-3;
s = (sawtooth(2*pi*t/T, 1-t1/T) - 1) * A/2;
figure
plot(t, s);

% Графики функции Дирихле
x = 0:0.01:15;
figure
plot(x, diric(x, 7));
grid on
title('n = 7');
figure
plot(x, diric(x, 8));
grid on
title('n = 8');
