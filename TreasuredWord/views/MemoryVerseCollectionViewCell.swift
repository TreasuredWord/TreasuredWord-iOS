//
//  MemoryVerseCollectionViewCell.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class MemoryVerseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var verseLabel: UILabel!

    var verse: String! {
        willSet(newValue) {
            verseLabel.text = newValue
        }

        didSet(oldValue) {
        }
    }
}
