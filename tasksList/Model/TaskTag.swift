//
//  TaskTag.swift
//  tasksList
//
//  Created by Алексей Даневич on 03.06.2022.
//

import SwiftUI

enum TaskTag: String, CaseIterable {
    case red = "red"
    case blue = "blue"
    case yellow = "yellow"
    case green = "green"
}

extension TaskTag: Identifiable {
    var id: Self { self }
}

extension TaskTag {
    var value: Color {
        get {
            switch self {
            case .red:
                return .red
            case .blue:
                return .blue
            case .green:
                return .green
            case .yellow:
                return .yellow
            }
        }
    }
}
