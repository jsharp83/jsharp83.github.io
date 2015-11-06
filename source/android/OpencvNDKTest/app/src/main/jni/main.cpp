//
// Created by EunchulJeon on 2015. 10. 29..
//

#include "com_eunchuljeon_opencvndktest_MainActivity.h"
#include <opencv2/core/core.hpp>

JNIEXPORT jstring JNICALL Java_com_eunchuljeon_opencvndktest_MainActivity_getStringFromNative
(JNIEnv *env, jobject){
        return env->NewStringUTF("hello jni !");
}

JNIEXPORT jstring JNICALL Java_com_eunchuljeon_opencvndktest_MainActivity_getGrayImages
        (JNIEnv *env, jobject object, jobject sourceImages){

        // use the Array list
        jclass ArrayList_class       = env->FindClass( "java/util/ArrayList" );

//        // to conver jobject to jstring
//        jmethodID caster = env->GetMethodID(ArrayList_class, "toString", "()Ljava/lang/String;");
//
//        // get two methods
//        jmethodID Get_method            = env->GetMethodID( ArrayList_class, "get", "(I)Ljava/lang/Object" );
//        jmethodID Size_method           = env->GetMethodID( ArrayList_class, "size", "()I" );
        jmethodID mToArray              = env->GetMethodID( ArrayList_class, "toArray", "()[Ljava/lang/Object;");

        jobjectArray array = (jobjectArray)env->CallObjectMethod(sourceImages, mToArray);

        jsize arrSize = env->GetArrayLength(array);
        char buf[64]; // assumed large enough to cope with result
        sprintf(buf, "%d", arrSize);  // error checking omitted

        return env->NewStringUTF(buf);
}