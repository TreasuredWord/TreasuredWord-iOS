//
//  MemoryVerse.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import Foundation

class MemoryVerse {
    var verseReference: String

    init(verseReference: String) {
        self.verseReference = verseReference
    }

    func getText() -> String {
        var value = "For God so loved the world that He gave His only begotten Son, that whoever believes in Him shall not perish but have eternal life"
        return value
    }
}