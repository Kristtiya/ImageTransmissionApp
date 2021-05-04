function Error = BitErrorRate(rx_data,tx_data)
    diff = (tx_data - rx_data)./((2*tx_data)); 
    Error = abs(sum(diff)/(length(diff))) *100;
end