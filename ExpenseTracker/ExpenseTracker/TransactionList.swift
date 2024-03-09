//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-08.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var TransactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack{
            List{
                ForEach(Array(TransactionListVM.groupTransactionsByMonth()), id:\.key){
                    month, transactions in
                    Section{
                        ForEach(transactions){
                            transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        NavigationView {
            TransactionList()
                .environmentObject(transactionListVM)
        }
    }
}
