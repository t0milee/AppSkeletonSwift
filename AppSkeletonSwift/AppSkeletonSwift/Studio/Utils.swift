//
//  Utils.swift
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class Utils {
	
	// MARK: - Configuration
	
	// Configure label
	class func configureLabel(label: UILabel, text: String?, font: UIFont?, textColor: UIColor?) {
		
		// Set text
		if text != nil {
			label.text = text
		}
		
		// Set font
		if font != nil {
			label.font = font
		}
		
		// Set text color
		if textColor != nil {
			label.textColor = textColor
		}
	}
	
    // Configure button
    class func configureButton(button: UIButton, title: String?, font: UIFont?, titleColor: UIColor?, titleColorHighlighted: UIColor?, image: String?, backgroundImage: String?) {
        
        // Set text
        if title != nil {
            button.setTitle(title, forState: .Normal)
            button.setTitle(title, forState: .Highlighted)
            button.setTitle(title, forState: .Selected)
        }
        
        // Set font
        if font != nil {
            button.titleLabel?.font = font
        }
        
        // Set title color
        if titleColor != nil {
            button.setTitleColor(titleColor, forState: .Normal)
            if titleColorHighlighted != nil {
                button.setTitleColor(titleColorHighlighted, forState: .Highlighted)
                button.setTitleColor(titleColorHighlighted, forState: .Selected)
            } else {
                button.setTitleColor(titleColor, forState: .Highlighted)
                button.setTitleColor(titleColor, forState: .Selected)
            }
        }
        
        // Set image
        if image != nil {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
            
            let inactiveImage = UIImage(named: String(format: "%@_inactive", image!))
            let activeImage   = UIImage(named: String(format: "%@_active", image!))
            button.setImage(inactiveImage, forState: .Normal)
            button.setImage(activeImage,   forState: .Highlighted)
            button.setImage(activeImage,   forState: .Selected)
            button.setImage(inactiveImage, forState: [.Selected, .Highlighted])
        }
        
        // Set background image
        if backgroundImage != nil {
            let inactiveImage = UIImage(named: String(format: "%@_inactive", backgroundImage!))
            let activeImage   = UIImage(named: String(format: "%@_active", backgroundImage!))
            button.setBackgroundImage(inactiveImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 40, 40, 40)), forState: .Normal)
            button.setBackgroundImage(activeImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 40, 40, 40)),   forState: .Highlighted)
            button.setBackgroundImage(activeImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 40, 40, 40)),   forState: .Selected)
            button.setBackgroundImage(inactiveImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 40, 40, 40)), forState: [.Selected, .Highlighted])
        }
    }
	
	// Configure UITextField
	class func configureTextField(txtField: UITextField, text: String?, placeholder: String?, font: UIFont?, textColor: UIColor?, backgroundImage: String?, leftPadding: CGFloat, rightPadding: CGFloat) {
		
		// Set text
		if text != nil {
			txtField.text = text
		}
		
		// Set placeholder
		if placeholder != nil {
			txtField.placeholder = placeholder
		}
		
		// Set font
		if font != nil {
			txtField.font = font
		}
		
		// Set text color
		if textColor != nil {
			txtField.textColor = textColor
		}
		
		// Set background image
		if backgroundImage != nil {
			let imgBackground = UIImage(named: backgroundImage!)
			txtField.background = imgBackground?.resizableImageWithCapInsets(UIEdgeInsetsMake(40, 40, 40, 40))
		}
		
		// Set left padding
		if leftPadding != 0 {
			let paddingView = UIView(frame: CGRectMake(0, 0, leftPadding + 5, leftPadding))
			txtField.leftView = paddingView
			txtField.leftViewMode = .Always
		}
		
		// Set right padding
		if rightPadding != 0 {
			let paddingView = UIView(frame: CGRectMake(0, 0, rightPadding + 5, rightPadding))
			txtField.rightView = paddingView
			txtField.rightViewMode = .Always
		}

	}
	
	// Configure UITextView
	class func configureTextView(txtView: UITextView, text: String?, font: UIFont?, textColor: UIColor?) {
		
		// Set text
		if text != nil {
			txtView.text = text
		}
		
		// Set font
		if font != nil {
			txtView.font = font
		}
		
		// Set text color
		if textColor != nil {
			txtView.textColor = textColor
		}
	}
    
    // Create Label
    class func createLabel(frame frame: CGRect, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, text: String) -> UILabel {
        let label = UILabel()
        
        label.frame         = frame
        label.font          = font
        label.textColor     = textColor
        label.textAlignment = textAlignment
        label.text          = text
        
        return label
    }
	
	// Set drop down shadow
    class func applyPlainShadow(view: UIView, radius: CGFloat, opacity: Float) {
		let layer = view.layer
		layer.shadowColor = UIColor.blackColor().CGColor
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowOpacity = opacity
		layer.shadowRadius = radius
	}
    
    // Start or Stop activity indicatior
    class func startStopIndicator(processing processing: Bool, activityIndicator: UIActivityIndicatorView) {
        if processing { activityIndicator.startAnimating() }
        else          { activityIndicator.stopAnimating()  }
    }
	
	// MARK: - OS
	
    // Get screen size
    class func getScreenSize() -> CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    // Get current Wi-Fi name
    class func fetchSSIDInfo() -> String {
        var currentSSID = String()
        if let interfaces = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces) {
                let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = interfaceData["SSID"] as! String
                }
            }
        }
        return currentSSID
    }
	
	// MARK: - Links and Share
	
    // Open link
    class func openLink(link: String) {
        let url = NSURL(string: link)!
        if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // Present share options
    class func shareTextImageAndURL(parentVC: UIViewController, sharingText: String?, sharingImage: UIImage?, sharingURL: NSURL?) {
        var sharingItems = [AnyObject]()
        
        if let text = sharingText {
            sharingItems.append(text)
        }
        if let image = sharingImage {
            sharingItems.append(image)
        }
        if let url = sharingURL {
            sharingItems.append(url)
        }
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        parentVC.presentViewController(activityViewController, animated: true, completion: nil)
    }
	
	// MARK: - Conversions
	
	// String to Int
	class func stringToInt(string: String) -> Int {
		let numberFromString = NSNumberFormatter().numberFromString(string)
		let int = numberFromString!.integerValue
		
		return int
	}
    
    // Seconds to Hours, Minutes and Seconds
    class func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    // String from string date
    class func stringFromStringDateWithDateFormat(format: String, dateString: String) -> String {
        let date = dateFromString(dateString)
        return stringFromDate(date, format: format)
    }

    // Date from String
    class func dateFromString(dateString: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        var dateString = dateString
        
        // Some date formats from API are with dots and some are with dash
        if dateString.containsString("."){
            let changedString = dateString.stringByReplacingOccurrencesOfString(".", withString: "-")
            dateString = changedString
        }
        
        // Set date dormat and zone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Europe/Belgrade")
        
        // Return date
        let date = dateFormatter.dateFromString(dateString)!
        return date
    }
    
    // String from Date
    class func stringFromDate(date: NSDate, format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        return dateFormatter.stringFromDate(date)
    }
    
    // Change constraint multiplier
    class func changeMultiplier(constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: constraint.firstItem,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: multiplier,
            constant: constraint.constant)
        
        newConstraint.priority = constraint.priority
        
        NSLayoutConstraint.deactivateConstraints([constraint])
        NSLayoutConstraint.activateConstraints([newConstraint])
        
        return newConstraint
    }
    
	// MARK: - UIAlertView
    
    // Show basic alert view
    class func showAlert(title title: String, message: String) {
        let vc = (UIApplication.sharedApplication().keyWindow?.rootViewController)!
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(action)
        vc.presentViewController(alert, animated: true, completion: nil)
	}
    
    // No internet alert view
    class func noInternet() {
        showAlert(title: Alert.TITLE_ERROR, message: "No internet")
    }
    
    // API error alert view
    class func apiError() {
        showAlert(title: Alert.TITLE_ERROR, message: "API error")
    }
	
	// MARK: - Support
	
	// Find and print Font Family
	class func printFontFamilies() {
		for family: String in UIFont.familyNames() {
			print("\(family)")
			for names: String in UIFont.fontNamesForFamilyName(family) {
				print("== \(names)")
			}
		}
	}
}