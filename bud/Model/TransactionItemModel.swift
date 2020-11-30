//
//  TransactionItem.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//  The model to define the contents of a cell in the transaction list

import Foundation
import UIKit

struct TransactionItemModel: Hashable {
    var image: UIImage?
    let amount: String?
    let id, //UUID provided from JSON source
        datumDescription,
        category: String
    let date: Date
    let imageUrl: String
    // Hashability conformence using a Unquie Identifier and hash value allows diffableDataSource to track changes
    //let identifier = UUID()
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    static func == (lhs: TransactionItemModel, rhs: TransactionItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
