function [tmp,Marker] = GenBPSKDat(Data)
    Data = transpose(Data);
    Data(Data==0) = -1; %Convert 0 to -1
    
    %Randomly generates marker to help sync data
    range = [-1 1]; % List of wanted values: 
    Rand_Mark = randi(2,100,1); 
    Marker = transpose(range(Rand_Mark)); % Creates Training Data
    
    Tx_data = [Marker;Data];
    Symbol_period = 20;
    pulse = ones(Symbol_period, 1);
    x = zeros(Symbol_period*length(Tx_data),1);
    x(1:Symbol_period:end) = Tx_data;
    x_tx = conv(pulse, x);
    x_tx = [zeros(100000, 1); x_tx;zeros(100000, 1)];
    
    tmp = zeros(length(x_tx)*2, 1); 
    tmp(1:2:end) = 1;
    tmp(2:2:end) = 2;
end