//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by weijie shen on 2024-03-07.
//

import Foundation
import SwiftUIFontIcon

struct Transaction: Identifiable, Decodable,Hashable{
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer:Bool
    var isExpense:Bool
    var isEdited:Bool
    
    var icon: FontAwesomeCode{
        if let categary  = Categary.all.first(where: {$0.id == categoryId})
        {
            return categary.icon
        }
        
        return .question
    }
    
    var dateParsed:Date{
        date.dateParsed()
    }
    
    var signedAmount: Double{
        return type == TransactionType.credit.rawValue ? amount: -amount
    }
    
    var month:String {
        dateParsed.formatted(.dateTime.year().month(.wide))
        
    }
}

enum TransactionType: String{
    case debit = "debit"
    case credit = "credit"
}

struct Categary{
    let id: Int
    let name:String
    let icon: FontAwesomeCode
    var mainCategaryId:Int?
}

extension Categary {
    static let autoAndTransportation = Categary(id:1, name: "Auto & Transport", icon:.car_alt)
    static let billsAndUtilities = Categary(id:2, name: "Bills & Utilities", icon:.file_invoice_dollar)
    static let entertainment = Categary(id:3, name: "Entertainment", icon:.film)
    static let feesAndCharges = Categary(id:4, name: "Fees & Charges", icon:.hand_holding_usd)
    static let foodAndDrinking = Categary(id:5, name: "Food & Drining", icon:.hamburger)
    static let home = Categary(id:6, name: "Home", icon:.home)
    static let income = Categary(id:7, name: "Income", icon:.dollar_sign)
    static let shopping = Categary(id:8, name: "Shopping", icon:.shopping_cart)
    static let transfer = Categary(id:9, name: "Transfer", icon:.exchange_alt)
    
    static let publicTransportation = Categary(id:101, name: "Public Transportation", icon:.bus, mainCategaryId: 1)
    static let taxi = Categary(id:102, name: "Taxi", icon:.taxi, mainCategaryId: 1)
    static let mobilePhone = Categary(id:201, name: "Mobile Phone", icon:.mobile_alt, mainCategaryId: 2)
    static let moviesAndDVDs = Categary(id:301, name: "Movies & DVDs", icon:.film, mainCategaryId: 3)
    static let bankFee = Categary(id:401, name: "Bank Fee", icon:.hand_holding_usd, mainCategaryId: 4)
    static let financeCharge = Categary(id:402, name: "Finance Charge", icon:.hand_holding_usd, mainCategaryId: 4)
    static let groceries = Categary(id:501, name: "Groceries", icon:.shopping_basket, mainCategaryId: 5)
    static let restaurants = Categary(id:502, name: "Restaurants", icon:.utensils, mainCategaryId: 5)
    static let rent = Categary(id:601, name: "Rent", icon:.house_user, mainCategaryId: 6)
    static let homeSupplies = Categary(id:602, name: "Home Supplies", icon:.lightbulb, mainCategaryId: 6)
    static let payCheque = Categary(id:701, name: "Pay Cheque", icon:.dollar_sign, mainCategaryId: 7)
    static let software = Categary(id:801, name: "Software", icon:.icons, mainCategaryId: 8)
    static let creditCardPayment = Categary(id:901, name: "Credit Card Payment", icon:.exchange_alt, mainCategaryId: 9)

}

extension Categary{
    static let categaries : [Categary] = [
        .autoAndTransportation,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDrinking,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategaries : [Categary] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .bankFee,
        .financeCharge,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .payCheque,
        .software,
        .creditCardPayment
    ]
    
    static let all:[Categary] = categaries + subCategaries
    
}
