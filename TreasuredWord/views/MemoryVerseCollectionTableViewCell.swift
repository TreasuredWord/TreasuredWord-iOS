//
//  MemoryVerseCollectionTableViewCell.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class MemoryVerseCollectionCell: UITableViewCell {

    @IBOutlet weak private var collectionNameLabel: UILabel!
    @IBOutlet weak private var versesLabel: UILabel!

    var memoryVerseCollection: MemoryVerseCollection! {
        willSet(newValue) {
            collectionNameLabel.text = newValue.name
            versesLabel.text = "; ".join(newValue.verses)
        }

        didSet(oldValue) {
            
        }
    }
}
