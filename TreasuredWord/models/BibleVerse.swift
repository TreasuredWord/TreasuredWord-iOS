//
//  BibleVerse.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import Foundation

let pcnBibleVerse = "BibleVerse"

class BibleVerse {
    var reference: String
//    var book: String
//    var chapter: Int
//    var verse: Int

    init(reference: String) {
        self.reference = reference
    }

    func getText() -> String {
        var value = "For God so loved the world that He gave His only begotten Son, that whoever believes in Him shall not perish but have eternal life"
        return value
    }
}