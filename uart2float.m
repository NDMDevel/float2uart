function [f,n] = uart2float(COM)
    warning off
    if ~isempty(instrfind)
        fclose(instrfind);
    end
    f = NaN;
    n = 0;
    
    % config serial port
    s = serial(COM);
    set(s,'BaudRate',115200)
    set(s,'Timeout',1);
    set(s,'InputBufferSize',2^15-1);
    fopen(s);

    input('Enter para comenzar a adquirir...');
    
    byte = zeros(1,4);
    n = 0;
    while 1
        % lee 4 bytes del puerto serie
        for b=1:4
            data = fread(s,1);
            if isempty(data)        % se leyo 'vacio'?
                if b == 1
                    fclose(s);      % si el primer byte (del paquete de 4)
                    return;         % esta vacio, no es problema, solo no hay mas datos
                else
                    % si se leyo vacio y no es el primer byte, implica 
                    % que el paquete de 4 bytes esta trunco y podria
                    % significar que todos los bytes leidos estan
                    % shifteados y por lo tanto todos los floats
                    % obtenidos a partir de ellos son invalidos
                    fprintf('Warning: se recibieron menos de 4 bytes. Los datos de salida podrian estar\ncorruptos por shift en los bytes.\n');
                    fclose(s);
                end
            end
            byte(b) = data;
        end
        f(n+1) = typecast(uint8(byte),'single');
        n = n + 1;        
    end
end