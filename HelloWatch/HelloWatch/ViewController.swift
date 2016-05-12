//
//  ViewController.swift
//  HelloWatch
//
//  Created by Jon Manning on 9/03/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

import WatchConnectivity

extension ViewController : WCSessionDelegate {
    
    
    // BEGIN wcsession_receive_message
    func session(session: WCSession,
         didReceiveMessage message: [String : AnyObject]) {
        print("Phone received message: \(message)")
    }
    // END wcsession_receive_message
    
    // BEGIN wcsession_receive_message_needs_reply
    func session(session: WCSession,
         didReceiveMessage message: [String : AnyObject],
           replyHandler: ([String : AnyObject]) -> Void) {
        
        print("Phone received message that needs a reply: \(message)")
        
        let replyMessage = [
            "reply":"hello!"
        ]
        
        replyHandler(replyMessage)
        
    }
    // END wcsession_receive_message_needs_reply
    
    
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let session = WCSession.defaultSession()
        
        session.delegate = self
        
        session.activateSession()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

