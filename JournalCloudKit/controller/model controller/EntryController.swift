//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Pete Parks on 5/11/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // Source of truth for our working data
    var entries: [Entry] = []
    
    // Share instance controller
    static let shared = EntryController()
    
    // short-cut name for the cloudDB
    let privateDB = CKContainer.default().publicCloudDatabase
    
    // MARK: createEntry
    func createEntry(with title: String, entryText: String, completion: @escaping(Result<Entry?, EntryError>) -> Void) {
        let entry = Entry(title: title, entryText: entryText)
        save(with: entry, completion: completion)
    }
    
    // MARK: save
    func save(with entry: Entry, completion: @escaping(Result<Entry?, EntryError>) -> Void) {
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let record = record, let saveEntry = Entry(ckRecord: record) else { return completion(.failure(.couldNotUnwrap))}
            print("Save Entry successfully")
            self.entries.insert(saveEntry, at: 0)
            completion(.success(saveEntry))
        }
    }
    
    
    // MARK: readEntries
    func readEntries(completion: @escaping (Result<[Entry]?, EntryError>) -> Void) {
        let fetchAllEntriesPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryString.recordTypeKey, predicate: fetchAllEntriesPredicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            print("fetch all hypes successfully")
            let entries = records.compactMap({ Entry(ckRecord: $0)})
            self.entries = entries
            completion(.success(entries))
        }
        
    }
}
