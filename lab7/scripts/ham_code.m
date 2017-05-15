function [ code ] = ham_code( message )
    c1 = xor(xor(message(1), message(2)), message(4));
    c2 = xor(xor(message(1), message(3)), message(4));
    c4 = xor(xor(message(2), message(3)), message(4));
    
    code = [message, c1, c2, c4];
end

