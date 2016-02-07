# FELocalizer

[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/fabianehlert/FELocalizer/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS-yellow.svg)](https://github.com/fabianehlert/FELocalizer)
[![Build Status](https://api.travis-ci.org/fabianehlert/FELocalizer.svg?branch=master)](https://travis-ci.org/fabianehlert/FELocalizer)
[![Twitter: @fabianehlert](https://img.shields.io/badge/twitter-fabianehlert-blue.svg)](https://twitter.com/fabianehlert)

## About
This project replaces Xcode's `Localizable.strings`

## Future
* The idea is to create a desktop application which helps managing all your localized strings easily and automatically generates and updates the required JSON file for you.
* Differentiate between Numerus and Genus (already finished preparation)

## Setup
1. Copy the `FELocalizer.swift` file into your project
2. Create a JSON file (for example `Localizer.json`) which will contain your localized strings
3. Tell `FELocalizer` which file to look for:
```swift
if let file = NSBundle.mainBundle().pathForResource("Localizer", ofType: "json") {
    FELocalizer.shared.setFilePath(file)
}
```
>This also initializes a shared instance of FELocalizer which can be used across your app

## Usage
### JSON structure
All your localization data will be stored in the previously created `Localizer.json` file. In order to work properly with `FELocalizer` you have to follow this structure:
```json
{
  "Hello": {
        "de": {
            "default": "Hallo"
        },
        "en": {
            "default": "Hello"
        },
        "fr": {
            "default": "Salut"
        }
    }
}
```

### Obtaining a localized string
Simply call `localized("key")` on the shared instance of FELocalizer to get a localized string for the given key for the current system language.
```swift
let translation = FELocalizer.shared.localized("Hello")
```
### Obtaining a localized string for a specific language
Call `localized("key", language: "en")` on the shared instance of FELocalizer to get a localized string for the given key for the specified language.
>Note: The language string must be in [ISO 639-1](http://www.loc.gov/standards/iso639-2/php/code_list.php) format (for example "en" for English, "de" for German)

```swift
let translation = FELocalizer.shared.localized("Hello", language: "en")
```
