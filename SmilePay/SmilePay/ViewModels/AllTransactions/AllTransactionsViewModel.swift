//
//  AllTransactionsViewModel.swift
//  SmilePay
//
//  Created by Salmen Nouir on 31/05/2022.
//

import Foundation


enum SortMode {
    case none
    case date
    case amount
}

protocol AllTransactionsViewModelProtocol: ObservableObject {
    var transactions: [Transaction] { get }
    var isLoading: Bool { get }
    var didLoadAllData: Bool { get }
    func fetchData()
    func sortTransaction( _ by: SortMode)
    func deleteTransaction(_ transactionId: String)
}

final class AllTransactionsViewModel: AllTransactionsViewModelProtocol {
    
    @Published var transactions: [Transaction] = []
    @Published var isLoading: Bool = false
    var didLoadAllData: Bool = false
    
    private let repository: TransactionsRepositoryProtocol
    private var loadedTransaction: [Transaction] = []
    private var page = 0
    private var sortedBy: SortMode = .none
    
    init(_ repository: TransactionsRepositoryProtocol) {
        self.repository = repository
        fetchData()
    }
    
    // MARK: This function loads data then update data to be presented and increment page number
    func fetchData() {
        isLoading = true
        sortTransaction(.none)
        repository.getTransactions(page: page, pageSize: 5) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                switch result {
                case .success(let transactions):
                    self.loadedTransaction.append(contentsOf: transactions)
                    self.sortTransaction(self.sortedBy)
                    if transactions.count < 5 {
                        self.didLoadAllData = true
                    } else {
                        self.didLoadAllData = false
                        self.page += 1
                    }
                    
                case .failure(_):
                    break
                }
                self.isLoading = false
            })
            
        }
    }
    
    // MARK: This function sort data by the given parameter (amout or date)
    func sortTransaction( _ by: SortMode) {
        sortedBy = by
        switch by {
        case .date:
            transactions = loadedTransaction.sorted(by: {
                guard let firstDate = $0.getDate(),
                        let secondDate = $1.getDate() else {
                    return false
                }
                return firstDate > secondDate
            })
        case .amount:
            transactions = loadedTransaction.sorted(by: {
                guard let firstAmount = Double($0.amount ?? ""),
                      let secondAmount = Double($1.amount ?? "") else {
                    return false
                }
                return firstAmount > secondAmount
            })
        case .none:
            transactions = loadedTransaction
        }
    }
    
    // MARK: This function deletes a transaction by its id and refreshes data
    func deleteTransaction(_ transactionId: String) {
        loadedTransaction.removeAll { transaction in
            guard let tranID = transaction.id else {
                return false
            }
            return tranID == transactionId
        }
        
        transactions.removeAll { transaction in
            guard let tranID = transaction.id else {
                return false
            }
            return tranID == transactionId
        }
    }
    
}
