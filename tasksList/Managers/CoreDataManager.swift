//
//  CoreDataManager.swift
//  tasksList
//
//  Created by Алексей Даневич on 09.05.2022.
//

import SwiftUI
import CoreData

class CoreDataManager {
    var context: NSManagedObjectContext
    private var fetchedResultsController: NSFetchedResultsController<Task>
    let dateFormatter = DateFormatter()
    
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: Task.all,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
    }
    
    func getTasks() -> [ShownTask] {
        do {
            var shownTasks: [ShownTask] = []
            try? fetchedResultsController.performFetch()
            guard let tasks = fetchedResultsController.fetchedObjects else {
                return []
            }
            for task in tasks {
                if let id = task.id,
                   let tag = task.tag,
                   let date = task.dateAdded {
                    shownTasks.append(
                        ShownTask(name: task.name,
                                  dateAdded: dateFormatter.string(from: date),
                                  isCompleted: task.isComplete,
                                  id: id,
                                  tag: TaskTag(rawValue: tag) ?? .red)
                    )
                }
            }
            return shownTasks
        }
    }
    
    func addTask(_ name: String, tag: TaskTag) {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = name
        newTask.dateAdded = Date()
        newTask.tag = tag.rawValue
        try? context.save()
        
    }
    
    func completeTask(_ task: ShownTask) {
        guard let task = convertTask(task).first else { return }
        task.isComplete.toggle()
        try? context.save()
    }
    
    func deleteTasks(_ task: ShownTask) {
        guard let task = convertTask(task).first else { return }
        context.delete(task)
        try? context.save()
    }
    
    func convertTask(_ task: ShownTask) -> [Task] {
        let fetchRequest = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", task.id as NSUUID)
        let objects = try? context.fetch(fetchRequest)
        var tasks: [Task] = []
        for object in objects ?? [] {
            tasks.append(object)
        }
        
        return tasks
    }
}


