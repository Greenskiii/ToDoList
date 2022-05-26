//
//  tasksListApp.swift
//  tasksList
//
//  Created by Алексей Даневич on 09.05.2022.
//

import SwiftUI

@main
struct tasksListApp: App {

    var body: some Scene {
        WindowGroup {
            let context = CoreDataController.shared.container.viewContext
            
            TasksListView(viewModel: ViewModel(context: context))
                .environment(\.managedObjectContext, context)
        }
    }
}
