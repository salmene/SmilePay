//
//  RecapView.swift
//  SmilePay
//
//  Created by Salmen Nouir on 02/06/2022.
//

import SwiftUI

struct RecapView<ViewModel>: View where ViewModel: RecapViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                VStack {
                    HStack {
                        VStack {
                            Text("Débit :")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text(viewModel.debit)
                                .font(.largeTitle)
                                .foregroundColor(Helpers.Ressources.redColor)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        Divider()
                        VStack {
                            Text("Crédit :")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text(viewModel.credit)
                                .font(.largeTitle)
                                .foregroundColor(Helpers.Ressources.blueColor)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    Divider()
                    Text("Total: \(viewModel.total)")
                        .foregroundColor(Helpers.Ressources.blueColor)
                        .font(.largeTitle)
                        .padding()
                }
                .padding()
                .frame(width: geo.size.width, height: geo.size.height / 2, alignment: .center)
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(Helpers.Ressources.redColor)
                        .frame(alignment: .center)
                }
            }
            .onAppear {
                viewModel.RefreshData()
            }
        }
        
    }
}
