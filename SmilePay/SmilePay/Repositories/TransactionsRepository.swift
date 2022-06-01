//
//  TransactionsRepository.swift
//  SmilePay
//
//  Created by Salmen Nouir on 31/05/2022.
//

import Foundation

protocol TransactionsRepositoryProtocol {
    func getTransactions(page: Int, pageSize: Int, _ result: @escaping (Swift.Result<[Transaction], Error>) -> Void)
}

final class DefaultTransactionsRepository: TransactionsRepositoryProtocol {
    
    func getTransactions(page: Int, pageSize: Int = 5, _ result: @escaping (Swift.Result<[Transaction], Error>) -> Void) {
        
        struct ResponseData: Decodable {
            var transactions: [Transaction]
        }
        
        if let url = Bundle.main.url(forResource: "exemple_transactions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                let transactions = getDataFor(page, pageSize: pageSize, transactions: jsonData.transactions)
                result(.success(transactions))
            } catch {
                result(.failure(error))
            }
        }
    }
    
    private func getDataFor(_ page: Int, pageSize: Int, transactions: [Transaction]) -> [Transaction] {
        let startIndex = page * pageSize
        var lastIndex = (pageSize * (page + 1)) - 1
        if startIndex >= transactions.count {
            return []
        } else if lastIndex >= transactions.count {
            lastIndex = transactions.count - 1
        }
        var inRangeTransactions = [Transaction]()
        for i in startIndex...lastIndex {
            inRangeTransactions.append(transactions[i])
        }
        return inRangeTransactions
    }
}
