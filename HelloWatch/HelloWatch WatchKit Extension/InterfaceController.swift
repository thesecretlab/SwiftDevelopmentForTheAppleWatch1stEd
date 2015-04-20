//
//  InterfaceController.swift
//  HelloWatch WatchKit Extension
//
//  Created by Jon Manning on 9/03/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import WatchKit
import Foundation

class MyRow : NSObject {
    @IBOutlet weak var label: WKInterfaceLabel!
}

class InterfaceController: WKInterfaceController {

    // BEGIN glance_handle_activity
    override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
        // We've just been launched, and WatchKit is telling
        // us about the reason why we were launched.
        
        // The userInfo dict contains the data that was 
        // provided to updateUserActivity.
        println("Launched from user-activity (aka glance): \(userInfo)")
    }
    // END glance_handle_activity
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        // BEGIN container_url
        let containerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.SwiftDevForAppleWatch")
        
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
        
    }

    @IBOutlet weak var label: WKInterfaceLabel!
    
    @IBOutlet weak var myTable: WKInterfaceTable!
    
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
        WKInterfaceController.reloadRootControllersWithNames(["mainScreen", "additionalScreen"], contexts: nil)
        // END reload_pages

    }
    
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
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
