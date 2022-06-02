//
//  TransactionDetailsViewModel.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import Foundation

protocol TransactionDetailsViewModelProtocol: ObservableObject {
    var amount: String { get }
    var date: String { get }
    var mode: String { get }
    var comment: String { get }
    var type: TransactionType { get }
    var transaction: Transaction { get }
    var deleteAction: ((String)->Void)? { get set }
}

class TransactionDetailsViewModel: TransactionDetailsViewModelProtocol {
    
    let amount: String
    let date: String
    let mode: String
    var comment: String
    var type: TransactionType
    let transaction: Transaction
    var deleteAction: ((String)->Void)?
    
    init(_ transaction: Transaction,
         deleteAction: ((String)->Void)? = nil) {
        self.transaction = transaction
        let signString = transaction.getType() == .credit ? "+ " : "- "
        amount = signString + (transaction.amount ?? "0.00")
        date = Helpers.getDateString(transaction.getDate())
        mode = transaction.getMode() == .vad ? "à distance" : ""
        type = transaction.getType() ?? .credit
        comment = transaction.commentaire ?? ""
        self.deleteAction = deleteAction
    }
    
}
