//
//  Transaction.swift
//  SmilePay
//
//  Created by Salmen Nouir on 31/05/2022.
//

import Foundation

enum TransactionMode: String {
    case vad = "VAD"
    case normal = ""
}

enum TransactionType: String {
    case debit = "débit"
    case credit = "crédit"
}

struct Transaction: Codable {
    let id, datetime,
        amount, type,
        mode, commentaire: String?
    
    func getMode() -> TransactionMode {
        guard let modeString = mode else {
            return .normal
        }
        return TransactionMode(rawValue: modeString) ?? .normal
    }
    
    func getType() -> TransactionType? {
        guard let typeString = type else {
            return nil
        }
        return TransactionType(rawValue: typeString)
    }
    
    func getDate() -> Date? {
        guard let date = datetime else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: date)
    }
}
