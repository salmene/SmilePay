//
//  TransactionView.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import SwiftUI

struct TransactionView<ViewModel>: View where ViewModel: TransactionViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.amount)
                    .foregroundColor(viewModel.transaction.getType() == .debit ?
                                     Helpers.Ressources.redColor : Helpers.Ressources.blueColor)
                    .font(Font.title3)
                
                Text(viewModel.date)
                    .foregroundColor(.gray)
                    .font(Font.caption2)
            }
            .frame(minHeight: 80, alignment: .leading)
            Spacer()
            Text(viewModel.mode)
                .font(Font.title3)
                .foregroundColor(Helpers.Ressources.yellowColor)
            
            
        }
    }
}
