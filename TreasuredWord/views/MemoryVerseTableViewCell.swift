//
//  MemoryVerseTableViewCell.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class MemoryVerseCell: UITableViewCell {

    @IBOutlet weak private var verseLabel: UILabel!

    var verse: String! {
        willSet(newValue) {
            verseLabel.text = newValue
        }

        didSet(oldValue) {
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
