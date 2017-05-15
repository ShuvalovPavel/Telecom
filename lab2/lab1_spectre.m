% Дискретные сигналы
times = [];
signals = [];

% Синус
Fs = 8e3;     
t = 0:1/Fs:1; 
t = t';       
f = [600 800 1000 1200 1400]; 
s3 = sin(2*pi*t*f); 
[times, signals] = posledovatelnost(t,s3(:,1),times,signals);

% Эскпоненциальный сигнал 
A = 2;              
f0 = 1e3;           
phii = pi/4;        
alpha = 1e3;
s4 = A*exp(-alpha*t).*(t >= 0);
[times, signals] = posledovatelnost(t,s4,times,signals); 

% Прямоугольный 
Fs = 100;
t = -5:1/Fs:5;
t = t';       
T = 0.5;
s5 = A*(abs(t) <= T/2);
[times, signals] = posledovatelnost(t,s5,times,signals);

% Треугольный 
%s6 = A*t/T.*(t >= 0).*(t <= T).*(t >= T);
s6 = 2*T*tripuls(t,T)
[times, signals] = posledovatelnost(t,s6,times,signals); 

% прямоугольные сим
Fs = 8e3;    
t=-100e-3:1/Fs:100e-3; 
T=20e-3; 
A=5; 
s1=-A*rectpuls(t+T/2,1e-2)+A*rectpuls(t-T/2,1e-2);
[times, signals] = posledovatelnost(t,s1,times,signals);

% треугольные импульсы
Fs = 1e4; 
t = -50e-3:1/Fs:50e-3;
A = 10;
T1 = 20e-3; 
T2 = 60e-3; 
s = A*(T2*tripuls(t,T2)-T1*tripuls(t,T1))/(T2-T1);
[times, signals] = posledovatelnost(t,s,times,signals);

% Гаусс
Fs = 16e3; 
t = -50e-3:1/Fs:50e-3; 
Fc = 4e3; 
bw = 0.1; 
bwr = -20; 
s = gauspuls(t, Fc, bw, bwr); 
[times, signals] = posledovatelnost(t,s,times,signals);

% Pustran
Fs = 1e3; 
t = -0.25:1/Fs:0.75;
tau = 20e-3; 
d = [20 80 160 260 380]'*1e-3; 
d(:,2) = 0.8.^(0:4)'; 
y = pulstran(t,d,'tripuls',tau); 
[times, signals] = posledovatelnost(t,y,times,signals);

% Sawtooth
Fs = 1e4; 
t = -25e-3:1/Fs:125e-3; 
A = 5; 
T = 50e-3; 
t1 = 5e-3; 
s = (sawtooth(2*pi*t/T, 1-t1/T)-1)*A/2; 
[times, signals] = posledovatelnost(t,s,times,signals);

% Дирихле
x = 0:0.01:15; 
[times, signals] = posledovatelnost(x,diric(x, 7),times,signals);

% Main
for i=1:1000:length(times)
    h = figure(rem(i,999));   
    subplot(3,1,1);
    t = times(i:i+999);
    sig = signals(i:i+999);
    plot(t, sig);  
    Fs=8e3;
    FN=2^nextpow2(length(t));
    freqs1=(0:FN-1)/FN*Fs; 
    spc=fft(sig, FN);
    subplot(3,1,2);
    plot(freqs1, abs(spc));
    subplot(3,1,3);
    plot(freqs1, atan(imag(spc)./real(spc))); 
    grid on
    
    % составляем имя файла
    file_name = strcat(num2str(rem(i,999)));   
    
    %Сохранение графика в файл c нужным расширением
    saveas(h, file_name, 'jpg'); 
    close(h)
end

