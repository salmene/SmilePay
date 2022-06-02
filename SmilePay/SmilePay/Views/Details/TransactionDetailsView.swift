//
//  TransactionDetailsView.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import SwiftUI

struct TransactionDetailsView<ViewModel>: View where ViewModel: TransactionDetailsViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showingOptions = false
    
    var body: some View {
        VStack {
            Text(viewModel.amount)
                .font(Font.largeTitle)
                .foregroundColor(viewModel.type == .credit ?
                                 Helpers.Ressources.blueColor : Helpers.Ressources.redColor)
                .padding()
            
            Text(viewModel.date)
                .foregroundColor(.gray)
                .font(Font.body)
            
            Text(viewModel.mode)
                .font(Font.title3)
                .foregroundColor(Helpers.Ressources.yellowColor)
            
            Text(viewModel.comment)
                .multilineTextAlignment(.leading)
                .font(Font.body)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Détails")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingOptions = true
                }) {
                    Label("delete", systemImage: "trash")
                }
                .foregroundColor(Helpers.Ressources.redColor)
                .confirmationDialog("Êtes-vous sûr de vouloir supprimer cette transaction ?", isPresented: $showingOptions, titleVisibility: .visible) {
                    Button("Oui") {
                        if let transactionId = viewModel.transaction.id {
                            viewModel.deleteAction?(transactionId)
                        }
                    }
                }
            }
        }
    }
}

