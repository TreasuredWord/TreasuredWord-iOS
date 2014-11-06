//
//  EditBibleVerseCollectionViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class EditBibleVerseCollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var addVerseField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var bibleVerseCollection: BibleVerseCollection! {
        willSet(newValue) {
            nameField.text = newValue.name
            descriptionField.text = newValue.description
            self.navigationItem.title = "Edit Verse Collection"
            self.tableView!.reloadData()
        }

        didSet(oldValue) {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if bibleVerseCollection != nil {
            // do nothing
        } else {
            bibleVerseCollection = BibleVerseCollection()
            self.navigationItem.title = "Create Verse Collection"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTextFieldEditingChanged(sender: AnyObject) {
        bibleVerseCollection.name = nameField!.text
        bibleVerseCollection.description = descriptionField!.text
        bibleVerseCollection.save()
    }

    @IBAction func onAdded(sender: UIButton) {
        var verseReference = addVerseField!.text
        if verseReference != "" {
            bibleVerseCollection.addVerseWithReference(verseReference)
            tableView.reloadData()
        }
        addVerseField.text = ""
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = bibleVerseCollection?.verses.count ?? 0
        return result
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("bibleVerseTableViewCell") as BibleVerseTableViewCell
        var verse = bibleVerseCollection.verses[indexPath.row]
        cell.verse = verse
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Saving...")
        bibleVerseCollection.save()
    }
}
