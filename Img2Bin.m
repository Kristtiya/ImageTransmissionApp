%% Converts Image to Binary
function [bin,Data_type] = Img2Bin(imgname,grayorrgb,ColorType,threshold)
        Img = imread(imgname); %Reads image
        thresh = ThresholdBinary(threshold,Img);
        if grayorrgb==0 %If the image is a binary image
            if ColorType==0 %
                bin = Img > thresh;
                figure;
                Data_type = '2Bit';
            end     
        elseif grayorrgb==1 %If the image is an RGB or Grayscale Image
            if ColorType==0 %User wants to convert image to binary data
                GrayscaleImg = rgb2gray(Img);
                bin = GrayscaleImg > thresh;
                Data_type = '2Bit';
            elseif ColorType==1 %User wants to convert image to grayscale data
                GrayscaleImg = rgb2gray(Img);
                bin = Gray4Thresh(GrayscaleImg);
                imshow(bin);
                Data_type = '4Bit';
            elseif ColorType==2 %User wants image to have color
                bin = Img2ThreshRGB(Img);
                Data_type = '4Bit';
            end   
        end
        figure;
        imshow(bin)

end