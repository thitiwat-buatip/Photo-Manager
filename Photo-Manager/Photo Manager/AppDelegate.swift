//
//  AppDelegate.swift
//  Photo Manager
//
//  Created by Thitiwat Buatip on 12/1/2565 BE.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var openFile: NSMenuItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @IBAction func openFile(_ sender: NSMenuItem) {
        FileManagerModel.share.openFinder()
    }
}

