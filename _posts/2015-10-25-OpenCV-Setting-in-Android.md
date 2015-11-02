---
layout: post
title: OpenCV Setting in Android
date: 2015-10-25 12:00:00
summary: This post introduce how to setting OpenCV in Android studio.
categoris: IOS OpenCV
---

When we follow the tutorial or sample, I think most important thing is version of library because It is little bit different with each versions. And android development environment is easily changed. So this post will be contain wrong information as time goes by.

**You can download all this source in my [Github](https://github.com/jsharp83/jsharp83.github.io/tree/master/source/android/OpencvNDKTest)**

## Prerequisite
If you want to use OpenCV library in Android, You should download and install following things.

* Android Studio,[Download Link](https://developer.android.com/sdk/index.html), My version is 1.4
* NDK, [Download Link](https://developer.android.com/ndk/downloads/index.html), In my case, I use Mac OS X 64bit.
* OpenCV, [Download Link](http://opencv.org/downloads.html), My version is 3.0

## Make a project
* Application name : OpencvNDKTest
* Target Android Device : Phone and Tablet
* Minimum SDK : API16, Android 4.1(Jelly Bean)
* Activity Type and Name : Blank Activity, MainActivity
![sc1.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc1.png)
![sc2.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc2.png)
![sc3.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc3.png)
![sc4.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc4.png)

## NDK Setting
1. Load library and declare Native function in MainActivity.java
![sc5.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc5.png)

2. Rebuild project and make stub code using javah. It makes jni folder and stub code like following screenshot.
![sc6.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc6.png)
![sc7.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc7.png)
**If you don't have a javah in Android Tools tab, see this [link](http://hujiaweibujidao.github.io/blog/2014/10/22/android-ndk-and-opencv-development-with-android-studio/) and read Section 2.4**

3. Make .cpp file in jni folder. And make c++ code.
{% highlight cpp %}
#include "com_eunchuljeon_opencvndktest_MainActivity.h"
JNIEXPORT jstring JNICALL Java_com_eunchuljeon_opencvndktest_MainActivity_getStringFromNative(JNIEnv *env, jobject){
return env->NewStringUTF("hello jni !");
}
{% endhighlight %}

4. Make Android.mk and Application.mk in jni folder. LOCAL_MODULE need to same with System.loadLibrary("OpenCVNDKTest"); in MainActivity.java, LOCAL_SRC_FILE need to same with your cpp file.
  * Android.mk
  {% highlight bash %}
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE    := OpenCVNDKTest
LOCAL_SRC_FILES := main.cpp
LOCAL_LDLIBS := -llog
include $(BUILD_SHARED_LIBRARY)
  {% endhighlight %}
  *	Application.mk
  {% highlight bash %}
    APP_ABI=all
  {% endhighlight %}

5. You should change the gradle setting for using NDK.
  * Add _android.useDeprecatedNdk=true_ in PROJECT_HOME/gradle.properties
  ![sc8.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc8.png)
  * Set NDK Path _ndk.dir_ in PROJECT_HOME/local.properties
  ![sc9.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc9.png)
  * change build.gradle like following. If you have more information about this, see this [link](http://hujiaweibujidao.github.io/blog/2014/10/22/android-ndk-and-opencv-development-with-android-studio/)
{% highlight bash %}
apply plugin: 'com.android.application'

android {
compileSdkVersion 23
buildToolsVersion "23.0.1"

defaultConfig {
applicationId "com.eunchuljeon.opencvndktest"
minSdkVersion 16
targetSdkVersion 23
versionCode 1
versionName "1.0"

ndk{
moduleName "OpenCVNDKTest"
}
}
....
{% endhighlight %}

6. change content_main.xml and MainActivity,java.
{% highlight xml %}
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
xmlns:tools="http://schemas.android.com/tools"
xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent"
android:layout_height="match_parent" android:paddingLeft="@dimen/activity_horizontal_margin"
android:paddingRight="@dimen/activity_horizontal_margin"
android:paddingTop="@dimen/activity_vertical_margin"
android:paddingBottom="@dimen/activity_vertical_margin"
app:layout_behavior="@string/appbar_scrolling_view_behavior"
tools:showIn="@layout/activity_main" tools:context=".MainActivity">

<TextView android:id="@+id/textView" android:text="Hello World!" android:layout_width="wrap_content"
android:layout_height="wrap_content" />
</RelativeLayout>
{% endhighlight %}

{% highlight java %}
package com.eunchuljeon.opencvndktest;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
static {
System.loadLibrary("hello-jni");
}

public native String getStringFromNative();

@Override
protected void onCreate(Bundle savedInstanceState) {
super.onCreate(savedInstanceState);
setContentView(R.layout.activity_main);
.....
TextView view = (TextView) findViewById(R.id.textView);
view.setText(getStringFromNative());
}
.....	
{% endhighlight %}

7. If you see 'hello-jni' string on your simulator, it is end of NDK setting.
![sc10.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc10.png)

## OpenCV Setting
Following part, this [link](http://hujiaweibujidao.github.io/blog/2014/10/22/android-ndk-and-opencv-development-with-android-studio/) is very helpful for me.
1. Change the Android.mk in the jni folder. You should set the opencvroot path.
{% highlight bash %}

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

#opencv
OPENCVROOT:= 
OPENCV_CAMERA_MODULES:=off
OPENCV_INSTALL_MODULES:=on
OPENCV_LIB_TYPE:=SHARED
include ${OPENCVROOT}/sdk/native/jni/OpenCV.mk
LOCAL_MODULE    := OpenCVNDKTest
LOCAL_SRC_FILES := main.cpp
LOCAL_LDLIBS := -llog
include $(BUILD_SHARED_LIBRARY)

{% endhighlight %}

2. Add ndk-build tool and build.
{% highlight %}
NDK_PROJECT_PATH=$ModuleFileDir$/build/intermediates/ndk NDK_LIBS_OUT=$ModuleFileDir$/src/main/jniLibs NDK_APPLICATION_MK=$ModuleFileDir$/src/main/jni/Application.mk APP_BUILD_SCRIPT=$ModuleFileDir$/src/main/jni/Android.mk V=1
{% endhighlight %}
![sc11.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc11.png)

3. Change content_main.xml to show image and button like following image.
![sc12.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc12.png)

4. Change the MainActivity.java to use OpenCV
{% highlight java %}
public class MainActivity extends AppCompatActivity {

static{
if (!OpenCVLoader.initDebug()) {
// Handle initialization error
} else {
System.loadLibrary("OpenCVNDKTest");
}
}

.....

public void makeGrayImage(View view){
System.out.println("Make gray image using OpenCV");

Bitmap image = BitmapFactory.decodeResource(getResources(),R.drawable.test);
Mat imageMat = new Mat( image.getHeight(), image.getWidth(), CvType.CV_8U, new Scalar(4));
Utils.bitmapToMat(image, imageMat);
cvtColor(imageMat, imageMat, COLOR_RGBA2GRAY);
Utils.matToBitmap(imageMat, image);
ImageView imageView = (ImageView) findViewById(R.id.imageView1);
imageView.setImageBitmap(image);
}

{% endhighlight %}

5. You can get gray image using OpenCV library like following screenshot.
![sc13.png](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_25/sc13.png)
 
## Reference
* [http://stackoverflow.com/questions/17767557/how-to-use-opencv-in-android-studio-using-gradle-build-tool/22427267#22427267](http://stackoverflow.com/questions/17767557/how-to-use-opencv-in-android-studio-using-gradle-build-tool/22427267#22427267)  
* [https://www.davidlab.net/ko/tech/using-the-android-ndk-with-android-studio-part1/](https://www.davidlab.net/ko/tech/using-the-android-ndk-with-android-studio-part1/)
* [http://hujiaweibujidao.github.io/blog/2014/10/22/android-ndk-and-opencv-development-with-android-studio/](http://hujiaweibujidao.github.io/blog/2014/10/22/android-ndk-and-opencv-development-with-android-studio/)
* [http://i5on9i.blogspot.kr/2015/02/android-studio-ndk-hello-world.html](http://i5on9i.blogspot.kr/2015/02/android-studio-ndk-hello-world.htm)
* [http://roadinbook.blogspot.kr/2012/01/ndk-applicationmk-androidmk.html](http://roadinbook.blogspot.kr/2012/01/ndk-applicationmk-androidmk.html)
* [http://docs.opencv.org/2.4/doc/tutorials/introduction/android_binary_package/dev_with_OCV_on_Android.html#application-development-with-static-initialization](http://docs.opencv.org/2.4/doc/tutorials/introduction/android_binary_package/dev_with_OCV_on_Android.html#application-development-with-static-initialization)