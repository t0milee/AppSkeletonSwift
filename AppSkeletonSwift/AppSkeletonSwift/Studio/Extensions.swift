//
//  Extensions.swift
//

import UIKit

// MARK: - String Extensions
extension String {
	
	// Alternative #1 for capitilazing first letter
	var capitalizeIt: String {
		
		var result = Array(self.characters)
		if !isEmpty {
			result[0] = Character(String(result.first!).uppercaseString)
		}
		
		return String(result)
	}
	
	// Alternative #2 for capitilazing first letter
	var capitalizeFirst: String {
		
		var result = self
		result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
		
		return result
	}
    
    // Substring from index
    func substringFromIndex(index: Int) -> String {
        if (index < 0 || index > self.characters.count) {
            print("index \(index) out of bounds")
            return ""
        }
        return self.substringFromIndex(self.startIndex.advancedBy(index))
    }
    
    // Substring to index
    func substringToIndex(index: Int) -> String {
        if (index < 0 || index > self.characters.count) {
            print("index \(index) out of bounds")
            return ""
        }
        return self.substringToIndex(self.startIndex.advancedBy(index))
    }
	
	// For replacing strings
	func replace(string: String, replacement: String) -> String {
		return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
	}
    
    // Substring with last instance
    func substringWithLastInstanceOf(character: Character) -> String? {
        if let rangeOfIndex = rangeOfCharacterFromSet(NSCharacterSet(charactersInString: String(character)), options: .BackwardsSearch) {
            return self.substringToIndex(rangeOfIndex.endIndex)
        }
        return nil
    }
    
    // Substring without last instance
    func substringWithoutLastInstanceOf(character: Character) -> String? {
        if let rangeOfIndex = rangeOfCharacterFromSet(NSCharacterSet(charactersInString: String(character)), options: .BackwardsSearch) {
            return self.substringToIndex(rangeOfIndex.startIndex)
        }
        return nil
    }
	
	subscript (index:Int) -> String { return String(Array(self.characters)[index]) }
	
	// Hexadecimal to Decimal
	var hexaToDecimal: Int {
		var decimal = 0
		if self == "" { return 0 }
		for index in 0..<self.characters.count {
			for char in 0..<16 {
				if self[index] == "0123456789abcdef"[char] {
					decimal = decimal * 16 + char
				}
			}
		}
		return self[0] == "-" ? decimal * -1 : decimal
	}
    
    func stringToInt() -> Int {
        let numberFromString = NSNumberFormatter().numberFromString(self)
        let int = numberFromString!.integerValue
        
        return int
    }
	
	// To check text field or String is blank or not
	var isBlank: Bool {
		get {
			let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
			return trimmed.isEmpty
		}
	}
	
	// Validate Email
	var isEmail: Bool {
		do {
			let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$", options: .CaseInsensitive)
			return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
		} catch {
			return false
		}
	}
	
	// Validate PhoneNumber
	var isPhoneNumber: Bool {
		let charcter = NSCharacterSet(charactersInString: "+0123456789").invertedSet
		var filtered:NSString!
		let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
		filtered = inputString.componentsJoinedByString("")
		return  self == filtered
	}
}

// MARK: - Int Extensions
extension Int {
    var random: Int {
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
    var indexRandom: [Int] {
        return Array(0..<self).shuffle
    }
}

// MARK: - Array Extensions
extension Array {
    var shuffle: [Element] {
        var elements = self
        for index in 0..<elements.count {
            let anotherIndex = Int(arc4random_uniform(UInt32(elements.count - index))) + index
            anotherIndex != index ? swap(&elements[index], &elements[anotherIndex]) : ()
        }
        return elements
    }
    mutating func shuffled() {
        self = shuffle
    }
    var chooseOne: Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
    
    func choose(x: Int) -> [Element] {
        if x > count { return shuffle }
        let indexes = count.indexRandom[0..<x]
        var result: [Element] = []
        for index in indexes {
            result.append(self[index])
        }
        return result
    }
}

// MARK: - UIColor Extensions
extension UIColor {
	
	// Set color using RGB params
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red   >= 0 && red   <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue  >= 0 && blue  <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	// Set color as 0xff88ro
	convenience init(netHex:Int) {
		self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
	}
}

// MARK: - UIImage Extensions
extension UIImage {
    
    func alpha(value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext()
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        CGContextScaleCTM(ctx, 1, -1)
        CGContextTranslateCTM(ctx, 0, -area.size.height)
        CGContextSetBlendMode(ctx, CGBlendMode.Multiply)
        CGContextSetAlpha(ctx, value)
        CGContextDrawImage(ctx, area, self.CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

// MARK: - UILabel Extensions
extension UILabel {
	
	// Resize UILabel height to fit text
	func resizeHeightToFit(heightConstraint: NSLayoutConstraint) {
		let attributes = [NSFontAttributeName : font]
		numberOfLines = 0
		lineBreakMode = NSLineBreakMode.ByWordWrapping
		let rect = text!.boundingRectWithSize(CGSizeMake(frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
		heightConstraint.constant = rect.height
		setNeedsLayout()
	}
	
	// Required height for UILabel
	func requiredHeight() -> CGFloat{
		let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.ByWordWrapping
		label.font = self.font
		label.text = self.text
		label.sizeToFit()
		return label.frame.height
	}
}

// MARK: - UIView Extensions
extension UIView {
    func fadeIn(duration: NSTimeInterval = 0.5, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
    
    func fadeOut(duration: NSTimeInterval = 0.5, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
}

// MARK: - UIApplication Extensions
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}