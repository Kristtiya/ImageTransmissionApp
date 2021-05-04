function Y = ReadBPSK(Rx_Data)
    % Open the file containing the received samples
    f2 = fopen(Rx_Data, 'rb');
    % read data from the file
    tmp = fread(f2, 'float32');
    % close the file
    fclose(f2);
    % since the USRP stores the data in an interleaved fashion
    % with real followed by imaginary samples 
    % create a vector of half the length of the received values to store the
    % data. Make every other sample the real part and the remaining samples the
    % imaginary part
    %Y = zeros(length(tmp)/2,1);
    
    Y = tmp(1:2:end)+1i*tmp(2:2:end);
    % to visualize, plot the real and imaginary parts separately

    
%     %Sync Data and remove excess information
%     [y1x1,lag1] = xcorr(Y,Marker_Array,'none');
%     [~, Index] = max(abs(y1x1));
%     shift = lag1(Index);
%     % Trim data from xcorr'd lags  ($shift) to length of tx ($tx_len)
%     Trimmed_Y = Y(shift:shift + length_data-1);    % Should be 8192 bits in size
%     figure;
%     stem(Trimmed_Y)

end