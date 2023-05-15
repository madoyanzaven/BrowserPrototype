//
//  HistoryModel.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation

struct HistoryModel {
    let url: String
    let date: Date
    
    var urlTitle: String {
        return "\(url)"
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
