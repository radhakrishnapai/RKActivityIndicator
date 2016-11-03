# RKActivityIndicator

[![CI Status](http://img.shields.io/travis/radhakrishnapai/RKActivityIndicator.svg?style=flat)](https://travis-ci.org/radhakrishnapai/RKActivityIndicator) 
[![Version](https://img.shields.io/cocoapods/v/RKActivityIndicator.svg?style=flat)](http://cocoapods.org/pods/RKActivityIndicator) 
[![License](https://img.shields.io/cocoapods/l/RKActivityIndicator.svg?style=flat)](http://cocoapods.org/pods/RKActivityIndicator) 
[![Platform](https://img.shields.io/cocoapods/p/RKActivityIndicator.svg?style=flat)](http://cocoapods.org/pods/RKActivityIndicator)

RKActivityIndicator is a customizable indicator where in you can use your own themes to create loading indicators on demand.
Just pass in the theme, along with the loading type, which can be 'Definite' or 'Indefinite'.

Definite Loading:

![sample_gif](https://github.com/radhakrishnapai/RKActivityIndicator/blob/master/Example/Definite_Loading.gif)

Indefinite Loading:

![sample_gif](https://github.com/radhakrishnapai/RKActivityIndicator/blob/master/Example/Indefinite_Loading.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 9.0+, Swift 3.0+.

## Installation

#### Using CocoaPods: 
RKActivityIndicator is available through [CocoaPods](http://cocoapods.org). To install
it, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod ’RKActivityIndicator’, ‘1.0.0'
end
```
Then, run the following command:
```
$ pod install
```

#### Manually:

- Download RKActivityIndicator.
- Drag and drop RKActivityIndicator directory to your project.


## Usage

- Create a Theme class that conforms to the protocol `RKActivityIndicatorThemeProtocol`.
```
class RKActivityIndicatorTheme: RKActivityIndicatorThemeProtocol {
// write your code here 
}
```
- Use the enum `RKActivityIndicatorType` to define the type of your indicator.
  - For Progressive type, use: `RKActivityIndicatorType.definite`.
  - For Indefinite type,  use: `RKActivityIndicatorType.indefinite`.
```
let indefiniteIndicator = RKActivityIndicator(type: RKActivityIndicatorType.indefinite,
theme: RKActivityIndicatorTheme())

let definiteIndicator = RKActivityIndicator(type: RKActivityIndicatorType.definite, 
theme: RKActivityIndicatorTheme())
```
- Always pass in the `view` that you want to show the indicator on as a parameter.
```
indefiniteIndicator.startAnimatingInView(view: self.view)
indefiniteIndicator.stopAnimatingInView(view: self.view)
```

#### Definite:

Define your Indicator as follows:
```
let definiteIndicator = RKActivityIndicator(type: RKActivityIndicatorType.definite, 
theme: RKDefiniteActivityIndicatorTheme())
```
In your delegate method or function call pass, the download percentage as follows:

```
func downloadImageWithProgress(progress: Double) {
definiteIndicator.showProgress(progress: progress, view: self.view)
}
```

To stop the animation, just use the following:

```
definiteIndicator.stopAnimatingInView(view: self.view)
```

#### Indefinite:
```
let indefiniteIndicator = RKActivityIndicator(type: RKActivityIndicatorType.indefinite,
theme: RKIndefiniteActivityIndicatorTheme())
indefiniteIndicator.animationDuration = 0.8
indefiniteIndicator.startAnimatingInView(view: self.view)
```
To stop the animation, just use the following:

```
indefiniteIndicator.stopAnimatingInView(view: self.view)
```
#### Note:
Two custom themes namely `RKIndefiniteActivityIndicatorTheme` and `RKDefiniteActivityIndicatorTheme` have been provided in the example.<br> You may use the same or create your own themes that meet the requirements of the protocol `RKActivityIndicatorThemeProtocol`.

## Author

Radhakrishna Pai, radhakrishnapai09@gmail.com

## License

RKActivityIndicator is available under the MIT license. See the LICENSE file for more info.
