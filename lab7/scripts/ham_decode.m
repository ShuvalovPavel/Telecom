function [ message, syndrome ] = ham_decode( code )
    x1 = xor(xor(xor(code(5), code(1)), code(2)), code(4));
    x2 = xor(xor(xor(code(6), code(1)), code(3)), code(4));
    x3 = xor(xor(xor(code(7), code(2)), code(3)), code(4));

    message = code(1:4);
    syndrome = [x3 x2 x1];
    if bi2de(syndrome, 'left-msb') ~= 0
        message(syndrome) = not(message(syndrome));
    end    
end

