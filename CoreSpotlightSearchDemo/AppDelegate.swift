//
//  AppDelegate.swift
//  CoreSpotlightSearchDemo
//
//  Created by Kamal Ahuja on 8/7/16.
//  Copyright © 2016 KamalAhuja. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController : RootViewController?;
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        rootViewController = RootViewController()
        let screenFrame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        window = UIWindow(frame: screenFrame)
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        StateModel.destroyStateIndexing()
        return true
    }
    
    func application(application: UIApplication,
                     continueUserActivity userActivity: NSUserActivity,
                                          restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        
        guard userActivity.activityType == StateModel.CORE_SPOTLIGHT_IDENTIFIER,
            let objectId = userActivity.userInfo?["id"] as? String else {
                return false
        }
        rootViewController?.isRestoringToState = true
        rootViewController?.objectId = objectId
        rootViewController?.restoreToSearchResult()
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


}

