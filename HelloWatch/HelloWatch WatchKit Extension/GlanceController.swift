//
//  GlanceController.swift
//  HelloWatch WatchKit Extension
//
//  Created by Jon Manning on 9/03/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    // BEGIN glance_will_activate
    override func willActivate() {
            // The glance is being presented to the user.
            
            // Create a dictionary containing info that the main
            // app can use to display this content
            
            // For example, if you're making a calendar app,
            // each 'event' might have an ID number, which 
            // the main app can use to look up and display full
            // information about that event.
            let info = ["calendarEventID": 99];
            
            // Update the activity so that, if the glance is 
            // tapped, the main application will receive the
            // info dictionary
            self.updateUserActivity("au.com.secretlab." +
                "SwiftDevForAppleWatch.HelloWatch" +
                ".watchkitextension.tapped",
                userInfo: info,
                webpageURL: nil)
            
            super.willActivate()
        }
    // END glance_will_activate

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
