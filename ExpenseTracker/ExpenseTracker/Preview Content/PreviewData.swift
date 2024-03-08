//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/01/2024", institution: "Desjardin", account: "visa", merchant: "Apple", amount: 111, type: "debit", categoryId: 101, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count:10)


