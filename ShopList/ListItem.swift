//
//  ListItem.swift
//  ShopList
//
//  Created by Serhii Pianykh on 2017-02-21.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation

class ListItem {
    
    private var _name: String?
    private var _qty: Int!
    private var _ref: FIRDatabaseReference?
    
    var name: String {
        get {
            if (_name == nil) {
                _name = ""
            }
            return _name!
        }
        set {
            _name = newValue
        }
    }
    var qty: Int! {
        get {
            if _qty == nil {
                _qty = 0
            }
            return _qty
        }
        set {
            _qty = newValue
        }
    }
    
    var ref: FIRDatabaseReference? {
        get {
            return _ref
        }
        set {
            _ref = newValue
        }
    }
    
    init(name: String) {
        self._name = name
        self._qty = 0
    }
    
    //creating item from snapshot taken from FBDB
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self._name = (snapshotValue["name"] as! String)
        self._qty = snapshotValue["qty"] as! Int
        _ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "qty": qty
        ]
    }
    
}
