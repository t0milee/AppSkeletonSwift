//
//  Constants.swift
//

import UIKit

// MARK: - Enum's

// Segue Type
enum SegueType {
    case PUSH
    case PRESENT
}

// Side Menu State
enum SideMenuState {
    case OPEN
    case CLOSED
}

// HTTP Methods
enum HTTPMethod: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

// MARK: - Struct's

// General App Constants
struct AppConstant {
    static let FIRST_APP_LAUNCH = "first_app_launch"
    static let HEADER_TITLE     = "header_title"
}

// API Constants
struct APIConstant {
    static let LANGUAGE_SRB    = "sr"
    
    static let BASE_URL        = "http://example.com"
    static let SERVICE_EXAMPLE = "/example"
}

// Cell Constants
struct CellConstant {
    static let MIN_HEIGHT    = 95
    static let BUTTON_HEIGHT = 20
    static let PADDING       = 32
}

// Storyboards
struct Storyboard {
    static let MAIN = "Main"
}

// ViewControllers
struct ViewController {
    static let EXAMPLE_1 = "Example1ViewController"
    static let EXAMPLE_2 = "Example2ViewController"
}

// Screens
struct Screen {
    static let EXAMPLE_1 = "Example 1"
    static let EXAMPLE_2 = "Example 2"
}

// Local Cache Constants
struct LocalCacheConstant {
    static let LOCAL_CACHE  = "local_cache"
    static let DEVICE_TOKEN = "device_token"
}

// MARK: - Language

// Language Constants
struct LanguageConstant {
    static let ENGLISH = "en"
}

// Language Keys
struct LanguageKey {
}

// Alerts
struct Alert {
    static let TITLE_ERROR   = "ERROR"
    static let TITLE_SUCCESS = "SUCCESS"
}

// Labels
struct Label {
}

// Buttons
struct Button {
}

// TextFields
struct TextField {
}

// MARK: - Support

// Separators
struct Separator {
    static let ARRAY = "***###***"
}

// Colors
struct Color {
    static let DARK_GRAY  = UIColor(netHex: 0x5c5f78)
    static let LIGHT_GRAY = UIColor(netHex: 0xafb1c7)
    static let GRAY       = UIColor(netHex: 0x8c8c8c)
    static let GREEN      = UIColor.greenColor()
    static let RED        = UIColor.redColor()
    static let WHITE      = UIColor.whiteColor()
}

// Fonts
struct Font {
    static func FONT_NAME(size: CGFloat) -> UIFont { return UIFont(name: "Font_Name", size: size)! }
}