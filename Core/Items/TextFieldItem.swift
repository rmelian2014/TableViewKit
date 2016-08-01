//
//  TextFieldCell.swift
//  ExampleTableViewKit
//
//  Created by Alfredo Delli Bovi on 28/07/16.
//  Copyright © 2016 ODIGEO. All rights reserved.
//

import Foundation

public class TextFieldCell: TableViewCell {
    
    public var textFieldItem: TextFieldItem {
        get {
            return item as! TextFieldItem
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    override public func awakeFromNib() {
        
        super.awakeFromNib()
        
        selectionStyle = .None
        responder = textField
        
        textField.addTarget(self, action: #selector(onTextChange), forControlEvents: UIControlEvents.EditingChanged)
        textField.inputAccessoryView = actionBar
    }
    
    public func onTextChange(textField: UITextField) {
        textFieldItem.value = textField.text
    }

}

public class TextFieldItem: TableViewItem, ContentValidatable, Validationable {

    public lazy var validation: Validation<String?> = {
        return Validation<String?>(forInput: self, withIdentifier: self)
    }()
    
    public var placeHolder: String?
    public var value: String?
    
    override public init() {
        super.init()
        drawer = TextFieldDrawer()
        cellHeight = 44
    }
    
    public var validationContent: String? {
        get {
            return value
        }
    }
}

public class TextFieldDrawer: TableViewDrawerCellProtocol {
    
    public static let nib = UINib(nibName: String(TextFieldCell.self), bundle: NSBundle.tableViewKitBundle())
    public let cell = TableViewCellType.Nib(TextFieldDrawer.nib, TextFieldCell.self)
    
    public func draw(cell cell: TableViewCell, withItem item: TableViewItemProtocol) {

        let textCell = cell as! TextFieldCell
        let textItem = item as! TextFieldItem
        
        textCell.textField.placeholder = textItem.placeHolder
        textCell.textField.text = textItem.value
    }
}