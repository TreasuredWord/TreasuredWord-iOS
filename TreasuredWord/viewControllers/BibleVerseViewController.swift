//
//  BibleVerseViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class BibleVerseViewController: UIViewController {

    @IBOutlet weak private var verseLabel: UILabel!
    @IBOutlet weak private var verseTextLabel: UILabel!

    var verse: BibleVerse! {
        willSet(newValue) {
            verseLabel.text = newValue.reference
            verseTextLabel.text = newValue.getText()
            self.navigationItem.title = newValue.reference
        }

        didSet(oldValue) {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
