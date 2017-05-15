clear all;
clc;
% ���������
MESSAGE_LENGTH = 4;
CODE_LENGTH = 7;
message = [0 1 1 1] % ��������� �� �������� ����������� ������
%% ����� ��������
% �����������/�������������
fprintf('Hamming encoding with encode/decode');
code = encode(message, CODE_LENGTH, MESSAGE_LENGTH, 'hamming/binary')
dec = decode(code, CODE_LENGTH, MESSAGE_LENGTH, 'hamming/binary')
% �������
fprintf('Hamming encoding with matrices');
[h, g, n, k] = hammgen(CODE_LENGTH-MESSAGE_LENGTH);
code = rem(message*g, ones(1,n).*2)
random_bit_num = 1; % ��������� ������������ ������
code(random_bit_num) = not(code(random_bit_num)) % ���������� ������
syndrome = rem(code*h', ones(1,n-k).*2)

err_place = bi2de(syndrome);
if err_place ~= 0 % �����������
    fprintf('Error in %i bit', err_place);
    code(err_place) = not(code(err_place))
end
decode_message = [code(4), code(5), code(6), code(7)]

% ������� � ������������ ������
fprintf('Hamming with xors');
code = ham_code(message)
[decode, syndrome] = ham_decode(code)

% ����������� ���
fprintf('Cycle code');
pol = cyclpoly(CODE_LENGTH, MESSAGE_LENGTH);
[h_cycle, g_cycle] = cyclgen(CODE_LENGTH, pol);
codecycle = message*g_cycle;
codecycle = rem(codecycle, ones(1,CODE_LENGTH).*2)
decode_message = [code(4), code(5), code(6), code(7)]
syndrome = rem(codecycle*h_cycle', ones(1,CODE_LENGTH-MESSAGE_LENGTH).*2)

% ���
fprintf('BCH code');
code_bch = comm.BCHEncoder(CODE_LENGTH,MESSAGE_LENGTH);
dec_bch = comm.BCHDecoder(CODE_LENGTH,MESSAGE_LENGTH);
temp = message';
code = step(code_bch, temp(:))'
decode = step(dec_bch, code')'

% ���-�������
fprintf('RS code');
code_rs = comm.RSEncoder(CODE_LENGTH,MESSAGE_LENGTH);
dec_rs = comm.RSDecoder(CODE_LENGTH,MESSAGE_LENGTH);
temp = message';
code = step(code_rs, temp(:))'
decode = step(dec_rs, code')'
