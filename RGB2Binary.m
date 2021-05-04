function BinaryImage = RGB2Binary(Img,threshold)
    Img_gray = rgb2gray(Img);
    thresh = ThresholdBinary(threshold,Img_gray);
    BinaryImage = Img_gray > thresh;
    figure;
    imshow(BinaryImage)
end