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
}

