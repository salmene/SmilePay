//
//  RecapViewModel.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import Foundation

protocol RecapViewModelProtocol: ObservableObject {
    var debit: String { get }
    var credit: String { get }
    var total: String { get }
    var isLoading: Bool { get }
    func RefreshData()
}

class RecapViewModel: RecapViewModelProtocol {
    
    @Published var debit: String = ""
    @Published var credit: String = ""
    @Published var total: String = ""
    @Published var isLoading: Bool = false
    
    private let repository: TransactionsRepositoryProtocol
    
    init(_ repository: TransactionsRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: This function loads data and count the debit and credit then sets the strings to be presented
    func RefreshData() {
        isLoading = true
        repository.getTransactions(page: -1, pageSize: -1) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                switch result {
                case .success(let transactions):
                    var debitSum: Double = 0.0
                    var creditSum: Double = 0.0
                    for trsc in transactions {
                        let value = Double(trsc.amount ?? "") ?? 0.0
                        switch trsc.getType() {
                        case .credit:
                            creditSum += value
                        case .debit:
                            debitSum += value
                        default:
                            break
                        }
                    }
                    self.debit = String(format: "%.2f", debitSum)
                    self.credit = String(format: "%.2f", creditSum)
                    self.total = String(format: "%.2f", creditSum - debitSum)
                case .failure(_):
                    break
                }
                self.isLoading = false
            })
            
        }
    }
}
