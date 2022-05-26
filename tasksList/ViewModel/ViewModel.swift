//
//  ViewModel.swift
//  tasksList
//
//  Created by Алексей Даневич on 10.05.2022.
//

import SwiftUI
import CoreData

class ViewModel: NSObject, ObservableObject {
    @Published var taskName = ""
    @Published var tasks: [ShownTask] = []
    var coreDataManager: CoreDataManager
    
    init(context: NSManagedObjectContext) {
        coreDataManager = CoreDataManager(context: context)
        super.init()
        self.tasks = coreDataManager.getTasks()
    }
    
    func addTask() {
        coreDataManager.addTask(taskName)
        taskName = ""
        self.tasks = coreDataManager.getTasks()

    }
    
    func deleteTasks(at offsets: IndexSet) {
        for offset in offsets {
            let task = tasks[offset]
            coreDataManager.deleteTasks(task)
        }
        self.tasks = coreDataManager.getTasks()
    }
    
    func save(_ task: ShownTask) {
        coreDataManager.completeTask(task)
        self.tasks = coreDataManager.getTasks()
    }
    

}


