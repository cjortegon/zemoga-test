# Test for Zemoga

## Author

Camilo Ortegón
4 years of experience in iOS and 7 in Mobile apps in general.

## How to run

1. Run `pod install` at terminal.
2. Open `zemogalist.xcworkspace`.
3. Update signing if needed and run the project.

## Libraries and extensions

### SnapKit

Snapkit is an Autolayout DSL. This makes it easier to create views programmatically.
`Snapkit+Layout.swift` is a set of rules created by me to improve the readability of views by code.

`String+Localizable.swift` is an small code to localize the aplication, instead of using 3rd pary libraries.

## Project structure

### Core
This contains the API and local Database reader (using Core Data).

### Models
The single entity created is `Post`

### Modules
All the view controllers and subviews.

### Util
Extensions and classes to handle localization, colors and common constrains.

## Architecture

`DatabaseReader` is a singleton class to be accessed everywhere, in order to have a single connection with the persistent container to handle Core data updates.

This also implements the **Publish/Subscribe** design pattern. This makes it easy to subscribe to changes in the data structure from any view. If anybody executes an update, like refreshing data or removing an element, the class will call all its subscribers after the operation finishes.

### Network layer

No network layer is needed for this app, because there are no many or complex endpoints to call. But for a larger app, I would implement an extension for `Alamofire` to enable handling headers and other helpers.

However, I'm using codable to decode the responses from the API.

### Reactive programming

For a larger application I would implement this library [ReduxObservableSwift](https://github.com/grability-inc/ReduxObservableSwift), that is based on RxSwift + Observable architecture. A mix between Rx operators with Redux.

Build event-driven applications when the complexity of the application is high, reduces the chances for unknown flow errors.
