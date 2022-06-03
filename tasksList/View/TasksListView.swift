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
                .padding(.horizontal)
                Button {
                    viewModel.addTask()
                } label: {
                    Text("Add Task")
                }
                Circle()
                    .frame(width: 20, height: 20)
                    .padding(1)
//                    .foregroundColor(Color("red"))
                    .foregroundColor(viewModel.taskColor.value)
                    .contextMenu {
                        ForEach(TaskTag.allCases) { tag in
                            Button {
                                viewModel.taskColor = tag
                            } label: {
                                Text(tag.rawValue)
                                
                                    
                            }
                        }
                    }
                    .padding()
            }
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
