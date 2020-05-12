//
//  DateExtension.swift
//  JournalCloudKit
//
//  Created by Pete Parks on 5/11/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
