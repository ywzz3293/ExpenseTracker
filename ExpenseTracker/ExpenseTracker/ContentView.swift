//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM:TransactionListViewModel
    //var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    let data = transactionListVM.accumulateTransaction()
                    
                    if !data.isEmpty
                    {
                        let totalExpenses = data.map { $0.1 }
                        LineView(data: totalExpenses)
                            .frame(height: 300)
                    }

                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .background(Color.myBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.myIcon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
}
