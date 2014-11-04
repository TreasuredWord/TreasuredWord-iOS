TreasuredWord-iOS
=================

This is the iOS client for [TreasuredWord](https://github.com/TreasuredWord)

## Download and Build Instructions

* Clone the repository
* Install [CocoaPods](http://cocoapods.org/)
  * `sudo gem install cocoapods`
* Install Pods
  * `pod install`
* Set up API keys
  * Create a `secrets.xcconfig` config file based on `secrets.xcconfig.template`
  * Obtain API keys from Parse and add the keys to `secrets.xcconfig`
* Run it!

## Features

Here's an animated GIF (made with [LiceCAP](http://www.cockos.com/licecap/)) of what it looks like:

![](https://raw.githubusercontent.com/TreasuredWord/TreasuredWord-iOS/master/treasuredword_screencap.gif)

**In Progress**

* Create collections of memory verses (e.g. by theme, class)
* Edit verses in a collection
* Discover memory verse collections from a catalog and pin to home
* Memory Verse Card
  * In a collection, swipe left or right to advance to next or previous card
  * Tap the card to flip it over and see the text
  * On a card, automatically populate the verse text by pulling from an API
* Settings
  * Set your preferred Bible translation/version

## Team

* [Jonathan Tsai](https://github.com/jontsai)

## License

* `TreasuredWord-iOS` is licensed under MIT. See `LICENSE`
