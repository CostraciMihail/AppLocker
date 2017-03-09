//
//  LockManager.swift
//  AppLocker
//
//  Created by winify on 3/9/17.
//  Copyright © 2017 C.Mihail. All rights reserved.
//

import Foundation
import Cocoa

class LockManagerClass {
    
    static let shareInstance = LockManagerClass()
    
    ///This prevents others from using the default '()' initializer for this class.
    private init() {
        
        self.startScanning()
    
    }
    
    
    private func startScanning() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            let scanTimer = Timer.scheduledTimer(timeInterval: 0.2,
                                                 target: self,
                                                 selector: #selector(self.findProcess),
                                                 userInfo: nil,
                                                 repeats: true)
            
            scanTimer.fire()
        }
    }
    
    
    @objc private func findProcess() {
        
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
    
    
    
}
