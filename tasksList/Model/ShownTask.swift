//
//  ShownTask.swift
//  tasksList
//
//  Created by Алексей Даневич on 26.05.2022.
//

import Foundation

struct ShownTask: Identifiable {
    var name: String?
    var dateAdded: String?
    var isCompleted: Bool = false
    var id: UUID
    var tag: TaskTag
}
