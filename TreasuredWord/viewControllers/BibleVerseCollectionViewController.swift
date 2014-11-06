//
//  BibleVerseCollectionViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class BibleVerseCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak private var bibleVerseCollectionView: UICollectionView!

    var activeVerse: BibleVerse!

    var bibleVerseCollection: BibleVerseCollection! {
        willSet(newValue) {
            self.navigationItem.title = newValue.name
            self.bibleVerseCollectionView.reloadData()
        }
        didSet(oldValue) {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "bibleVerseCollectionSaved:",
            name: nBibleVerseCollectionSaved,
            object: nil
        )
        bibleVerseCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bibleVerseCollectionSaved(notification: NSNotification) {
        if let bibleVerseCollection = notification.object as? BibleVerseCollection {
            if self.bibleVerseCollection === bibleVerseCollection {
                // replace, to trigger property observer
                self.bibleVerseCollection = bibleVerseCollection
            }
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result = self.bibleVerseCollection?.verses.count ?? 0
        return result
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("bibleVerseCollectionViewCell", forIndexPath: indexPath) as BibleVerseCollectionViewCell
        var verse = self.bibleVerseCollection.verses[indexPath.item]
        cell.verse = verse
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        var bibleVerse = self.bibleVerseCollection.verses[indexPath.item]
        activeVerse = bibleVerse
        self.performSegueWithIdentifier("com.treasuredword.verseCollection.bibleVerseSegue", sender: self)
    }

    @IBAction func onEdit(sender: UIBarButtonItem) {
        if !bibleVerseCollection.isPublic {
            self.performSegueWithIdentifier("com.treasuredword.verseCollection.editSegue", sender: self)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let bibleVerseCollection = self.bibleVerseCollection {
            if let editVC = segue.destinationViewController as? EditBibleVerseCollectionViewController {
                editVC.view.layoutIfNeeded()
                editVC.bibleVerseCollection = bibleVerseCollection
            } else if let bibleVerseVC = segue.destinationViewController as? BibleVerseViewController {
                bibleVerseVC.view.layoutIfNeeded()
                bibleVerseVC.verse = activeVerse
            }
        }
    }
}
