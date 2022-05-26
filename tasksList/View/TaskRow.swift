//
//  TaskRow.swift
//  tasksList
//
//  Created by Алексей Даневич on 09.05.2022.
//

import SwiftUI

struct TaskRow: View {
    var task: ShownTask
    var save: (ShownTask) -> Void
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(task.name ?? "No name given")
                    Spacer()
                }
                if let date = task.dateAdded {
                    HStack {
                        Text(date.convert())
                            .font(.system(.caption))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                }
            }
            Image(systemName: task.isCompleted ?? false ? "checkmark.square" : "square")
                .onTapGesture {
                    save(task)
                }
        }
    }
}
