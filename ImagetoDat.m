function FINISH = ImagetoDat(A,Type)
    if strcmp(Type,'BPSK')
        [tmp,Marker] = GenBPSKDat(A);
        Data_name = 'BPSK_tx.dat';
        save('Marker.mat','Marker');
    elseif strcmp(Type,'OFDM')
        tmp = GenOFDMDat(A,16,0); %16 Training Signals, does not generate data within line
        Data_name = 'OFDM_tx.dat';
    end
    
    Y = fopen(Data_name, 'wb');
    fwrite(Y, tmp/2, 'float32');
    fclose(Y);
    FINISH=1;
end