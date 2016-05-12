//
//  InterfaceController.swift
//  HelloWatch WatchKit Extension
//
//  Created by Jon Manning on 9/03/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import WatchKit
import Foundation

// BEGIN import_watchconnectivity
import WatchConnectivity
// END import_watchconnectivity

// BEGIN wcsession_delegate
extension InterfaceController : WCSessionDelegate {
    
    @available(watchOSApplicationExtension 2.2, *)
    func session(session: WCSession, activationDidCompleteWithState
        activationState: WCSessionActivationState, error: NSError?) {
        
        print("Session activated!")
        // BEGIN wcsession_delegate_update
        updateMessageButton()
        // END wcsession_delegate_update
    }
    
    func sessionDidDeactivate(session: WCSession) {
        print("Session deactivated!")
        // BEGIN wcsession_delegate_update
        updateMessageButton()
        // END wcsession_delegate_update
        
    }
    
    func sessionDidBecomeInactive(session: WCSession) {
        print("Session became inactive!")
        // BEGIN wcsession_delegate_update
        updateMessageButton()
        // END wcsession_delegate_update
    }
    
    // BEGIN wcsession_delegate_update
    func updateMessageButton() {
        
        
        if #available(watchOSApplicationExtension 2.2, *) {
            
            let session = WCSession.defaultSession()
            
            if session.activationState == .Activated && session.reachable {
                self.sendMessageButton.setEnabled(true)
            } else {
                self.sendMessageButton.setEnabled(false)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    // END wcsession_delegate_update
    
    
    func sessionReachabilityDidChange(session: WCSession) {
        print("Reachability changed to \(session.reachable)")
        
        // BEGIN wcsession_delegate_update
        updateMessageButton()
        // END wcsession_delegate_update
    }
    
    
    
}
// END wcsession_delegate

class MyRow : NSObject {
    @IBOutlet weak var label: WKInterfaceLabel!
}

class InterfaceController: WKInterfaceController {

    
    @IBOutlet var sendMessageButton: WKInterfaceButton!
    
    @IBAction func sendMessageToPhone() {
        
        // BEGIN wcsession_message
        let message = [
            "message":"hi"
        ]
        // END wcsession_message
        
        
        if (false) {
        // BEGIN wcsession_message_send
        WCSession.defaultSession().sendMessage(message,
                                               replyHandler: nil,
                                               errorHandler: { (error) in
                                                
                print("Got an error sending to the phone: \(error)")
        })
        // END wcsession_message_send
        }
        
        // BEGIN wcsession_message_send_reply
        WCSession.defaultSession().sendMessage(message,
                                               replyHandler: { (replyMessage) in
            print("Got a reply from the phone: \(replyMessage)")
        }, errorHandler: { (error) in
            print("Got an error sending to the phone: \(error)")
        })
        // END wcsession_message_send_reply
        
        
    }
    
    // BEGIN glance_handle_activity
    override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
        // We've just been launched, and WatchKit is telling
        // us about the reason why we were launched.
        
        // The userInfo dict contains the data that was 
        // provided to updateUserActivity.
        print("Launched from user-activity (aka glance): \(userInfo)")
    }
    // END glance_handle_activity
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
        // BEGIN wcsession_get
        let session = WCSession.defaultSession()
        // END wcsession_get
        
        // BEGIN wcsession_set_delegate
        session.delegate = self
        // END wcsession_set_delegate
        
        if #available(watchOSApplicationExtension 2.2, *) {
            if session.activationState != .Activated {
                self.sendMessageButton.setEnabled(false)
            }
        }
        
        // BEGIN wcsession_activate
        session.activateSession()
        // END wcsession_activate
        
        // Configure interface objects here.
        
        // BEGIN container_url
        let containerURL = NSFileManager.defaultManager()
            .containerURLForSecurityApplicationGroupIdentifier(
                "group.SwiftDevForAppleWatch")
        
        // containerURL now points to a location where both 
        // your app and your app extension can store a file;
        // for example:
        
        let fileURL = containerURL?.URLByAppendingPathComponent("SharedFile.txt")
        // END container_url
        
        // BEGIN table_example
        // An array of strings to show in the table
        let dataToDisplay = ["Hello", "World", "This", "Is", "A", "Table"]
        
        myTable.setNumberOfRows(dataToDisplay.count, withRowType: "MyRow")
        
        for i in 0 ..< dataToDisplay.count {
            let rowController = myTable.rowControllerAtIndex(i) as? MyRow
            
            rowController?.label.setText(dataToDisplay[i])
        }
        // END table_example
        
        // BEGIN list_content_example
        var listContent : [WKPickerItem] = []
        
        for i in 0...2 {
            let item = WKPickerItem()
            item.title = "Item \(i)"
            listContent.append(item);
        }
        
        self.picker.setItems(listContent)
        // END list_content_example
        
        // BEGIN animated_images_code
        let animatedImage =
            UIImage.animatedImageNamed("Animation",
                                       duration: 1.0)
        
        self.imageView.setImage(animatedImage)
        // END animated_images_code
        
    }

    
    @IBOutlet weak var label: WKInterfaceLabel!
    
    @IBOutlet var imageView: WKInterfaceImage!
    @IBOutlet weak var myTable: WKInterfaceTable!
    
    @IBAction func showAlert() {
        
        // BEGIN show_alert_buttons
        let actions = [
            WKAlertAction(title: "OK", style: WKAlertActionStyle.Default, handler: {
                print("OK button tapped")
            })
        ]
        // END show_alert_buttons
        
        // BEGIN show_alert
        let alertTitle = "Error!"
        let alertMessage = "There was a problem!"
        
        self.presentAlertControllerWithTitle(alertTitle,
                                             message: alertMessage,
                                             preferredStyle: .Alert,
                                             actions: actions)
        // END show_alert
    }
    
    func showNewInterfaceController() {
        
        // BEGIN push_controller
        self.pushControllerWithName("secondScreen", context: nil)
        // END push_controller
        
        self.popToRootController()
    }
    
    func showModalInterfaceController() {
        // BEGIN show_modal
        self.presentControllerWithName("detailScreen", context: nil)
        // END show_modal
    }
    
    func replaceInterfaceControllers() {
        
        // BEGIN reload_pages
        WKInterfaceController.reloadRootControllersWithNames(["mainScreen",
            "additionalScreen"], contexts: nil)
        // END reload_pages

    }
    
    @IBOutlet var picker: WKInterfacePicker!
    
    // BEGIN picker_selected_item
    @IBAction func pickerSelectedItem(value: Int) {
        print ("Picker selected item \(value)")
    }
    // END picker_selected_item
    
    // BEGIN button_tapped
    @IBAction func buttonTapped() {
        // BEGIN set_text
        label.setText("Hi Hello Hi")
        // END set_text
    }
    // END button_tapped
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // BEGIN useractivity_share
        // Define the activity that the user is doing
        let activityType = "au.com.secretlab.SwiftDevForAppleWatch.funActivity"
        
        // Add some additonal information that provides
        // more context
        let activityInfo = [
            "additionalInfoForTheApp": "tennis"
        ]
        
        // Indicate to the system that the user
        // is now doing an activity
        self.updateUserActivity(activityType, userInfo: activityInfo, webpageURL: nil)
        // END useractivity_share
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
