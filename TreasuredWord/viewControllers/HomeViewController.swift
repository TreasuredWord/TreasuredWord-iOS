//
//  HomeViewController.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var refreshControl: UIRefreshControl?
    var bibleVerseCollections = [BibleVerseCollection]()
    var activeBibleVerseCollection: BibleVerseCollection!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // auto layout stuff
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 75;

        // pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        self.refreshControl?.addTarget(self, action: "tableRefreshCallback:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView!.addSubview(self.refreshControl!)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "bibleVerseCollectionSaved:",
            name: nBibleVerseCollectionSaved,
            object: nil
        )
        retrieveCollections()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bibleVerseCollectionSaved(notification: NSNotification) {
        if let bibleVerseCollection = notification.object as? BibleVerseCollection {
            var alreadyExists = false
            for existingCollection in bibleVerseCollections {
                if existingCollection === bibleVerseCollection {
                    alreadyExists = true
                }
            }
            if !alreadyExists {
                self.bibleVerseCollections.append(bibleVerseCollection)
            }
        }
        self.tableView.reloadData()
    }

    func tableRefreshCallback(refreshControl: UIRefreshControl) {
        NSLog("Refreshing...")
        retrieveCollections()
        self.tableView.reloadData()
    }

    func retrieveCollections() {
        BibleVerseCollection.retrieveInBackgroundWithBlock {
            (bibleVerseCollections: [BibleVerseCollection]) -> Void in
            self.refreshControl?.endRefreshing()
            self.bibleVerseCollections = bibleVerseCollections
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bibleVerseCollections.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("bibleVerseCollectionTableViewCell") as BibleVerseCollectionTableViewCell
        var bibleVerseCollection = bibleVerseCollections[indexPath.row]
        cell.bibleVerseCollection = bibleVerseCollection
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var bibleVerseCollection = bibleVerseCollections[indexPath.row]
        activeBibleVerseCollection = bibleVerseCollection
        self.performSegueWithIdentifier("com.treasuredword.home.viewVerseCollectionSegue", sender: self)
    }

    @IBAction func onCreate(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("com.treasuredword.home.createVerseCollectionSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let activeBibleVerseCollection = self.activeBibleVerseCollection {
            if let viewVC = segue.destinationViewController as? BibleVerseCollectionViewController {
                viewVC.view.layoutIfNeeded()
                viewVC.bibleVerseCollection = activeBibleVerseCollection
            } else if let createVC = segue.destinationViewController as? EditBibleVerseCollectionViewController {
                // do nothing
            }
        }
    }
}
