# StorageToolKit

StorageToolKit aims to be a set of tools that works together to identify and optimize disk usage. StorageToolKit Allows Apps to monitor and clean the stored files e.g. cache or other files that an application creates while running.


### StorageToolKit contains three libraries as of now:
- StorageCleaner
- StorageAnalyzerCore (TBA)
- StorageAnalyzerUI (TBA)

> **_NOTE:_**  As of now this repo only contains StorageCleaner, we will be soon open sourcing StorageAnalyzerCore & StorageAnalyzerUI.


## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into `swift`.
To add a package dependency to your Xcode project, select File > Swift Packages > Add Package Dependency and enter below repository URL

```
https://github.com/gojekfarm/StorageToolKit-iOS
```

Once you have your Swift package set up, adding StorageToolKit-iOS as a dependency is as easy as adding it to your Package.swift dependencies value.

```swift
dependencies: [
    .package(url: "https://github.com/gojekfarm/StorageToolKit-iOS.git", .upToNextMajor(from: "0.0.9"))
]
```

### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate pods from StorageToolKit into your Xcode project using CocoaPods, specify the require pod in your Podfile:

#### StorageCleaner

```ruby
pod 'StorageCleaner'
```

## Usage 

* For StorageCleaner usage refer [StorageCleaner/README.md](StorageCleaner/README.md)

## Contributing

As the creators, and maintainers of this project, we're glad to invite contributors to help us stay up to date. Please take a moment to review [the contributing document](.github/CONTRIBUTING.md) in order to make the contribution process easy and effective for everyone involved.

- If you **found a bug**, open an [issue](https://github.com/gojek/StorageToolKit-iOS/issues).
- If you **have a feature request**, open an [issue](https://github.com/gojek/StorageToolKit-iOS/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/gojek/StorageToolKit-iOS/pulls).

## License

**StorageToolKit-iOS** is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
