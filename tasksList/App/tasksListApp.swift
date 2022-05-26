//
//  tasksListApp.swift
//  tasksList
//
//  Created by Алексей Даневич on 09.05.2022.
//

import SwiftUI

@main
struct tasksListApp: App {
    let context = CoreDataController.shared.container.viewContext

    var body: some Scene {
        WindowGroup {
            TasksListView(viewModel: ViewModel(context: context))
        }
    }
}
