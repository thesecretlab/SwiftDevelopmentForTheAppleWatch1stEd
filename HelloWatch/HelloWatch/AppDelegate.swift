//
//  AppDelegate.swift
//  HelloWatch
//
//  Created by Jon Manning on 9/03/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // BEGIN notification_action
        let replyAction = UIMutableUserNotificationAction()
        replyAction.identifier = "replyToMessage"
        replyAction.title = "Reply"
        // END notification_action
        
        // BEGIN notification_category
        let messageReceivedCategory = UIMutableUserNotificationCategory()
                messageReceivedCategory.identifier = "messageReceived"
        
        // The Default context is the lock screen.
        messageReceivedCategory.setActions([replyAction],
            forContext: UIUserNotificationActionContext.Default)
        
        // The Minimal context is when the user pulls down on a notification banner.
        messageReceivedCategory.setActions([replyAction],
            forContext: UIUserNotificationActionContext.Minimal)
        // END notification_category
            
        
        // BEGIN notification_settings
        let settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound],
                categories: [messageReceivedCategory])
        // END notification_settings
        
        // BEGIN notification_settings_register
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        // END notification_settings_register

        UIApplication.sharedApplication().registerForRemoteNotifications()
        
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

