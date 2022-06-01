//
//  AllTransactionsView.swift
//  SmilePay
//
//  Created by Salmen Nouir on 31/05/2022.
//

import SwiftUI

struct AllTransactionsView<ViewModel>: View where ViewModel: AllTransactionsViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showingOptions = false
    
    var body: some View {
        ZStack {
            VStack {
                
                
                Button("Trier") {
                    showingOptions = true
                }
                .foregroundColor(Helpers.Ressources.redColor)
                .confirmationDialog("Trier par :", isPresented: $showingOptions, titleVisibility: .visible) {
                    Button("Date") {
                        viewModel.sortTransaction(.date)
                    }
                    Button("Montant") {
                        viewModel.sortTransaction(.amount)
                    }
                }
                
                
                List {
                    ForEach(viewModel.transactions, id: \.self) { transaction in
                        if transaction == viewModel.transactions.last && !viewModel.didLoadAllData && !viewModel.isLoading {
                            TransactionView(viewModel: TransactionViewModel(transaction))
                                .onAppear {
                                    viewModel.fetchData()
                                }
                        } else {
                            TransactionView(viewModel: TransactionViewModel(transaction))
                        }
                    }
                }
                
                
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .tint(Helpers.Ressources.redColor)
                    .frame(alignment: .center)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllTransactionsView(viewModel: AllTransactionsViewModel(DefaultTransactionsRepository()))
    }
}
