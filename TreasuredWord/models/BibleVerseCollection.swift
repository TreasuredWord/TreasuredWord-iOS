//
//  BibleVerseCollection.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import Foundation

let nBibleVerseCollectionSaved = "bibleVerseCollectionSaved"
let pcBibleVerseCollection = "BibleVerseCollection"

class BibleVerseCollection {
    var parseObj: PFObject

    var name: String {
        get {
            let name = parseObj["name"] as? String ?? ""
            return name
        }
        set(newValue) {
            parseObj["name"] = newValue
        }
    }

    var description: String {
        get {
            let description = parseObj["description"] as? String ?? ""
            return description
        }
        set(newValue) {
            parseObj["description"] = newValue
        }
    }

    var verses = [BibleVerse]()

    init() {
        parseObj = PFObject(className: pcBibleVerseCollection)
    }

    init(parseObj: PFObject) {
        self.parseObj = parseObj
        self.verses = (parseObj["verses"] as? [String] ?? []).map({
            (reference: String) -> BibleVerse in
            BibleVerse(reference: reference)
        })
    }

    class func retrieveInBackgroundWithBlock(block: ([BibleVerseCollection]) -> Void) {
        var query = PFQuery(className: pcBibleVerseCollection)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) Bible verse collections.")
                // Do something with the found objects
//                for object in objects {
//                    NSLog("%@", object.objectId)
//                }
                var bibleVerseCollectionObjects = objects as [PFObject]
                var bibleVerseCollections = bibleVerseCollectionObjects.map({
                    (parseObject: PFObject) -> BibleVerseCollection in
                    BibleVerseCollection(parseObj: parseObject)
                })
                block(bibleVerseCollections)
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func save() {
        parseObj["verses"] = getVerseReferences()
        parseObj.saveEventually()
        NSNotificationCenter.defaultCenter().postNotificationName(
            nBibleVerseCollectionSaved,
            object: self
        )
    }

    func getId() -> String? {
        var parseId = self.parseObj.objectId?
        return parseId
    }

    func addVerseWithReference(reference: String) {
        var bibleVerse = BibleVerse(reference: reference)
        verses.append(bibleVerse)
        self.save()
    }

    func getVerseReferences() -> [String] {
        var verseReferences = verses.map({
            (bibleVerse: BibleVerse) -> String in
            bibleVerse.reference
        })
        return verseReferences
    }
}
