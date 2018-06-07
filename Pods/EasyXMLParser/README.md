<p align="center" >
  <img src="http://icons.iconarchive.com/icons/cornmanthe3rd/plex/512/Other-xml-icon.png" title="xmlLogo">
</p>

# EasyXMLParser 
[![Build Status](https://travis-ci.org/Asifadam93/EasyXMLParser.svg?branch=master)](https://travis-ci.org/Asifadam93/EasyXMLParser)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/EasyXMLParser)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EasyXMLParser.svg)](https://cocoapods.org/pods/EasyXMLParser)
[![Platform](https://img.shields.io/cocoapods/p/EasyXMLParser.svg?style=flat)](https://github.com/Asifadam93/EasyXMLParser)
[![CocoaPods](https://img.shields.io/cocoapods/l/EasyXMLParser.svg)](https://github.com/Asifadam93/EasyXMLParser/blob/master/LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/Asifadam93/EasyXMLParser.svg)]()

EasyXMLParser is a simple and easy to use xml parser written in swift for iOs

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C, which automates and simplifies the process of using 3rd-party libraries like EasyXMLParse in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate EasyXMLParse into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.2'

target 'TargetName' do
pod 'EasyXMLParser', '~> 1.1'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage


#### Parsing with a xml file

```swift

if let utilisateursFichier = Bundle.main.path(forResource: "utilisateurs", ofType: "xml") {
            if let utilisateursString = try? String(contentsOfFile: utilisateursFichier) {
                if let utilisateurData = utilisateursString.data(using: .utf8) {
                    
                    // Parse xml with EasyXMLParser
                    let parser = EasyXMLParser(withData: utilisateurData)
                    let items = parser.parse()
                    
                    // data without filter
                    for item in items["utilisateurs"]["utilisateur"].getSiblingWithSameName() {
                        print(item.fullDescription())
                    }
                    
                    // data with filter
                    let filtreUtilisateur = ["utilisateur":["nom":"", "mail":""]]
                    
                    for item in items.filter(filtre: filtreUtilisateur) {
                        print(item.fullDescription())
                    }
                    
                    // casting data
                    print("Code postal du premier utilisateur (int) : \(items["utilisateurs"]["utilisateur"]["code_postal"].intValue)")
                    print("Code postal du premier utilisateur (float) : \(items["utilisateurs"]["utilisateur"]["code_postal"].floatValue)\n")

                }
            }
        }

```

#### Exemple xml file

```xml

<?xml version="1.0" encoding="UTF-8" ?>
<utilisateurs>
	<utilisateur>
		<nom>Lenore</nom>
		<mail>et.libero.Proin@vitaeerat.co.uk</mail>
		<telephone>16520424 5277</telephone>
		<addresse>2339 Vivamus Ave</addresse>
		<ville>Şanlıurfa</ville>
		<code_postal>11600</code_postal>
		<pay>American Samoa</pay>
	</utilisateur>
	<utilisateur>
		<nom>Neville</nom>
		<mail>non.enim.commodo@Duiscursusdiam.com</mail>
		<telephone>16140811 4054</telephone>
		<addresse>CP 406, 2955 Fusce Chemin</addresse>
		<ville>Sint-Martens-Lennik</ville>
		<code_postal>1728</code_postal>
		<pay>Ukraine</pay>
	</utilisateur>
</utilisateurs>

```

#### Parsing with an url

```swift

if let url = URL.init(string: "https://korben.info/feed") {

            if let xmlData = try? Data.init(contentsOf: url) {
               
                // Parse xml with EasyXMLParser
                let parser = EasyXMLParser(withData: xmlData)
                let letFluxRSS = parser.parse()
                
                // get channel data
                print("Nom du flux RSS : \(letFluxRSS["rss"]["channel"]["title"].value)")
                print("Adress du flux RSS : \(letFluxRSS["rss"]["channel"]["link"].value)")
                
                print("Nombre d'article du flux RSS : \(letFluxRSS["rss"]["channel"]["item"].countSiblingWithSameName())")
                print("Nombre de données pour le premier article : \(letFluxRSS["rss"]["channel"]["item"].countAllChildren()) \n\n")
                
                // get article data
                for article in letFluxRSS["rss"]["channel"]["item"].getSiblingWithSameName() {
                    print(article.fullDescription())
                }
            }
        }

```

## License

EasyXMLParser is released under the BSD-3 license. See LICENSE for details.

