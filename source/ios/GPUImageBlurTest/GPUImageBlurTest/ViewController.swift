//
//  ViewController.swift
//  GPUImageBlurTest
//
//  Created by EunchulJeon on 2015. 11. 16..
//  Copyright © 2015년 EunchulJeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickOnReset(sender: AnyObject) {
        imageView.image = UIImage.init(named: "test.jpg")
    }
    
    @IBAction func clickOnBlurUsingCIFilter(sender: AnyObject) {
        NSLog("Start to blur");
        
        let inputImage = UIImage.init(named: "test.jpg")
        
        let ciContext = CIContext(options: nil)
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        
        if let filter = blurFilter{
            filter.setValue(CIImage(image: inputImage!), forKey: "inputImage")
            filter.setValue(10, forKey: "inputRadius")
            
            let outputImageData = filter.valueForKey("outputImage") as! CIImage!
            let outputImageRef: CGImage = ciContext.createCGImage(outputImageData, fromRect: outputImageData.extent)
            
            let outputImage = UIImage(CGImage: outputImageRef)
            imageView.image = outputImage
        }
                
        NSLog("Finish to blur");
    }

    @IBAction func clickOnBlurUsingGPUImage(sender: AnyObject) {
        NSLog("Start to blur");

        let inputImage = UIImage.init(named: "test.jpg")
        
        let blurFilter = GPUImageGaussianBlurFilter()
        blurFilter.blurRadiusInPixels = 10
//        let blurFilter = GPUImageAmatorkaFilter()
        
        let outputImage = blurFilter.imageByFilteringImage(inputImage)
        imageView.image = outputImage
        
        NSLog("Finish to blur");
    }
    
    @IBAction func clickOnGray(sender: AnyObject) {
        NSLog("Click On Gray");
        let inputImage = UIImage.init(named: "test.jpg")
        
        let blurFilter = GPUImageGrayscaleFilter()
        let outputImage = blurFilter.imageByFilteringImage(inputImage)
        imageView.image = outputImage
    }
    
    @IBAction func clickOnHarrisCorner(sender: AnyObject){
        NSLog("Click On Harris Corner");

        let harrisCorner = GPUImageHarrisCornerDetectionFilter()
        harrisCorner.threshold = 0.4
        harrisCorner.sensitivity = 4.0
        
        let inputImage = UIImage.init(named: "test.jpg")
        let gpuImageInput = GPUImagePicture.init(image: inputImage)
        gpuImageInput.addTarget(harrisCorner)
        
        harrisCorner.cornersDetectedBlock = {
            (cornerArray:UnsafeMutablePointer<GLfloat>, cornersDetected:UInt, frameTime:CMTime) in

            let crosshairGenerator = GPUImageCrosshairGenerator.init()
            crosshairGenerator.crosshairWidth = 20.0
            crosshairGenerator.setCrosshairColorRed(1.0, green: 0.0, blue: 0.0)
            crosshairGenerator.forceProcessingAtSize(gpuImageInput.outputImageSize())
            
            let blendFilter = GPUImageAlphaBlendFilter.init()
            blendFilter.forceProcessingAtSize(gpuImageInput.outputImageSize())
            gpuImageInput.addTarget(blendFilter)
            crosshairGenerator.addTarget(blendFilter)
            blendFilter.useNextFrameForImageCapture()
            
            NSLog("Number of corners: \(cornersDetected)");
            
            crosshairGenerator.renderCrosshairsFromArray(cornerArray, count: cornersDetected, frameTime: frameTime)
            
            dispatch_async(dispatch_get_main_queue(), {

                let crosshairResult = blendFilter.imageFromCurrentFramebuffer()
                if crosshairResult != nil{
                    self.imageView.image = crosshairResult
                }
            });
        }
        
        gpuImageInput.processImage()
    }

    @IBAction func clickOnFASTCorner(sender: AnyObject){
        NSLog("Click On FAST Corner");
        
//        let FASTCorner = GPUImageFASTCornerDetectionFilter.init()
//        
//        let inputImage = UIImage.init(named: "test.jpg")
//        let gpuImageInput = GPUImagePicture.init(image: inputImage)
//        gpuImageInput.addTarget(FASTCorner)
//        
//        FASTCorner.cornersDetectedBlock = {
//            (cornerArray:UnsafeMutablePointer<GLfloat>, cornersDetected:UInt, frameTime:CMTime) in
//            
//            let crosshairGenerator = GPUImageCrosshairGenerator.init()
//            crosshairGenerator.crosshairWidth = 20.0
//            crosshairGenerator.setCrosshairColorRed(1.0, green: 0.0, blue: 0.0)
//            crosshairGenerator.forceProcessingAtSize(gpuImageInput.outputImageSize())
//            
//            let blendFilter = GPUImageAlphaBlendFilter.init()
//            blendFilter.forceProcessingAtSize(gpuImageInput.outputImageSize())
//            gpuImageInput.addTarget(blendFilter)
//            crosshairGenerator.addTarget(blendFilter)
//            blendFilter.useNextFrameForImageCapture()
//            
//            NSLog("Number of corners: \(cornersDetected)");
//            
//            crosshairGenerator.renderCrosshairsFromArray(cornerArray, count: cornersDetected, frameTime: frameTime)
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                
//                let crosshairResult = blendFilter.imageFromCurrentFramebuffer()
//                if crosshairResult != nil{
//                    self.imageView.image = crosshairResult
//                }
//            });
//        }
//        
//        gpuImageInput.processImage()
    }

}

