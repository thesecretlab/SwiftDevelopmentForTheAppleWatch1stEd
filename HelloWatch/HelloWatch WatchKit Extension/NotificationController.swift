//
//  NotificationController.swift
//  HelloWatch WatchKit Extension
//
//  Created by Jon Manning on 9/03/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    // BEGIN notification_handlers
    override func didReceiveLocalNotification(
        localNotification: UILocalNotification, withCompletion
            completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // The iOS app received a local notification; set up our interface
        
        // When done, call completionHandler and pass .Custom.
        completionHandler(.Custom)
    }
    
    override func didReceiveRemoteNotification(
        remoteNotification: [NSObject : AnyObject], withCompletion
            completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // The iOS app received a local notification; set up our interface
        
        // When done, call completionHandler and pass .Custom.
        completionHandler(.Custom)
    }
    // END notification_handlers
    
}
