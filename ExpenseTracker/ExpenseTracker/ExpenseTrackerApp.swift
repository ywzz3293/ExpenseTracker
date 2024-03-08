//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
