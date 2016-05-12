//
//  MediaInterfaceController.swift
//  HelloWatch
//
//  Created by Jon Manning on 3/03/2016.
//  Copyright © 2016 Secret Lab. All rights reserved.
//

import WatchKit
import Foundation


class MediaInterfaceController: WKInterfaceController {
    
    var player : WKAudioFilePlayer? = nil
    
    func showTextPicker() {
        
        // BEGIN text_input_controller
        let suggestions = ["Yes", "No", "I guess?", "Huh?"]
        
        self.presentTextInputControllerWithSuggestions(
            suggestions, allowedInputMode: .Plain) { (results : [AnyObject]?) in
                
                guard let theResults = results else {
                    print ("No text provided")
                    return
                }
                
                for result in theResults {
                    print ("Result: \(result)")
                }
        }
        // END text_input_controller
        
    }
    
    @IBAction func playAudio() {
        
        // BEGIN play_audio
        // Get a URL that points at an audio file
        
        guard let audioFileURL = NSBundle.mainBundle().URLForResource("Sound", withExtension: "m4a") else {
            print("Couldn't find the audio!")
            return
        }
        
        let options = [
            WKMediaPlayerControllerOptionsAutoplayKey: true
        ]
        
        self.presentMediaPlayerControllerWithURL(audioFileURL, options: options) { (didPlayToEnd, endTime, error) in
            
            print("Audio player ended; played to end = \(didPlayToEnd), end time = \(endTime), error = \(error)")
            
        }
        // END play_audio
    }
    
    @IBAction func playMovie() {
        
        // BEGIN get_video_url
        guard let videoFileURL = NSBundle.mainBundle()
            .URLForResource("Video", withExtension: "m4v") else {
                
            print("Couldn't find the video!")
            return
        }
        // END get_video_url
        
        
        if (false) {
        // BEGIN play_video
        self.presentMediaPlayerControllerWithURL(videoFileURL, options: nil) {
            (didPlayToEnd, endTime, error) in
            
            print("Video player ended; played to end = \(didPlayToEnd), " +
                "end time = \(endTime), error = \(error)")
            
        }
        // END play_video
        }
        
        // BEGIN play_video_autoplay
        let options = [
            WKMediaPlayerControllerOptionsAutoplayKey: true
        ]
        
        self.presentMediaPlayerControllerWithURL(videoFileURL, options: options) {
            (didPlayToEnd, endTime, error) in
            
            print("Video player ended; played to end = \(didPlayToEnd), " +
                "end time = \(endTime), error = \(error)")
            
        }
        // END play_video_autoplay
        
        
    }
    
    @IBAction func playHaptic() {
        
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Success);
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
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

}
