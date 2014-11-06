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
    var myBibleVerseCollections: [BibleVerseCollection]!
    var publicBibleVerseCollections: [BibleVerseCollection]!
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
                self.myBibleVerseCollections.append(bibleVerseCollection)
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
            self.myBibleVerseCollections = bibleVerseCollections.filter({
                (includeElement: BibleVerseCollection) -> Bool in
                return includeElement.isEditableByCurrentUser()
            })
            self.publicBibleVerseCollections = bibleVerseCollections.filter({
                (includeElement: BibleVerseCollection) -> Bool in
                return !includeElement.isEditableByCurrentUser()
            })
            self.tableView.reloadData()
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func getBibleVerseCollectionForIndexPath(indexPath: NSIndexPath) -> BibleVerseCollection {
        var section = indexPath.section
        var bibleVerseCollection = section == 0 ? myBibleVerseCollections![indexPath.row] : publicBibleVerseCollections![indexPath.row]
        return bibleVerseCollection
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let SECTION_HEADER_HEIGHT = 20
        var sectionName = section == 0 ? "My Verse Collections" : "Public Verse Collections"

        var headerView = UIView(frame: CGRect(x: 0, y:0, width: 320, height: SECTION_HEADER_HEIGHT))
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)

        var headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: SECTION_HEADER_HEIGHT))
        headerLabel.text = "     \(sectionName)"

        headerView.addSubview(headerLabel)

        return headerView
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = (section == 0 ? myBibleVerseCollections?.count : publicBibleVerseCollections?.count) ?? 0
        return result
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("bibleVerseCollectionTableViewCell") as BibleVerseCollectionTableViewCell
        var bibleVerseCollection = getBibleVerseCollectionForIndexPath(indexPath)
        cell.bibleVerseCollection = bibleVerseCollection
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var bibleVerseCollection = getBibleVerseCollectionForIndexPath(indexPath)
        activeBibleVerseCollection = bibleVerseCollection
        self.performSegueWithIdentifier("com.treasuredword.home.viewVerseCollectionSegue", sender: self)
    }

    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOut()
        println ("logout pressed")
        NSNotificationCenter.defaultCenter().postNotificationName("didLogoutNotification", object: nil)
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
