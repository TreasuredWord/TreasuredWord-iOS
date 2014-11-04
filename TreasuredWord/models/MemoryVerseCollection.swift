//
//  MemoryVerseCollection.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import Foundation

let pcMemoryVerseCollection = "MemoryVerseCollection"

class MemoryVerseCollection {
    var parseObj: PFObject!
    var name = ""
    var verses = [String]()

    init() {
        parseObj = PFObject(className: pcMemoryVerseCollection)
    }

    init(parseObj: PFObject) {
        self.parseObj = parseObj
        self.name = parseObj["name"] as String
        self.verses = parseObj["verses"] as [String]
    }

    class func retrieveInBackgroundWithBlock(block: ([MemoryVerseCollection]) -> Void) {
        var query = PFQuery(className: pcMemoryVerseCollection)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) memory verse collections.")
                // Do something with the found objects
                //                for object in objects {
                //                    NSLog("%@", object.objectId)
                //                }
                var memoryVerseCollectionObjects = objects as [PFObject]
                var memoryVerseCollections = memoryVerseCollectionObjects.map({
                    (parseObject: PFObject) -> MemoryVerseCollection in
                    MemoryVerseCollection(parseObj: parseObject)
                })
                block(memoryVerseCollections)
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func save() {
        parseObj["name"] = name
        parseObj["verses"] = verses
        parseObj.saveEventually()
    }

    func addVerse(verse: String) {
        verses.append(verse)
        self.save()
    }
}
