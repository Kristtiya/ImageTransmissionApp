function Y_Data = Img2Array(Image,Target_Data_Type)
    % Image = Image that user wants to convert to a 1 dimensional array
    % Target_Data_Type = If the resulting data is binary or RGB
    %       - 2Bit:
    %       - 4Bit:
    % Y = 1 Dimensional Array
    %
    
    A = Image';
    Array_Scaled = A(:)';
    if strcmp(Target_Data_Type,'2Bit')
        Y_Data = Array_Scaled > 256; %If value is 256, turn to 1
        Y_Data(Y_Data==0) = -1;
    elseif strcmp(Target_Data_Type,'4Bit')
        Array_Scaled(Array_Scaled==50) = 1;
        Array_Scaled(Array_Scaled==75) = -1;
        Array_Scaled(Array_Scaled==150) = 1i;
        Array_Scaled(Array_Scaled==256) = -1i;
        Y_Data = Array_Scaled;
    end
end