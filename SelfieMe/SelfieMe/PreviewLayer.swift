//
//  PreviewLayer.swift
//  SelfieMe
//
//  Created by Thuong Vu on 8/11/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import AVFoundation
import UIKit

class PreviewLayer: UIView {
    
    var session: AVCaptureSession! {
        set {
            let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
            previewLayer.session = session
        }
        
        get {
            let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
            return previewLayer.session
            
        }
    }
    
    override class func layerClass() -> AnyClass {
        return AVCaptureVideoPreviewLayer.classForCoder()
    }
    
}