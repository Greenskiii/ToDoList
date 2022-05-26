//
//  TaskExtension.swift
//  tasksList
//
//  Created by Алексей Даневич on 10.05.2022.
//

import Foundation
import CoreData
 
extension Task {
    static var all: NSFetchRequest<Task> {
        let request = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \Task.isComplete,
            ascending: true)]
        return request
    }
}
