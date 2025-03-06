import Foundation

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(_ title: String) {
        let task = Task(title: title)
        tasks.append(task)
    }
    
    func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    func removeTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func resetTasks() {
        tasks.removeAll()
    }
} 