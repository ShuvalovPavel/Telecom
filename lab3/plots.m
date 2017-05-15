%% ������� ��� ���������� ������������ � �������� ��������
% f - ������� �������������
% t - ��������� ���
% s - �������� �������
function [] = plots(f, t, s)
    L = length(s); % ���������� ����� �� ��������� �������
    spec = fft(s)/L; % ����������� ������
    spec = fftshift(spec); % ������������ ������� ������������ ����
    a_spec = abs(spec); % ������ ������������ �������
    f_spec = angle(spec);% ���� ������������ �������
    freq =-(f/2-1/L):f/L:f/2-1/L;% ������ ������
    %% ���������� ��������
    figure;
    set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Arial');
    set(0,'DefaultTextFontSize',20,'DefaultTextFontName','Times New Roman'); 
    plot(t,s,'linewidth', 1.5);% ���������� �������
%     title('������');% ������� �������
    xlabel('t, s');% ������� ��� � �������
    grid on;
    figure;

    subplot(2,1,1);% ����� ������� ���� ��� ����������
    plot(freq,a_spec,'r','linewidth', 1);% ���������� �������
    title('�����������');% ������� �������
    xlabel('f, Hz');% ������� ��� � �������
    ylim([-0.5 1.5])
    grid on;

    subplot(2,1,2);% ����� ������� ���� ��� ����������
    plot(freq,f_spec,'r','linewidth', 1);% ���������� ����� ������+���
    title('�������');% ������� �������
    xlabel('f, Hz');% ������� ��� � �������
    grid on;
end