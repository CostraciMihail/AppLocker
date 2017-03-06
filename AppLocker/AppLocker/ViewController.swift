//
//  ViewController.swift
//  AppLocker
//
//  Created by winify on 3/3/17.
//  Copyright © 2017 C.Mihail. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var titleLabe: NSTextField!
    @IBOutlet var showActiveAppButton: NSView!
    @IBOutlet weak var appListLabel: NSTextFieldCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.appListLabel.stringValue = ""
        
//        let processName = ProcessInfo.processInfo.processName
//        let processIdentifier = ProcessInfo.processInfo.processIdentifier
//        
//        print("processName: \(processName)")
//        print("processIdentifier: \(processIdentifier) \n")

        
        
        for window in NSApplication.shared().windows {
            
            print(window.title)
            print(window.miniwindowTitle)
            print(window.titleVisibility)
        }
        
        
        
    }
    
    @IBAction func showAppListPressed(_ sender: Any) {

        self.startScanning()

    }

    
    func findProcess(appsArray: [NSRunningApplication]) {
        
        for currentApp in appsArray {
            
            
            
            let str = NSString(format: "\n Running Apps: %@ \n", self.appListLabel.stringValue + currentApp.localizedName!) as String
            
            print(currentApp.localizedName!)
            self.appListLabel.stringValue = str
//            
//            if(currentApp.activationPolicy == .regular) {
//                
//         
//            }
            
            if (currentApp.localizedName == "Sublime Text") {
                
                print("\n f\(currentApp.localizedName)")
                currentApp.forceTerminate()
            }
            
        }
        
    }
    
    
    func startScanning() {
        
        while true {
            
            print("\nscanning...")
            
            let ws = NSWorkspace.shared()
            let apps = ws.runningApplications
            
            self.findProcess(appsArray: apps)
        }
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

