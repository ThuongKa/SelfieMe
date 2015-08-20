//
//  AppDelegate.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/28/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginDelegate, SWRevealViewControllerDelegate {

    var window: UIWindow?

    ///
    var isFirstLogin: Bool = false
    
    ///
    var storyboard: UIStoryboard!

    ///
    var loginVC: LoginVC!
    
    
    /**
    
    */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UIApplication.sharedApplication().statusBarHidden = true
        // 1. Root view is login view
        // 2. If 1st login, after logging in successful the root view is 1st login view
        // 3. Then HomeVC and LeftMenuVC is root
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginVC = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        loginVC.delegate = self
        window?.rootViewController = loginVC
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Perform loggin in 
    
    func doLoginWithResult(result: Bool) {
        if result {
            if isFirstLogin {
                
            } else {
                let rearVC = storyboard.instantiateViewControllerWithIdentifier("LefMenuVC") as! LefMenuVC
                let frontVC = storyboard.instantiateViewControllerWithIdentifier("HomeVC") as! HomeVC
                let rearNav = UINavigationController(rootViewController: rearVC)
                let frontNav = UINavigationController(rootViewController: frontVC)
                let mainRevealController = SWRevealViewController(rearViewController: rearNav, frontViewController: frontNav)
                mainRevealController.frontViewShadowRadius = 1
                
                UIView.transitionFromView(loginVC.view, toView: mainRevealController.view, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve) { finished in
                    if finished {
                        self.window?.rootViewController = mainRevealController
                        self.loginVC = nil
                    }
                }
            }
            
        } else {
            
        }
    }
    
    
    // Login Delegate
    
    func didLoggingWitResult(result: Bool) {
        doLoginWithResult(result)
    }

}

