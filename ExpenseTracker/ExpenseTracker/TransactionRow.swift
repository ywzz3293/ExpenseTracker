//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction:Transaction
    
    var body: some View {
        HStack(spacing:20){
            
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .fill(Color.myIcon.opacity(0.3))
                .frame(width: 44,height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.myIcon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(transaction.dateParsed,format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
            }
            
            Spacer()
            
            Text(transaction.signedAmount, format: .currency(code: "CAD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.myText : .primary)
            
            
        }
        .padding([.top,.bottom],0)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
}
