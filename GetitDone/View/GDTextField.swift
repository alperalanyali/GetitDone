//
//  GDTextField.swift
//  GetitDone
//
//  Created by Alper on 8.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDTextField: UITextField {

    var cornerRadius: CGFloat!
    var insets: UIEdgeInsets!
    
    init(frame: CGRect = .zero, placeholder: String = "Placeholder", cornerRadius: CGFloat = 4, inset: CGFloat = 0){
        super.init(frame:frame)
        checkIfAutoLayout()
        self.cornerRadius = cornerRadius
        self.placeholder = placeholder
        self.insets = UIEdgeInsetsMake(0, inset, 0, 0)
        
        setupUI()
        
    }
    private func setupUI(){
        backgroundColor = .white
        
        textColor = .gray
        layer.cornerRadius = cornerRadius
    }
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,self.insets )
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
         return UIEdgeInsetsInsetRect(bounds, self.insets)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
          return UIEdgeInsetsInsetRect(bounds, self.insets)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
