//
//  EditMemoryVerseCollectionViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class EditMemoryVerseCollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var collectionNameField: UITextField!
    @IBOutlet weak var verseEntry: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var memoryVerseCollection: MemoryVerseCollection! {
        willSet(newValue) {
            collectionNameField.text = newValue.name
            self.navigationItem.title = "Edit Verse Collection"
            self.tableView!.reloadData()
        }

        didSet(oldValue) {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if memoryVerseCollection != nil {
            // do nothing
        } else {
            memoryVerseCollection = MemoryVerseCollection()
            self.navigationItem.title = "Create Verse Collection"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNameChanged(sender: UITextField) {
        memoryVerseCollection.name = sender.text!
        memoryVerseCollection.save()
    }

    @IBAction func onAdded(sender: UIButton) {
        var verse = verseEntry!.text
        memoryVerseCollection.addVerse(verse)
        verseEntry.text = ""
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = memoryVerseCollection?.verses.count ?? 0
        return result
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("memoryVerseCell") as MemoryVerseCell
        var verse = memoryVerseCollection.verses[indexPath.row]
        cell.verse = verse
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
