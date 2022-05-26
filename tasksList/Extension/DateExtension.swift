//
//  DateExtension.swift
//  tasksList
//
//  Created by Алексей Даневич on 10.05.2022.
//

import Foundation

extension Date {
    func convert() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        return dateFormatter.string(from: self)
    }
}
