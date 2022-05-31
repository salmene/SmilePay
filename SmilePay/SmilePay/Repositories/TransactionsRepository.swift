//
//  TransactionsRepository.swift
//  SmilePay
//
//  Created by Salmen Nouir on 31/05/2022.
//

import Foundation

protocol TransactionsRepositoryProtocol {
    func getTransactions(_ result: @escaping (Swift.Result<[Transaction], Error>) -> Void)
}

final class DefaultTransactionsRepository: TransactionsRepositoryProtocol {
    
    func getTransactions(_ result: @escaping (Swift.Result<[Transaction], Error>) -> Void) {
        
        struct ResponseData: Decodable {
            var transactions: [Transaction]
        }
        
        if let url = Bundle.main.url(forResource: "exemple_transactions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                result(.success(jsonData.transactions))
            } catch {
                result(.failure(error))
            }
        }
    }
}
