---
layout: post
title: OpenCV Setting in IOS
date: 2015-10-24 12:00:00
summary : This post introduce how to setting OpenCV in IOS.
categories: IOS OpenCV
---

1. Download OpenCV Framework.
 * [http://opencv.org/downloads.html](http://opencv.org/downloads.html)

2. Drag and drop the framework into your IOS Project.
 * You should check "Copy items if needed"

3. Add prefix header file
 * If you don't have a prefix file in your preject, You should add it. See reference 2.
        {% highlight bash %}
          #ifdef __cplusplus
          #import <opencv2/opencv.hpp>
          #endif
        {% endhighlight %}

4. Set prefix header in your project.
      * Precompile prefix header should be "YES"
      * Set prefix header path like following.
![setting_prefix](https://raw.githubusercontent.com/jsharp83/jsharp83.github.io/master/images/2015_10_24/screenshot_setting_opencv_01.png)

5. Change your source file name .m to .mm
      * OpenCV framework is based on C++. Should change the .m file if it include C++ framework.

### Reference
1.[http://docs.opencv.org/master/d7/d88/tutorial_hello.html#gsc.tab=0](http://docs.opencv.org/master/d7/d88/tutorial_hello.html#gsc.tab=0)  
2.[http://stackoverflow.com/questions/24158648/why-isnt-projectname-prefix-pch-created-automatically-in-xcode-6](http://stackoverflow.com/questions/24158648/why-isnt-projectname-prefix-pch-created-automatically-in-xcode-6)  
