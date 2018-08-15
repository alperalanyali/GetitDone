//
//  GDListCell.swift
//  GetitDone
//
//  Created by Alper on 9.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDListCell: UITableViewCell {

    var delegate: GDListCellDelegate?
    @objc func toggleStatus(){
        if let delegate = self.delegate, let toDo = self.toDo {
//            let newToDo = ToDo(id: toDo.id, title: textField.text!, status: !toDo.status)
//            delegate.toggleToDo(toDO: newToDo)
            CoreDataManager.shared.deleteToDo(id: toDo.id)
            CoreDataManager.shared.createToDo(id: toDo.id, title: textField.text!, status: !toDo.status)
            delegate.toggleToDo()
        }
    }
  
    
    

        let textField = GDTextField(placeholder: "ToDo", cornerRadius: 8, inset: 8)
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
        
    }()
    
   let box = GDCheckBox()
    
    
    var toDo: ToDo? {
        didSet{
            if let toDo = toDo {
                self.box.toggled = toDo.status
       
                self.textField.text = toDo.title
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         box.addTarget(self, action: #selector(self.toggleStatus), for: UIControlEvents.touchUpInside)

        addSubview(view)
        view.addSubview(textField)
        addSubview(box)
        setupCellUI()
        textField.delegate = self
        
    }
    
    private func setupCellUI(){
       
        selectionStyle = .none
        backgroundColor = .clear
        layer.cornerRadius = heightForCell / 2
        view.backgroundColor = .white
        
        view.topAnchor.constraint(equalTo: topAnchor, constant: viewTop).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: viewBottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        textField.topAnchor.constraint(equalTo: topAnchor, constant: textTop).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: textBottom).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
     
        
        
        box.trailingAnchor.constraint(equalTo: trailingAnchor, constant: checkTrailing).isActive = true
        box.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        box.widthAnchor.constraint(equalToConstant: checkWidth).isActive = true
        box.heightAnchor.constraint(equalTo: box.widthAnchor).isActive = true
        
        
        
       
       
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GDListCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


