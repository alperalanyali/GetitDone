//
//  NewItemPopup.swift
//  GetitDone
//
//  Created by Alper on 8.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDNewItemPopup: GDGradient {
    
    let cancelButton = GDButton(title: "   cancel   ", size: 10 , cornerRadius: 4,  type: .roundedButton)
    let addButton = GDButton(title: "  add  ", size: 10, cornerRadius: 4, type: .roundedButton)
    let textField = GDTextField( placeholder: "Go buy Ikea frames", inset: 15)
    var delegate:GDNewItemPopupDelegate?
    override init(frame:CGRect = .zero){
        super.init(frame: frame)
        
        addSubview(cancelButton)
        addSubview(addButton)
        addSubview(textField)
        setupUI()
        
        
        
        layer.cornerRadius = popupCorner
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner ]
        
        cancelButton.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(self.handleAdd), for: .touchUpInside)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animatePopup)))
    }
    
    private func setupUI(){
        cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: cancelTop).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cancelLeading).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: cancelHeight).isActive = true
        
        addButton.topAnchor.constraint(equalTo: topAnchor, constant: addTop).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: addTrailing).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: addHeight)
        
        
        
        textField.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: textFieldTop).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldLeading).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: textFieldTrailing).isActive = true
        
    }
    
    
    @objc func handleCancel(){
        textField.resignFirstResponder()
        self.textField.text = ""
        animatePopup()
        
    }
    @objc func handleAdd(){
     
        if textField.text != "" {
               let textFieldText = self.textField.text
            if let delegate = self.delegate   {
                delegate.addItemToList(text: textFieldText!)
            }
        } else {
            print("Empty textfield")
        }
        
     
    }
    var popupLocation: CGFloat = 70
    @objc func animatePopup() {
        textField.resignFirstResponder()
        self.animateView(transform: CGAffineTransform(translationX: 0, y: popupLocation), duration: 0.5)
        if popupLocation == 70 {
            popupLocation = 0
           
        } else {
            popupLocation = 70
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
