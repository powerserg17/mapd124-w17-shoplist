//
//  CartVC.swift
//  ShopList
//  300907406
//  Created by Serhii Pianykh on 2017-02-21.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//  View Controller for main view with list items

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var itemsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var listNameField: UITextField!
    @IBOutlet weak var listNameApplyBtn: UIButton!
    
    
    var listRef: FIRDatabaseReference? = nil
    var userRef: FIRDatabaseReference? = nil
    let storageRef = FIRDatabase.database().reference(withPath: "storage")
    var listName: String? = nil
    
    var list = [ListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //assigning current user to his storage
        userRef = storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        listRef = userRef?.child("list")
        userRef?.observe(.value, with: { snapshot in
            if !snapshot.exists() {
                return
            }
            if let name = snapshot.childSnapshot(forPath: "listName").value as? String {
                self.listName = name
                 self.showListName(name: self.listName!)
            }
        })
        

        listRef?.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
            var newItems = [ListItem]()
            for item in snapshot.children {
                let item = ListItem(snapshot: item as! FIRDataSnapshot)
                newItems.append(item)
            }
            self.list = newItems
            self.tableView.reloadData()

        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell {
            let item = list[indexPath.row]
            
            cell.qtyChangedAction = { (self) in
                cell.changeQty(item: item)
            }
            
            cell.nameChangedAction = { (self) in
                cell.changeName(item: item)
            }
            
            cell.configureCell(item: item)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    @IBAction func applyListName(_ sender: UIButton) {
        let listName = ["listName":listNameField.text!]
        userRef?.setValue(listName)
        showListName(name: listNameField.text!)
    }
    
    func showListName(name: String) {
        listNameLabel.text = name
        listNameLabel.isHidden = false
        listNameField.isHidden = true
        listNameApplyBtn.isHidden = true
        itemsView.isHidden = false
    }
    
    
    @IBAction func addPressed(_ sender: UIButton) {
        let item = ListItem(name: "")
        let itemRef = self.listRef!.childByAutoId()
        item.ref = itemRef
        itemRef.setValue(item.toAnyObject())
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = list[indexPath.row]
            item.ref?.removeValue()

        }
    }
    
 
    @IBAction func resetPressed(_ sender: Any) {
        userRef?.removeValue()
        hideAll()
    }
    
    func hideAll() {
        itemsView.isHidden = true
        listNameLabel.isHidden = true
        listNameField.isHidden = false
        listNameApplyBtn.isHidden = false
    }
    
}
