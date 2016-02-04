//
//  GenericPicker.swift
//

import UIKit

// CompletionHadnelr for picker view
typealias CompletionHandlerPicker = (selectedString: String, selectedRow: Int, selectedComponent: Int) -> Void

class GenericPicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Properies
    var pickerView: UIPickerView
    var data: NSArray
    var compBlock: CompletionHandlerPicker
    
    // Constructor
    init(pickerData: NSArray, completion: CompletionHandlerPicker) {
        
        // Initialize pickerView, data and compBlock
        pickerView = UIPickerView()
        data = pickerData
        compBlock = completion

        super.init()
        
        // Set picker view data source and delegate
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // Number of components in picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if data[0] is NSArray {
            return data.count
        } else {
            return 1
        }
    }
    
    // Number of rows in each component
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if data[component] is NSArray {
            return data[component].count
        } else {
            return data.count
        }
    }
    
    // Title for row in component
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if data[component] is NSArray {
            return (data[component] as! NSArray)[row] as? String
        } else {
            return data[row] as? String
        }
    }
	
	// Set row height
	func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 44.0
	}
    
    // View for row in component
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        // Get view as UILabel View
        var retval = view as? UILabel
        if retval == nil {
            retval = UILabel(frame: CGRectMake(8.0, 0.0, pickerView.rowSizeForComponent(component).width - 16.0, pickerView.rowSizeForComponent(component).height))
        }
		
		// Configure label (optional)
		Utils.configureLabel(retval!, text: nil, font: nil, textColor: nil)
        
        // Check data type
        if data[component] is NSArray {
            retval!.text = (data[component] as! NSArray)[row] as? String
        } else {
            retval!.text = data[row] as? String
        }
        
        // Set text alignment
        retval!.textAlignment = .Center
        
        return retval!
    }

    // Did select row in component
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if data[component] is NSArray {
            compBlock(selectedString: (data[component] as! NSArray)[row] as! String, selectedRow: row, selectedComponent: component)
        } else {
            compBlock(selectedString: data[row] as! String, selectedRow: row, selectedComponent: 0)
        }
    }
}