//
//  TransactionViewModel.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import Foundation

protocol TransactionViewModelProtocol: ObservableObject {
    var amount: String { get }
    var date: String { get }
    var mode: String { get }
    var transaction: Transaction { get }
}

class TransactionViewModel: TransactionViewModelProtocol {
    
    let amount: String
    let date: String
    let mode: String
    let transaction: Transaction
    
    init(_ transaction: Transaction) {
        self.transaction = transaction
        let signString = transaction.getType() == .credit ? "+ " : "- "
        amount = signString + (transaction.amount ?? "0.00")
        date = Helpers.getDateString(transaction.getDate())
        mode = transaction.getMode() == .vad ? "à distance" : ""
    }
    
}
