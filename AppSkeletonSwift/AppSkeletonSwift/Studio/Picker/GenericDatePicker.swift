//
//  GenericDatePicker.swift
//

import UIKit

// CompletionHadnelr for date picker
typealias CompletionHandlerDate = (selectedDate: NSDate) -> Void

class GenericDatePicker: NSObject {

    var datePicker: UIDatePicker
    var compBlock: CompletionHandlerDate
    
    // Constructor
    init(currentDate: NSDate?, minimumDate: NSDate?, maximumDate: NSDate?, completion: CompletionHandlerDate) {
        
        // Initialize datePicker and compBlock
        datePicker = UIDatePicker()
        compBlock = completion

        super.init()
        
        // Set date pickers params
        datePicker.datePickerMode = .Date
        datePicker.locale = NSLocale.currentLocale()
        
        if currentDate != nil {
            datePicker.date = currentDate!
        }
        if minimumDate != nil {
            datePicker.minimumDate = minimumDate!
        }
        if maximumDate != nil {
            datePicker.maximumDate = maximumDate!
        }
        
        // Add action for value changed
        datePicker.addTarget(self, action: "dateChanged", forControlEvents: .ValueChanged)
    }
    
    // Date changed action
    func dateChanged() {
        compBlock(selectedDate: datePicker.date)
    }
}