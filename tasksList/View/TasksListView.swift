//
//  TasksListView.swift
//  tasksList
//
//  Created by Алексей Даневич on 09.05.2022.
//

import SwiftUI
import CoreData

struct TasksListView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Write your task",
                          text: $viewModel.taskName)
                .textFieldStyle(.roundedBorder)
                Button {
                    viewModel.addTask()
                } label: {
                    Text("Add Task")
                }
            }
            .padding()
            
            List {
                ForEach(viewModel.tasks) { task in
                    TaskRow(task: task, save: viewModel.save(_:))
                }
                .onDelete(perform: viewModel.deleteTasks)
            }
        }
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataController.shared.container.viewContext

        TasksListView(viewModel: ViewModel(context: context))
    }
}
