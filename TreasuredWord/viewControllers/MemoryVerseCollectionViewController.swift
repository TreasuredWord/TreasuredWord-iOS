//
//  MemoryVerseCollectionViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/4/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class MemoryVerseCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak private var memoryVerseCollectionView: UICollectionView!

    var activeVerse: MemoryVerse!

    var memoryVerseCollection: MemoryVerseCollection! {
        willSet(newValue) {
            self.navigationItem.title = newValue.name
            self.memoryVerseCollectionView.reloadData()
        }
        didSet(oldValue) {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memoryVerseCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result = self.memoryVerseCollection?.verses.count ?? 0
        return result
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("memoryVerseCollectionViewCell", forIndexPath: indexPath) as MemoryVerseCollectionViewCell
        var verse = self.memoryVerseCollection.verses[indexPath.item]
        cell.verse = verse
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        var verse = self.memoryVerseCollection.verses[indexPath.item]
        activeVerse = MemoryVerse(verseReference: verse)
        self.performSegueWithIdentifier("memoryVerseSegue", sender: self)
    }

    @IBAction func onEdit(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("editVerseCollectionSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let memoryVerseCollection = self.memoryVerseCollection {
            if let editVC = segue.destinationViewController as? EditMemoryVerseCollectionViewController {
                editVC.view.layoutIfNeeded()
                editVC.memoryVerseCollection = memoryVerseCollection
            } else if let memverseVC = segue.destinationViewController as? MemoryVerseViewController {
                memverseVC.view.layoutIfNeeded()
                memverseVC.verse = activeVerse
            }
        }
    }
}
