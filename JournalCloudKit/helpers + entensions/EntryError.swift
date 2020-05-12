//
//  EntryError.swift
//  JournalCloudKit
//
//  Created by Pete Parks on 5/11/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
}
