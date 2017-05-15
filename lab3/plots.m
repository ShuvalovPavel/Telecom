%% Функция для построения амплитудного и фазового спектров
% f - частота дискретизации
% t - временная ось
% s - значения сигнала
function [] = plots(f, t, s)
    L = length(s); % количество точек во временной области
    spec = fft(s)/L; % комплексный спектр
    spec = fftshift(spec); % выравнивание спектра относительно нуля
    a_spec = abs(spec); % модуль комплексного спектра
    f_spec = angle(spec);% фаза комплексного спектра
    freq =-(f/2-1/L):f/L:f/2-1/L;% массив частот
    %% Построение графиков
    figure;
    set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Arial');
    set(0,'DefaultTextFontSize',20,'DefaultTextFontName','Times New Roman'); 
    plot(t,s,'linewidth', 1.5);% Построение сигнала
%     title('Сигнал');% Подпись графика
    xlabel('t, s');% Подпись оси х графика
    grid on;
    figure;

    subplot(2,1,1);% Выбор области окна для построения
    plot(freq,a_spec,'r','linewidth', 1);% Построение сигнала
    title('Амплитудный');% Подпись графика
    xlabel('f, Hz');% Подпись оси х графика
    ylim([-0.5 1.5])
    grid on;

    subplot(2,1,2);% Выбор области окна для построения
    plot(freq,f_spec,'r','linewidth', 1);% Построение смеси сигнал+шум
    title('Фазовый');% Подпись графика
    xlabel('f, Hz');% Подпись оси х графика
    grid on;
end