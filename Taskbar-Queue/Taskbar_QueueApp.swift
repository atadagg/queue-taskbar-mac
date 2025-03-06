//
//  Taskbar_QueueApp.swift
//  Taskbar-Queue
//
//  Created by Ata Tan Dagidir on 6.03.2025.
//

import SwiftUI

@main
struct Taskbar_QueueApp: App {
    @StateObject private var taskManager = TaskManager()
    
    var body: some Scene {
        MenuBarExtra("Task Queue", systemImage: "list.bullet") {
            ContentView()
                .environmentObject(taskManager)
        }
        .menuBarExtraStyle(.window)
    }
}
