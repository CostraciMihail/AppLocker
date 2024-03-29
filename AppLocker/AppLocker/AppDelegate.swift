//
//  AppDelegate.swift
//  AppLocker
//
//  Created by C.Mihail on 3/3/17.
//  Copyright © 2017 C.Mihail. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem? = nil
    var darkModeOn = false

    func applicationDidFinishLaunching(_ aNotification: Notification) {
      
        //start scanning for process
        let lockManager = LockManagerClass.shareInstance
        lockManager.startScanning()
        
        //add statusItem to Status Bar
        self.statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        self.statusItem?.image = NSImage(named: "locker_img")
        self.statusItem?.target = self
        self.statusItem?.action = #selector(self.statusIconSelected)

        
        let openSettings = NSMenuItem(title: "Settings", action: #selector(self.menueSetttingsSelected), keyEquivalent: "")
        NSApp.mainMenu?.addItem(openSettings)
        //TODO: make menue to be visible
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    func statusIconSelected() {
        
        print("STATUSICONSELECTED")
        
    }
    
    func menueSetttingsSelected() {
        
        print("MENUESETTTINGSSELECTED")
        
    }

}

