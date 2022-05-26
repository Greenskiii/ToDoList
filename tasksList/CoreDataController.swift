//
//  CoreDataController.swift
//  tasksList
//
//  Created by Oleksii Danevych on 5/26/22.
//

import Foundation
import CoreData

class CoreDataController: ObservableObject {
    
    let container: NSPersistentContainer
    static let shared = CoreDataController()
    
    private init() {
        container = NSPersistentContainer(name: "tasksList")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
