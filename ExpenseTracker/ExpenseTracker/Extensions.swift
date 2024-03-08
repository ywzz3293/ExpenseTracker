//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import Foundation
import SwiftUI

extension Color{
    static let myBackground = Color("Background")
    static let myIcon = Color("Icon")
    static let myText = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter{
    static let allNumericCAN:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String{
    func dateParsed()->Date{
        guard let parsedDate = DateFormatter.allNumericCAN.date(from:self) else {return Date()}
        return parsedDate
    }
}
