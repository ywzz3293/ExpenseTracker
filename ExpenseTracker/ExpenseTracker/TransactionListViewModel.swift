//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import Foundation
import Combine
import OrderedCollections

typealias TransactionGroup = OrderedDictionary<String,[Transaction]>
typealias TransactionPrefixSum = [(String,Double)]


final class TransactionListViewModel:ObservableObject{
    @Published var transactions:[Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransctions()
    }
    
    func getTransctions(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json")
        else{
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data,response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink{completion in
                switch completion{
                case.failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case.finished:
                    print("Finished fetching transactions")
                }
            }receiveValue: { [weak self] result in
                self?.transactions = result
                //dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionsByMonth()->TransactionGroup{
        guard !transactions.isEmpty else{return [:]}
        
        let groupedTransactions = TransactionGroup(grouping: transactions){$0.month}
        return groupedTransactions
    }
    
    func accumulateTransaction() -> TransactionPrefixSum{
        guard !transactions.isEmpty else{return []}
        
        let end = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for:end)
        
        var sum:Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        for date in stride(from: dateInterval?.start ?? "01/01/2022".dateParsed(),to: end, by: 60*60*24){
            let dailyExpense = transactions.filter{$0.dateParsed == date && $0.isExpense}
            let dailyTotal = dailyExpense.reduce(0){$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(),sum))
        }
        
        return cumulativeSum
    }
}
