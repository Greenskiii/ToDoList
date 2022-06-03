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
            Circle()
                .foregroundColor(task.tag.value)
                .frame(width: 15, height: 15)
                .padding(.horizontal, 3)
            VStack {
                HStack {
                    Text(task.name ?? "No name given")
                    Spacer()
                }
                if let date = task.dateAdded {
                    HStack {
                        Text(date)
                            .font(.system(.caption))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    save(task)
                }
        }
    }
}
