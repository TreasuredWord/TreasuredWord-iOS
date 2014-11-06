//
//  BibleVerseCollectionTableViewCell.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class BibleVerseCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak private var collectionNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak private var versesLabel: UILabel!

    var bibleVerseCollection: BibleVerseCollection! {
        willSet(newValue) {
            collectionNameLabel.text = newValue.name
            descriptionLabel.text = newValue.description
            versesLabel.text = "; ".join(newValue.getVerseReferences())
        }

        didSet(oldValue) {
            
        }
    }
}
