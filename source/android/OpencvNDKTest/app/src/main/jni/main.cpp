//
// Created by EunchulJeon on 2015. 10. 29..
//

#include "com_eunchuljeon_opencvndktest_MainActivity.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <stdio.h>

using namespace std;
using namespace cv;

JNIEXPORT jstring JNICALL Java_com_eunchuljeon_opencvndktest_MainActivity_getStringFromNative
(JNIEnv *env, jobject){
        return env->NewStringUTF("hello jni !");
}

int toGray(Mat img, Mat& gray)
{
        cvtColor(img, gray, CV_RGBA2GRAY); // Assuming RGBA input

        if (gray.rows == img.rows && gray.cols == img.cols)
        {
                return (1);
        }
        return(0);
}

JNIEXPORT jint JNICALL Java_com_eunchuljeon_opencvndktest_MainActivity_getGrayImages
        (JNIEnv *env, jobject object, jlong addrRgba, jlong addrGray){

        Mat& mRgb = *(Mat*)addrRgba;
        Mat& mGray = *(Mat*)addrGray;

        int conv;
        jint retVal;

        conv = toGray(mRgb, mGray);
        retVal = (jint)conv;

        return retVal;

//        // use the Array list
//        jclass ArrayList_class       = env->FindClass( "java/util/ArrayList" );
//
////        // to conver jobject to jstring
//        jmethodID mToArray              = env->GetMethodID( ArrayList_class, "toArray", "()[Ljava/lang/Object;");
//
//        jobjectArray array = (jobjectArray)env->CallObjectMethod(sourceImages, mToArray);
//        cv::Mat mat = (cv::Mat)(env->GetObjectArrayElement(array, 0));
//
////        Mat* grayTargetImage;
////        cvCvtColor(mat, mat, CV_RGB2GRAY);
//
//        jint rows = mat.rows;
//
//
//
////        jsize arrSize = env->GetArrayLength(array);
//        char buf[64]; // assumed large enough to cope with result
//        sprintf(buf, "%d", rows);  // error checking omitted
//        return env->NewStringUTF(buf);
//
////        return sourceImages;
}