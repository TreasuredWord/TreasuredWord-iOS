TreasuredWord-iOS
=================

This is the iOS client for [TreasuredWord](https://github.com/TreasuredWord)

## Download and Build Instructions

* Clone the repository
* Install [CocoaPods](http://cocoapods.org/)
  * `sudo gem install cocoapods`
* Install Pods
  * `pod install`
* Update/initialize the [hacktoolkit-ios_lib](https://github.com/hacktoolkit/hacktoolkit-ios_lib) submodule (temporary step until CocoaPods supports Swift source files natively)
  * `git submodule update --init` (subsequent update don't need the `--init` flag)
* Set up API keys
  * Create a `secrets.xcconfig` config file based on `secrets.xcconfig.template`
  * Obtain API keys from Parse, Facebook, etc. and add the keys to `secrets.xcconfig`
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
* hacktoolkit-ios_lib` is licensed under MIT
  * Full details: <http://hacktoolkit.com>
* The Font Awesome font is licensed under the SIL OFL 1.1:
  * <http://scripts.sil.org/OFL>
* Font Awesome by Dave Gandy - <http://fontawesome.io>
  * Full details: <http://fontawesome.io/license>
