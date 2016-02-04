//
//  AttributedStringService.swift
//

/* EXAMPLE
    let text1 = AttributedStringModel(text: "Hello ", font: nil, color: UIColor.darkGrayColor())
    let text2 = AttributedStringModel(text: "World", font: nil, color: UIColor.purpleColor())
    label.attributedText = AttributedStringService.attributedStringFor([text1, text2])
*/

import UIKit

class AttributedStringService: NSObject {

    // Configure attributed text
    static func attributedStringFor(params: [AttributedStringModel]) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()
        
        // Go through every param
        for attributedModel in params {
            
            // Set initial text
            let attrText = NSMutableAttributedString(string: attributedModel.text)
            
            // Configure FONT
            if let font = attributedModel.font {
                attrText.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attrText.length))
            }
            
            // Configure COLOR
            if let color = attributedModel.color {
                attrText.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attrText.length))
            }
            
            // Appent string to result
            result.appendAttributedString(attrText)
        }
        
        // Return result
        return result
    }
}

class AttributedStringModel {
    
    // Properties
    var text:  String
    var font:  UIFont?
    var color: UIColor?
    
    // Constructor
    init(text: String, font: UIFont?, color: UIColor?) {
        self.text  = text
        self.font  = font
        self.color = color
    }
}