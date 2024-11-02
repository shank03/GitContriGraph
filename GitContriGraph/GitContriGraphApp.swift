//
//  GitContriGraphApp.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

@main
struct GitContriGraphApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
