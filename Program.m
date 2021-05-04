%% Select and Create .Dat File from Images
prompt_img_select = 'Select image:';
Image = input(prompt_img_select,'s');
RGBorGray = 'Is this image Binary (0) or Grayscale/RGB (1)?:';
ColorType = input(RGBorGray);

%Binary Image
if ColorType ==0
    Prompt_WantedType = 'Binary[2bits] or Grayscale [4bits]: Binary (0) or Grayscale (1)';
    ColorWant = input(Prompt_WantedType);
end

%Grayscale Image
if ColorType ==1
    Prompt_WantedType = 'What image format do you want: Binary(0), Grayscale(1),or RGB(2-if applicable)?';
    ColorWant = input(Prompt_WantedType);
end


prompt_mod_type = 'Select Modulation Type: BPSK , OFDM:';
Mod_type = input(prompt_mod_type,'s');

%Need to implement rgb
[Image_Data,D_type] = Img2Bin(Image,ColorType,ColorWant,.45);
Array_of_Image = Img2Array(Image_Data,D_type);
Y = ImagetoDat(Array_of_Image,Mod_type);

%% Read Rx File and Demodulate
Marker = load('Marker.mat');
recovered = ReadBPSK('BPSK_tx.dat');

