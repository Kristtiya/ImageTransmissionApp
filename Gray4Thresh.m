function Threshold_Array = Gray4Thresh(Array)
        Array(Array<50) = 0;
        Array(Array>=50 & Array<100) = 75;
        Array(Array>=100 & Array<150) = 150;
        Array(Array>=150) = 256;
        Threshold_Array = Array;
end