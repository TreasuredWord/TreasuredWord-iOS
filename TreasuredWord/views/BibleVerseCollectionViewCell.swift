//
//  BibleVerseCollectionViewCell.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class BibleVerseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var verseLabel: UILabel!

    var verse: BibleVerse! {
        willSet(newValue) {
            verseLabel.text = newValue.reference
        }

        didSet(oldValue) {
        }
    }
}
