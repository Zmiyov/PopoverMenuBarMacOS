//
//  PopoverMenuBarMacOSApp.swift
//  PopoverMenuBarMacOS
//
//  Created by Vladimir Pisarenko on 24.05.2024.
//

import SwiftUI

@main
struct PopoverMenuBarMacOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//Building Menu Button andPopover menu

class AppDelegate: NSObject, NSApplicationDelegate {
    
    //Status bar Item
    var statusItem: NSStatusItem?
    //Popover
    var popover = NSPopover()
     
    func applicationDidFinishLaunching(_ notification: Notification) {
        let menuView = MenuView()
        
        popover.behavior = .transient
        popover.animates = true
        //Setting empty view controller
        //And setting view as SwiftUI view
        //with the help of hosting controller
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: menuView )
        
        //Making view as main view
        popover.contentViewController?.view.window?.makeKey()
        
        //Creating status bar button
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        //Check if status Button available
        if let menuButton = statusItem?.button {
            
            menuButton.image = NSImage(systemSymbolName: "icloud.and.arrow.up.fill", accessibilityDescription: nil)
            menuButton.action = #selector(menuButtonToogle)
        }
    }
    
    @objc func menuButtonToogle(sender: AnyObject) {
        //showing popover
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let menuButton = statusItem?.button {
                //top get button location for popover arrow
                self.popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
