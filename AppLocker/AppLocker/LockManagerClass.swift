//
//  LockManager.swift
//  AppLocker
//
//  Created by C.Mihail on 3/9/17.
//  Copyright © 2017 C.Mihail. All rights reserved.
//

import Foundation
import Cocoa

class LockManagerClass {
    
    static let shareInstance = LockManagerClass()
    private var scanTimer: Timer
    
    ///This prevents others from using the default '()' initializer for this class.
    private init() {
    
            self.scanTimer = Timer()
    }
    
    public func startScanning() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            self.scanTimer = Timer.scheduledTimer(timeInterval: 0.2,
                                                 target: self,
                                                 selector: #selector(self.findProcess),
                                                 userInfo: nil,
                                                 repeats: true)
            
            self.scanTimer.fire()
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
                
                self.stopProcess(withID: currentApp.processIdentifier)
                
                if self.checkEnteredPass(forProcessID: currentApp.processIdentifier) {
                    break
                }
            }
        }
        
    }
    
    
    private func killProcess(withID procID: pid_t) {
        
        kill(procID, SIGKILL)
    }
    
    
    private func stopProcess(withID procID: pid_t) {
        
        kill(procID, SIGSTOP) //SIGSTOP or SIGTSTP
    }
    
    private func resumeProcess(withID procID: pid_t) {
        
        kill(procID, SIGCONT)
    }
 
    private func checkEnteredPass(forProcessID procesID: pid_t) -> Bool {
        
        print("Enter password to continue:")
        let outP = readLine()
        
        if let outP = outP {
            if outP == "123" {
                self.scanTimer.invalidate()
                self.resumeProcess(withID: procesID)
                return true
            }
        }
        
        return false
    }
    
    
    
}
