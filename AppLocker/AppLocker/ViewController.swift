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
        
    }
    
    @IBAction func showAppListPressed(_ sender: Any) {

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            let scanTimer = Timer.scheduledTimer(timeInterval: 0.2,
                                                 target: self,
                                                 selector: #selector(self.getAllProcess),
                                                 userInfo: nil,
                                                 repeats: true)
        
            scanTimer.fire()
        }
        
    }
    
    
    func getAllProcess() {
        
        let ws = NSWorkspace.shared()
        let apps = ws.runningApplications
        
        for currentApp in apps {
            
            if currentApp.activationPolicy == .regular {
                print(currentApp.localizedName!)
            }
            
            if(currentApp.localizedName == "Sublime Text" && currentApp.activationPolicy == .regular) {
                
                print("\nFOUND:\(currentApp.localizedName) PID: \(currentApp.processIdentifier)")
                killpg(currentApp.processIdentifier, SIGKILL)
            }
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

