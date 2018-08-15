//
//  ListVC.swift
//  GetitDone
//
//  Created by Alper on 7.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class ListVC: UIViewController, GDHeaderDelegate,GDNewItemPopupDelegate  {

    let header = GDHeaderView(title: "Stuff to get done", subtitle: "4 left")
    let popup = GDNewItemPopup()
    let bg: UIView = {
        let view = GDGradient()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = bgCorner
        return view
        
    }()
    
    let listTable = GDTableView()
    let CELL_ID = "cell_id"
    var listData: [ToDo] = [ToDo]()
    var toDoToUpdate:ToDo?
    var keyboardHeight: CGFloat = 258
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listData = CoreDataManager.shared.fetchToDos()
        
        self.updateHeaderItemsLeft()
        
        view.backgroundColor = .white
        view.addSubview(header)
        view.addSubview(popup)
        view.addSubview(bg)
        view.addSubview(listTable)
        setupUI()
        header.delegate = self
        
        listTable.delegate = self
        listTable.dataSource = self
        listTable.register(GDListCell.self, forCellReuseIdentifier: CELL_ID)
        
        popup.textField.delegate = self
        popup.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    @objc func keyboardWillShow(notification: Notification){
        let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.keyboardHeight = keyboardSize.height
        popup.sendSubview(toBack: listTable)

    }
    
    func updateHeaderItemsLeft(){
        header.itemsLeft = 0
        listData.forEach { (toDo) in
            if !toDo.status {
                header.itemsLeft += 1
            }
        }
    }
    var bgBottom: NSLayoutConstraint!
    func setupUI(){
        
        view.backgroundColor = .white
        
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        bg.topAnchor.constraint(equalTo: header.bottomAnchor, constant: tableBgTop).isActive = true
        bgBottom = bg.bottomAnchor.constraint(equalTo: popup.topAnchor, constant: tableBgBottom)
        bgBottom.isActive = true
        bg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tableBgLeading).isActive = true
        bg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: tableBgTrailing).isActive = true
        
        listTable.topAnchor.constraint(equalTo: bg.topAnchor, constant: tableTop).isActive = true
        listTable.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: tableBottom).isActive = true
        listTable.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: tableLeading).isActive = true
        listTable.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: tableTrailing).isActive = true
        
        popup.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        popup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: popupLeading).isActive = true
        popup.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: popupTrailing).isActive = true
        popup.heightAnchor.constraint(equalToConstant: popupHeight ).isActive = true
        openAddItemPopup()
     
    }
    
    func openAddItemPopup() {
        popup.animatePopup()
       view.bringSubview(toFront: popup)
    }
    
    
    func addItemToList(text: String) {
        if text != "" {
            if notInList(text: text){
    
                CoreDataManager.shared.createToDo(id: Double(self.listData.count), title: text, status: false)
                self.listData = CoreDataManager.shared.fetchToDos()
                self.listTable.reloadData()
                self.updateHeaderItemsLeft()
                self.popup.textField.text = ""
                self.popup.animatePopup()
            }
        }
    }
    func notInList(text: String) -> Bool {
        var isNotInList: Bool = true
        self.listData.forEach { (toDo) in
            if toDo.title == text {
              isNotInList = false
            }
        }
        return isNotInList
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    

    
}


extension ListVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        var heightToAnimate = -keyboardHeight + 40
        if textField == popup.textField{
             self.popup.animateView(transform: CGAffineTransform(translationX: 0, y: -1*(keyboardHeight)), duration: 0.58)
            heightToAnimate -= 60
        } else {
            self.toDoToUpdate = CoreDataManager.shared.fetchTodo(title: textField.text!)
            
        }
        self.bgBottom.constant = heightToAnimate
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }

}
    func textFieldDidEndEditing(_ textField: UITextField) {
       
         self.bgBottom.constant = -100
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
        if textField == popup.textField {
            self.popup.animateView(transform: CGAffineTransform(translationX: 0, y: 0),duration: 0.58)
    
        } else {
            if let toDoToUpdate = self.toDoToUpdate{
                CoreDataManager.shared.deleteToDo(id: toDoToUpdate.id)
                CoreDataManager.shared.createToDo(id: toDoToUpdate.id, title: textField.text!, status: toDoToUpdate.status)
            }
        }
       
        
    }

}


extension ListVC: UITableViewDelegate, UITableViewDataSource, GDListCellDelegate {
    func toggleToDo() {

        self.listData = CoreDataManager.shared.fetchToDos()
        self.listTable.reloadData()
        self.updateHeaderItemsLeft()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        return "Done"
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let titleForHeader = GDLabel( color: .white,size: 18, frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        if section == 0 {
            titleForHeader.text = "To Do"
            titleForHeader.backgroundColor = .clear
            
        } else {
            titleForHeader.text = "Done"
            
        }
        return titleForHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        self.listData.forEach { (toDo) in
            if section == 0 && !toDo.status {
                count += 1
            } else if section == 1 && toDo.status {
                count += 1
            }
        }
        
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as! GDListCell
        
        var itemForSection: [ToDo] = []
        cell.delegate = self
        cell.textField.delegate = self
        self.listData.forEach { (toDo) in
            if indexPath.section == 0 && !toDo.status {
                itemForSection.append(toDo)
            } else if indexPath.section == 1 && toDo.status {
                itemForSection.append(toDo)
            }
        }
        cell.toDo = itemForSection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
    
}
