//
//  ViewController.swift
//  AppLocker
//
//  Created by C.Mihail on 3/3/17.
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
        self.startScanning()
        
    }
    
    @IBAction func showAppListPressed(_ sender: Any) {
        
        self.startScanning()
        
    }
    
    func startScanning() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            let scanTimer = Timer.scheduledTimer(timeInterval: 0.2,
                                                 target: self,
                                                 selector: #selector(self.findProcess),
                                                 userInfo: nil,
                                                 repeats: true)
            
            scanTimer.fire()
        }
    }
    
    
    func findProcess() {
        
        let ws = NSWorkspace.shared()
        let apps = ws.runningApplications
        
        for currentApp in apps {
            
            if currentApp.activationPolicy == .regular {
                print(currentApp.localizedName!)
            }
            
            if(currentApp.localizedName == "Sublime Text" && currentApp.activationPolicy == .regular) {
                
                print("\nFOUND:\(currentApp.localizedName) PID: \(currentApp.processIdentifier)")
                kill(currentApp.processIdentifier, SIGKILL)
//                pause()
            }
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

