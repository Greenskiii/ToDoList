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
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchedResultsController = NSFetchedResultsController(fetchRequest: Task.all,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
    }
    
    func getTasks() -> [ShownTask] {
        do {
            var shownTasks: [ShownTask] = []
            try fetchedResultsController.performFetch()
            guard let tasks = fetchedResultsController.fetchedObjects else {
                return []
            }
            for task in tasks {
                shownTasks.append(ShownTask(name: task.name,
                                            dateAdded: task.dateAdded,
                                            isCompleted: task.isComplete,
                                            id: task.id))
            }
            return shownTasks
        }
        catch {
            print(error)
        }
        return []
    }
    
    func addTask(_ name: String) {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.isComplete = false
        newTask.name = name
        newTask.dateAdded = Date()
        do {
            try context.save()
        } catch {
            print(error)
        }
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
        guard let id = task.id else { return [] }
        let fetchRequest = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", id as NSUUID)
//        fetchRequest.includesPropertyValues = false
        let objects = try? context.fetch(fetchRequest)
        var tasks: [Task] = []
        for object in objects ?? [] {
            tasks.append(object)
        }
        
        return tasks
    }
}


