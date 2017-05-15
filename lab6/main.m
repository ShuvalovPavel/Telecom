% Размер сообщения 
num = 10;

%% Подготовка модулированных и демодулированных объектов
% QPSK
pskmod = modem.pskmod(4); 
pskdemod = modem.pskdemod(4); 
% BPSK
bpskmod = modem.pskmod(2);
bpskdemod = modem.pskdemod(2); 
% OQPSK
oqpskmod = modem.oqpskmod; 
oqpskdemod = modem.oqpskdemod;
% mskmod
mskmod = modem.mskmod('SamplesPerSymbol', 10); 
mskdemod = modem.mskdemod('SamplesPerSymbol', 10); 
% QAM
M = 10;
x = [0 3 4 5 6 7 7 7 4 4 5 6 0 -3 -4 -5 -6 -7 -7 -7 -4 -4 -5 -6 3 4 7 2 3 7 2 6 1 5 4 2 3 1 -3 -4 -7 -2 -3 -7 -2 -6 -1 -5 -4 -2 -3 -1];
y = [5 5 4 3 2 4 6 7 6 7 8 8 5 5 4 3 2 4 6 7 6 7 8 8 -1 -1 -1 -2 -2 -3 -4 -4 -5 -5 -6 -7 -7 -8 -1 -1 -1 -2 -2 -3 -4 -4 -5 -5 -6 -7 -7 -8] ;
z = complex(x,y);
genQAMMod = modem.genqammod('Constellation', z); 
genQAMDemod = modem.genqamdemod('Constellation', z); 
scatterplot(genQAMMod.Constellation)
%% Создание сообщения
msg_4 = randi(4,num,1)-1;
msg_2 = randi(2,num,1)-1;
% msg_10 = randi(10,num,1)-1;
%% Модулирование
mod_psk = modulate(pskmod, msg_4); 
mod_oqpsk = modulate(oqpskmod, msg_4); 
mod_bpsk = modulate(bpskmod, msg_2);
mod_msk = modulate(mskmod, msg_2);

%% Демодулирование
demod_psk = demodulate(pskdemod, mod_psk); 
demod_oqpsk = demodulate(oqpskdemod, mod_oqpsk);
demod_bpsk = demodulate(bpskdemod, mod_bpsk);
demod_msk = demodulate(mskdemod, mod_msk);

%% Построение графиков
scatterplot(pskmod.Constellation); 
scatterplot(bpskmod.Constellation);
scatterplot(oqpskmod.Constellation);
scatterplot(mod_msk);

%% Сигнал с шумом
message = randi(10,100,1)-1;
scatterplot(message);
signal = modulate(genQAMMod,message);
noised = awgn(signal,100);
scatterplot(noised);
dem_message = demodulate(genQAMDemod,noised);
scatterplot(dem_message);
[errors, ratio] = symerr(dem_message,message)