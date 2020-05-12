//
//  Journal.swift
//  JournalCloudKit
//
//  Created by Pete Parks on 5/11/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import CloudKit

struct EntryString {
    static let recordTypeKey = "Entry"
    static let titleKey = "title"
    static let entryTextKey = "entryText"
    static let timestampKey = "timestamp"
}

class Entry {
    var timestamp: Date
    var title: String
    var entryText: String
    let ckRecordID: CKRecord.ID
    
    
    init(timestamp: Date = Date(), title: String, entryText: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.timestamp = timestamp
        self.title = title
        self.entryText = entryText
        self.ckRecordID = ckRecordID
    }
}

// MARK: Hype convenience init
extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let timestamp = ckRecord[EntryString.timestampKey] as? Date,
        let title = ckRecord[EntryString.titleKey] as? String,
        let entryText = ckRecord[EntryString.entryTextKey] as? String
            else { return nil }
        self.init(timestamp: timestamp, title: title, entryText: entryText)
    }
}

// MARK: CKRecord convenience init
extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryString.recordTypeKey, recordID: entry.ckRecordID)
        
        self.setValuesForKeys([
            EntryString.entryTextKey : entry.entryText,
            EntryString.titleKey : entry.title,
            EntryString.timestampKey : entry.timestamp
        ])
    }
}
