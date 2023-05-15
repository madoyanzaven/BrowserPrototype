//
//  SQLiteHistoryManager.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import SQLite
import Foundation

protocol HistoryListServicing {
    func save(history: HistoryModel)
    func getAllHistory() -> [HistoryModel]
    func deleteHistory()
}

final class SQLiteHistoryManager: HistoryListServicing {
    static let shared = SQLiteHistoryManager()
    var database: Connection?
    let histories = Table(Constants.Foundation.historyKey)
    let url = Expression<String>("url")
    let date = Expression<Date>("date")
    
    private init() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbPath = documentDirectory + "/websites.sqlite"
        do {
            database = try Connection(dbPath)
            createTableIfNeeded()
        } catch {
            fatalError("Error opening database: \(error)")
        }
    }
    
    // Create table
    func createTableIfNeeded() {
        do {
            try database?.run(histories.create(ifNotExists: true) { table in
                table.column(url, primaryKey: true)
                table.column(date)
            })
            print("Successfully created table")
        } catch {
            print(error)
        }
    }
    
    // Get all history
    func getAllHistory() -> [HistoryModel] {
        var histories = [HistoryModel]()
        do {
            for row in try database!.prepare(self.histories) {
                let history = HistoryModel(url: row[url], date: row[date])
                histories.append(history)
            }
        } catch {
            print(error)
        }
        return histories
    }
    
    // Save history
    func save(history: HistoryModel) {
        guard let count = try? database?.scalar(histories.filter(url == history.url).count) else { return }
        count > 0 ? updateHistory(history: history) : insertHistory(history: history)
    }
    
    // Delete hostory
    func deleteHistory() {
        let query = "DELETE FROM \(Constants.Foundation.historyKey)"
        do {
            try database?.run(query)
        } catch {
            print("Error dropping table: \(error)")
        }
    }
    
    // Insert history
    private func insertHistory(history: HistoryModel) {
        do {
            let insert = histories.insert(self.url <- history.url, self.date <- history.date)
            try database?.run(insert)
            print("Successfully inserted history")
        } catch {
            print(error)
        }
    }
    
    // Update history
    private func updateHistory(history: HistoryModel) {
        do {
            let query = histories.filter(url == history.url)
            let update = query.update(date <- history.date)
            try database?.run(update)
            print("Successfully updated history")
        } catch {
            print(error)
        }
    }
}
