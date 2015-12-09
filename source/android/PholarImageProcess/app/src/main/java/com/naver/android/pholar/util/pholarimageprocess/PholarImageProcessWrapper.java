package com.naver.android.pholar.util.pholarimageprocess;

import android.graphics.Bitmap;
import android.graphics.Color;
import android.util.Log;

import org.opencv.android.OpenCVLoader;
import org.opencv.android.Utils;
import org.opencv.core.CvType;
import org.opencv.core.Mat;

/**
 * Created by eunchuljeon on 2015. 12. 8..
 */
public class PholarImageProcessWrapper {
    static {
        if (!OpenCVLoader.initDebug()) {
            // Handle initialization error
        } else {
            System.loadLibrary("PholarImageProcess");
        }
    }

    public native double[] getAvgColor(long matAddr);

    public int getAvgColor(Bitmap bitmap){
        Mat mat = new Mat(bitmap.getHeight(), bitmap.getWidth(), CvType.CV_8UC4);
        Utils.bitmapToMat(bitmap, mat);

        double[] result = getAvgColor(mat.getNativeObjAddr());
        Color resultColor = new Color();

        return resultColor.rgb((int)result[0], (int)result[1], (int)result[2]);
    }
}
