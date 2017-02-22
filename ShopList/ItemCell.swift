//
//  ItemCell.swift
//  ShopList
//
//  Created by Serhii Pianykh on 2017-02-21.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell, UITextFieldDelegate {
    
    //closures for cell actions
    var nameChangedAction: ((UITableViewCell) -> Void)?
    var qtyChangedAction: ((UITableViewCell) -> Void)?

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    func configureCell(item: ListItem) {
        nameField.text = item.name
        qtyLabel.text = "Qty: \(item.qty!)"
        stepper.value = Double(item.qty)
    }

    
    @IBAction func updateName(_ sender: Any) {
        nameChangedAction!(self)
    }

    func changeQty(item: ListItem) {
        item.qty = Int(stepper.value)
        item.ref?.updateChildValues(item.toAnyObject() as! [AnyHashable : Any])
    }
    
    @IBAction func qtyChanged(_ sender: Any) {
        qtyChangedAction!(self)
    }
    
    func changeName(item: ListItem) {
        item.name = nameField.text!
        item.ref?.updateChildValues(item.toAnyObject() as! [AnyHashable : Any])
    }
}
