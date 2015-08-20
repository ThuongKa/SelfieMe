//
//  CaptureImageVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 8/10/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

enum AVCamSetupResult {
    case AVCamSetupResultSuccess
    case AVCamSetupResultCameraNotAuthorized
    case AVCamSetupResultSessionConfigurationFailed
}

/// Capture image
class CaptureImageVC: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    var sessionQueue: dispatch_queue_t!
    
    var session: AVCaptureSession!
    
    var videoDeviceInput: AVCaptureDeviceInput!
    
    var stillImageOutput: AVCaptureStillImageOutput!
    
    var setupResult: AVCamSetupResult!
    
    var backgroundRecordingID: UIBackgroundTaskIdentifier!
    
    @IBOutlet weak var previewView: PreviewLayer!
    
    @IBOutlet weak var usedCameraButton: UIButton!
    
    @IBOutlet weak var timerButton: UIButton!
    
    @IBOutlet weak var plashButton: UIButton!
    
    @IBOutlet weak var latestImage: UIImageView!
    
    @IBOutlet weak var captureButton: UIButton!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        
        let imageGesture = UITapGestureRecognizer(target: self, action: "onClickLatestImageView")
        imageGesture.numberOfTapsRequired = 1
        latestImage.addGestureRecognizer(imageGesture)
        
        
        //
        session = AVCaptureSession()
        self.previewView.session = session
        let videoLayer = AVCaptureVideoPreviewLayer(session: session)
        videoLayer.frame = CGRectMake(0, 0, previewView.frame.size.width, previewView.frame.size.height)
        self.previewView.layer.addSublayer(videoLayer)
        self.sessionQueue = dispatch_queue_create( "session queue", DISPATCH_QUEUE_SERIAL )
        
        
        switch AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) {
        case AVAuthorizationStatus.Authorized:
            return
        case AVAuthorizationStatus.NotDetermined:
            dispatch_suspend(sessionQueue)
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted) -> Void in
                if !granted {
                    self.setupResult = .AVCamSetupResultCameraNotAuthorized

                }
                dispatch_resume( self.sessionQueue )
            })
        default:
            self.setupResult = .AVCamSetupResultCameraNotAuthorized
        }
        
        dispatch_async(sessionQueue) { () -> Void in
            if self.setupResult != .AVCamSetupResultSuccess {
                return
            }
            self.backgroundRecordingID = UIBackgroundTaskInvalid
            
            let videoDevice = self.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)
            var videoDeviceInput: AVCaptureDeviceInput
            do {
                try
                videoDeviceInput = AVCaptureDeviceInput(device: videoDevice)
                self.session.beginConfiguration()
                if self.session.canAddInput(videoDeviceInput) {
                    self.session.addInput(videoDeviceInput)
                    self.videoDeviceInput = videoDeviceInput
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let statusBarOrientation = UIApplication.sharedApplication().statusBarOrientation
                        var initVideoOrientation = AVCaptureVideoOrientation.Portrait
                        if statusBarOrientation != UIInterfaceOrientation.Unknown {
                            initVideoOrientation =  statusBarOrientation as!AVCaptureVideoOrientation
                        }
                        let previewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
                        previewLayer.connection.videoOrientation = initVideoOrientation
                    })
                }
                
                let stillImageOutput = AVCaptureStillImageOutput()
                if self.session.canAddOutput(stillImageOutput) {
                    stillImageOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                    self.session.addOutput(stillImageOutput)
                    self.stillImageOutput = stillImageOutput
                }
                else {
                    NSLog("Could not add still image output to the session" );
                    self.setupResult = .AVCamSetupResultSessionConfigurationFailed
                }
                
                self.session.commitConfiguration()
            } catch {
                
            }
        }
    }
    
    // MARK: -Capture file output delegate
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        let currentBackgroundRecordingID = self.backgroundRecordingID;
        let cleanup: dispatch_block_t = {
            do {
                try NSFileManager.defaultManager().removeItemAtURL(outputFileURL)
                if currentBackgroundRecordingID != UIBackgroundTaskInvalid {
                    UIApplication.sharedApplication().endBackgroundTask(currentBackgroundRecordingID)
                }
            } catch {
                
            }
        }

        if (error.userInfo[AVErrorRecordingSuccessfullyFinishedKey]?.boolValue != nil) {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                if status == .Authorized {
                    PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
                        if #available(iOS 9.0, *) {
                            let options = PHAssetResourceCreationOptions()
                            options.shouldMoveFile = true
                            let changeRequest = PHAssetCreationRequest.creationRequestForAsset()
                            changeRequest.addResourceWithType(PHAssetResourceType.Video, fileURL: outputFileURL, options: options)
                        } else {
                            PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(outputFileURL)
                        }
                        
                        }, completionHandler: { (success, error) -> Void in
                            cleanup()
                    })
                } else {
                    cleanup()
                }
            })
        } else {
            cleanup()
        }
    }
    
    // MARK: -Device Configuration

    func focusWithMode(focusMode: AVCaptureFocusMode, exposeWithMode exposureMode: AVCaptureExposureMode, atDevicePoint point: CGPoint, monitorSubjectAreaChange: Bool) {
        dispatch_async(sessionQueue) { () -> Void in
            let device = self.videoDeviceInput.device
            do {
                try device.lockForConfiguration()
                if device.isFocusModeSupported(focusMode) && device.focusPointOfInterestSupported {
                    device.focusPointOfInterest = point
                    device.focusMode = focusMode
                }
                if device.isExposureModeSupported(exposureMode) && device.exposurePointOfInterestSupported {
                    device.exposurePointOfInterest = point
                    device.exposureMode = exposureMode
                }
                device.subjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                device.unlockForConfiguration()
            } catch {
                print("Could not lock device configuration: \(error)")
            }
        }
    }

    func setFlashMode(flashMode: AVCaptureFlashMode, forDevice device: AVCaptureDevice) {
        if device.hasFlash && device.isFlashModeSupported(flashMode) {
            do {
                try device.lockForConfiguration()
                device.flashMode = flashMode
                device.unlockForConfiguration()
            } catch {
                print("Could not lock device configuration: \(error)")
            }
        }
    }
    
    func deviceWithMediaType(mediaType: String, preferringPosition position: AVCaptureDevicePosition) -> AVCaptureDevice {
        let devices = AVCaptureDevice.devicesWithMediaType(mediaType) as! [AVCaptureDevice]
        var captureDevice = devices.first
        for device in devices {
            if device.position == position {
                captureDevice = device
            }
        }
        return captureDevice!
    }

    /**
    Tap on latest image view
    */
    
    func onClickLatestImageView() {
        print("Latest image view")
    }
    
    @IBAction func tapToFocusAndExposure(sender: AnyObject) {
        let layer = self.previewView.layer as! AVCaptureVideoPreviewLayer
        let gestureRecognizer = sender as! UITapGestureRecognizer
        let devicePoint = layer.captureDevicePointOfInterestForPoint(gestureRecognizer.locationInView(gestureRecognizer.view))
        focusWithMode(AVCaptureFocusMode.AutoFocus, exposeWithMode: AVCaptureExposureMode.AutoExpose, atDevicePoint: devicePoint, monitorSubjectAreaChange: true)
    }
    
    @IBAction func onClickBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onClickTimerButton(sender: AnyObject) {
    }
    
    @IBAction func onClickUsedCamera(sender: AnyObject) {
    }
    
    @IBAction func onClickPlashButton(sender: AnyObject) {
    }
    @IBAction func onClickCaptureButton(sender: AnyObject) {
        
        dispatch_async(sessionQueue) { () -> Void in
            let connection = self.stillImageOutput.connectionWithMediaType(AVMediaTypeVideo)
            let previewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
            connection.videoOrientation = previewLayer.connection.videoOrientation
            self.setFlashMode(.Auto, forDevice: self.videoDeviceInput.device)
            self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(connection, completionHandler: { (imageDataSampleBuffer, error ) -> Void in
                if (imageDataSampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                        if status == PHAuthorizationStatus.Authorized {
                            PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
                                if #available(iOS 9.0, *) {
                                    PHAssetCreationRequest.creationRequestForAsset().addResourceWithType(PHAssetResourceType.Photo, data: imageData, options: nil)
                                } else {
                                    // Fallback on earlier versions
                                    let image = UIImage(data: imageData)
                                    UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil);
                                }
                                }, completionHandler: { (success, error) -> Void in
                                    if !success {
                                        print("Error while storing image")
                                    }
                            })
                        }
                    })
                } else {
                    print("Could not capture image")
                }
            })
        }
    }
    
    
}
