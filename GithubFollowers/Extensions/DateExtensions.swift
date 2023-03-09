//
//  DateExtensions.swift
//  GithubFollowers
//
//  Created by Sergio Gomes on 09/03/2023.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
