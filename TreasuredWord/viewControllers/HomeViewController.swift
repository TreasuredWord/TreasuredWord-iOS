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

    var memoryVerseCollections = [MemoryVerseCollection]()
    var activeMemoryVerseCollection: MemoryVerseCollection!

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCollections()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func retrieveCollections() {
        MemoryVerseCollection.retrieveInBackgroundWithBlock {
            (memoryVerseCollections: [MemoryVerseCollection]) -> Void in
            self.memoryVerseCollections = memoryVerseCollections
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryVerseCollections.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("memoryVerseCollectionCell") as MemoryVerseCollectionCell
        var memoryVerseCollection = memoryVerseCollections[indexPath.row]
        cell.memoryVerseCollection = memoryVerseCollection
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var memoryVerseCollection = memoryVerseCollections[indexPath.row]
        activeMemoryVerseCollection = memoryVerseCollection
        self.performSegueWithIdentifier("viewVerseCollectionSegue", sender: self)
    }

    @IBAction func onCreate(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("createVerseCollectionSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let activeMemoryVerseCollection = self.activeMemoryVerseCollection {
            if let viewVC = segue.destinationViewController as? MemoryVerseCollectionViewController {
                viewVC.view.layoutIfNeeded()
                viewVC.memoryVerseCollection = activeMemoryVerseCollection
            } else if let createVC = segue.destinationViewController as? EditMemoryVerseCollectionViewController {
                // do nothing
            }
        }
    }

}
