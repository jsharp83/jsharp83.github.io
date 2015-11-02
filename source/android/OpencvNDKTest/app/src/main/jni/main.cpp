//
// Created by EunchulJeon on 2015. 10. 29..
//

#include "com_eunchuljeon_opencvndktest_MainActivity.h"
#include <opencv2/core/core.hpp>

JNIEXPORT jstring JNICALL Java_com_eunchuljeon_opencvndktest_MainActivity_getStringFromNative
(JNIEnv *env, jobject){
        return env->NewStringUTF("hello jni !");
}
