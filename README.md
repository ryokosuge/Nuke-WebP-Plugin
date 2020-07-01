# Nuke-WebP-Plugin

[![CI Status](http://img.shields.io/travis/ryokosuge/Nuke-WebP-Plugin.svg?style=flat)](https://travis-ci.org/ryokosuge/Nuke-WebP-Plugin)
[![codecov](https://codecov.io/gh/ryokosuge/Nuke-WebP-Plugin/branch/master/graph/badge.svg)](https://codecov.io/gh/ryokosuge/Nuke-WebP-Plugin)
![Version](https://img.shields.io/cocoapods/v/Nuke-WebP-Plugin.svg?label=version)
![Supoprts](https://img.shields.io/badge/supports-CocoaPods%20%7C%20Carthage-green.svg)
![Platform](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)

WebP for Nuke that allows you to load and display WebP image. You can see it for yourself in a demo, included in the project.

## Usage

The plugin features a pre-configured Nuke.Manager with WebP support, and an WebPImage:

```swift
import Nuke
import NukeWebPPlugin

WebPImageDecoder.enable()

let imageView = UIImageView()
let webpimageURL = URL(string: "https://example.com/sample.webp")!
Nuke.loadImage(with: url, into: imageView)
```

## Installation

### [CocoaPods](https://cocoapods.org/)

```ruby
pod 'Nuke-WebP-Plugin'
```

### [Carthage](https://github.com/Carthage/Carthage)

```ruby
github 'ryokosuge/Nuke-WebP-Plugin'
```

## Minimum Requirements

| Swift | Xcode | iOS | macOS | tvOS | watchOS |
|:-----:|:-----:|:---:|:-----:|:----:|:-------:|
| 5.1, 5.2 | 11.0 | 11.0 | 10.13 | 11.0 | 4.0 |

## Dependencies

| [Nuke](https://github.com/kean/Nuke) | [libwebp](https://chromium.googlesource.com/webm/libwebp) |
|:---:|:---:|
| >= 9.0 | v1.0.0 |

## Author

ryokosuge, ryo.kosuge@gmail.com

## License

Nuke-WebP-Plugin is available under the MIT license. See the LICENSE file for more info.
