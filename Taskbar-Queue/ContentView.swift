//
//  ContentView.swift
//  Taskbar-Queue
//
//  Created by Ata Tan Dagidir on 6.03.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @State private var newTaskTitle = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Task Queue")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                Spacer()
                HStack(spacing: 8) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            taskManager.resetTasks()
                        }
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 16))
                            .foregroundColor(.red.opacity(0.8))
                            .padding(8)
                            .background(Color.red.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        NSApplication.shared.terminate(nil)
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 16))
                            .foregroundColor(.gray.opacity(0.8))
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(NSColor.windowBackgroundColor))
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.2)),
                alignment: .bottom
            )
            
            // Task List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(taskManager.tasks) { task in
                        TaskRow(task: task, taskManager: taskManager)
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.9).combined(with: .opacity),
                                removal: .scale(scale: 0.9).combined(with: .opacity)
                            ))
                    }
                }
            }
            
            // Input Area
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 12) {
                    TextField("Add a new task...", text: $newTaskTitle)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 16))
                        .padding(12)
                        .background(Color(NSColor.controlBackgroundColor))
                        .cornerRadius(10)
                        .onSubmit {
                            if !newTaskTitle.isEmpty {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    taskManager.addTask(newTaskTitle)
                                    newTaskTitle = ""
                                }
                            }
                        }
                    
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                taskManager.addTask(newTaskTitle)
                                newTaskTitle = ""
                            }
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .background(Color(NSColor.windowBackgroundColor))
        }
        .frame(minWidth: 300, minHeight: 200)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

struct TaskRow: View {
    let task: Task
    let taskManager: TaskManager
    @State private var isHovered = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                taskManager.toggleTask(task)
            }
        }) {
            HStack {
                Text(task.title)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(isHovered ? Color(NSColor.controlBackgroundColor) : Color.clear)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskManager())
}
