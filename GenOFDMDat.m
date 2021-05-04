function tmp = GenOFDMDat(Data,N_Training_Block,gen_dat)
%
%
    Data = transpose(Data);
    Data_N = length(Data);
    Block_data_N = Data_N/48;
    full_block = floor(Block_data_N);
    if Block_data_N > full_block
        Filler_Dat_N = 48 - (Data_N - full_block*48); %Known Value
        N_XData = full_block + 1;
    else
        Filler_Dat_N = 0;
        N_XData = Block_data_N;
    end
    
    Bits_per_set = 48;              % Bits per set of data
    n_data = N_XData+N_Training_Block;
    Bits_per_block_Guard = 64;      % Bits per block with guard data and pilot signals
    size_training_data = Bits_per_set*N_Training_Block;       % Size of Training Data - 16 sets of 48 bits: 768 bits
    size_X = Bits_per_set*N_XData;      
    
    %Generate training data and additional filler data if applicable
    range = [-1 1]; % List of wanted values: 
    b = randi(2,size_training_data,1); 
    X_train = transpose(range(b)); % Creates Training Data

    if Filler_Dat_N > 0
        X_Filler = X_train(1:Filler_Dat_N);
        message = [X_train ; Data;X_Filler]; %Combines data with filler data
    else
        message = [X_train ; Data]; %Combines data
    end
    

    % Add Guard Data and Pilot Signals
    Prep_data = zeros(n_data*Bits_per_block_Guard,1);
    Sub_data = zeros(64,1);
    Sub_data = fftshift(Sub_data);
    pre_guard = zeros(6,1);
    post_guard = zeros(5,1);
    location_center=33;
    
    for N = 1:1:n_data
        Data_N = message(1 + Bits_per_set*(N-1):N*Bits_per_set); %Extracts data set n_data - 48 bit
        Sub_data(7:12)=Data_N(1:6); %First set of Data
        Sub_data(13) = 1; %First Pilot Tone
        Sub_data(14:25) = Data_N(7:18);
        Sub_data(26) = 1; %Second Pilot Tone
        Sub_data(27:32) = Data_N(19:24);
        Sub_data(34:39) = Data_N(25:30);
        Sub_data(40) = 1; %Third Pilot Tone
        Sub_data(41:52) = Data_N(31:42);
        Sub_data(53) = 1; %Fourth Pilot Tone
        Sub_data(54:59) = Data_N(43:48);
        Sub_data;
        %Obtain Cyclic Prefix
        Prep_data(1+64*(N-1):64*(N)) = Sub_data; %Append data into the tx_data vector
    end
    % Move Data to the time domain and add cyclic prefixes
    tx_data = zeros(n_data*(80),1); %Empty vector for data to be transmitted

    for x_time = 1:1:n_data
        Data_x_n = Prep_data(1+64*(x_time-1):x_time*64);        % Extracts data set n_data - 64 bits
        Data_X_n = ifft(fftshift(Data_x_n));        % Obtains the ifft of the data: Frequency to Time- 64 bits
        cyclic_prefix = Data_X_n(49:end);           % Obtains the last 16 bits of the data
        Prefix_w_data = [cyclic_prefix ; Data_X_n]; % Concatonate the cyclic prefix to the data set - 80 bits
        tx_data(1+80*(x_time-1):80*(x_time)) = Prefix_w_data;   % Append data into the tx_data vector
    end
    % Add Preamble for Schmidl Cox
    pre = randi([0,1],1,64);        % 64 columns 1 row
    pre(pre == 0) = -1;             % Changes all zeroes to -1
    pre = ifft(fftshift(pre));      % Move to time domain (64 point ifft)
    preamble = [pre,pre,pre];       % 192 columns, 1 row

    preamble = preamble';

    % Save the preamble
    % save("variables3.mat", "preamble", "message", "Prep_data");
    tx_data = [preamble; tx_data];

    tmp = zeros(length(tx_data)*2, 1);

    tmp(1:2:end) = real(tx_data);
    tmp(2:2:end) = imag(tx_data);
    if gen_dat==1
        Y = fopen(Data_name, 'wb');
        fwrite(Y, tmp/2, 'float32');
        fclose(Y);
    end
end