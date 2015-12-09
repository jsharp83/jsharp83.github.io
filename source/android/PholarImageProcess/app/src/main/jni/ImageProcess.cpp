//
// Created by EunchulJeon on 2015. 12. 8..
//

#include "com_naver_android_pholar_util_pholarimageprocess_PholarImageProcessWrapper.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <android/log.h>

using namespace std;
using namespace cv;

#define  LOG_TAG    "JNI_LOG"
#define  ALOG(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)

JNIEXPORT jdoubleArray JNICALL Java_com_naver_android_pholar_util_pholarimageprocess_PholarImageProcessWrapper_getAvgColor
        (JNIEnv *env, jobject, jlong addrRgba){

    Mat& mRgb = *(Mat*)addrRgba;
    Scalar c = mean(mRgb);

    jdoubleArray output = env->NewDoubleArray(4);
    env->SetDoubleArrayRegion(output,0,4, c.val);

    return output;
}