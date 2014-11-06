//
//  BibleVerseCollection.swift
//  TreasuredWord
//
//  Created by Jonathan Tsai on 11/3/14.
//  Copyright (c) 2014 TreasuredWord. All rights reserved.
//

import Foundation

let nBibleVerseCollectionSaved = "bibleVerseCollectionSaved"
let pcnBibleVerseCollection = "BibleVerseCollection"

//class BibleVerseCollection: PFObject, PFSubclassing {
class BibleVerseCollection {
//    override class func load() {
//        self.registerSubclass()
//    }
//
//    class func parseClassName() -> String! {
//        return pcnBibleVerseCollection
//    }

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

    var curator: PFUser {
        get {
            let user = parseObj["curator"] as PFUser
            return user
        }
    }

    var verses = [BibleVerse]()

    init() {
        parseObj = PFObject(className: pcnBibleVerseCollection)
        var acl = PFACL(user: PFUser.currentUser())
        acl.setPublicReadAccess(true)
        parseObj.ACL = acl
        parseObj["curator"] = PFUser.currentUser()
//        parseObj.saveEventually()
    }

    init(parseObj: PFObject) {
        self.parseObj = parseObj
        self.verses = (parseObj["verses"] as? [String] ?? []).map({
            (reference: String) -> BibleVerse in
            BibleVerse(reference: reference)
        })
    }

    class func retrieveInBackgroundWithBlock(block: ([BibleVerseCollection]) -> Void) {
        var query = PFQuery(className: pcnBibleVerseCollection)
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

    func isEditableByCurrentUser() -> Bool {
        var result = self.curator.objectId == PFUser.currentUser().objectId
        return result
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
