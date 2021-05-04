function BinaryRGB = Img2ThreshRGB(Img_Data)
        %Obtain Image Data
        Red = Img_Data(:,:,1);
        Green = Img_Data(:,:,2);
        Blue = Img_Data(:,:,3);

        Red_Array = RGB4Thresh(Red);
        Green_Array = RGB4Thresh(Green);
        Blue_Array = RGB4Thresh(Blue);

        Img_Data(:,:,1) = Red_Array;
        Img_Data(:,:,2) = Green_Array;
        Img_Data(:,:,3) = Blue_Array;
        BinaryRGB = Img_Data;
        
        figure;
        hold on
        subplot(1,3,1);
        imshow(Red_Array)
        title('Red Binary Array');
        subplot(1,3,2);
        imshow(Green_Array)
        title('Green Binary Array');
        subplot(1,3,3);
        imshow(Blue_Array)
        title('Blue Binary Array');
        hold off
end