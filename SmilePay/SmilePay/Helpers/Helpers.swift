//
//  Helpers.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import SwiftUI

class Helpers {
    
    struct Ressources {
        static let yellowColor = Color(red: 254.0/244.0, green: 226.0/244.0, blue: 1.0/244.0)
        static let blueColor = Color(red: 22.0/244.0, green: 40.0/244.0, blue: 97.0/244.0)
        static let redColor = Color(red: 243.0/244.0, green: 62.0/244.0, blue: 62.0/244.0)
    }
    
    // MARK: This function returns a string presenting the date as dd-MM-yyyy (HH:mm)
    static func getDateString(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd-MM-yyyy (HH:mm)"
        return dateFormatter.string(from: date)
    }
}
