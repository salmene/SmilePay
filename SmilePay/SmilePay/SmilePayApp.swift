//
//  SmilePayApp.swift
//  SmilePay
//
//  Created by Salmen Nouir on 31/05/2022.
//

import SwiftUI

@main
struct SmilePayApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                AllTransactionsView(viewModel: AllTransactionsViewModel(DefaultTransactionsRepository()))
                    .tabItem {
                        Label("Transactions", systemImage: "arrow.up.arrow.down.circle")
                    }
                
                RecapView(viewModel: RecapViewModel(DefaultTransactionsRepository()))
                    .tabItem {
                        Label("Récapitulatif", systemImage: "dollarsign.circle")
                    }
            }
            
        }
    }
}
