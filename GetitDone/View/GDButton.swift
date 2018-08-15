//
//  GDButton.swift
//  GetitDone
//
//  Created by Alper on 7.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDButton: UIButton {
    
    var title: String!
    var size: CGFloat!
    var cornerRadius: CGFloat!
    var type: ButtonOptions!
    
    init(title:String = "Button", size: CGFloat,cornerRadius: CGFloat = 0,frame: CGRect = .zero, type: ButtonOptions = .roundedButton ){
        super.init(frame: frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.title = title
        self.size = size
        self.cornerRadius = cornerRadius
        self.type = type
        self.phaseTwo()
        
        
    }
    
    func phaseTwo(){
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.grayZero, for: .normal)
        self.backgroundColor = .white
        self.titleLabel?.font = UIFont.init(name: "Raleway-v4020-SemiBold", size: size)
        switch type {
        case .roundedButton:
            self.roundButton()
        case.squareButton:
            self.squareIcon()
        default:
            break
        }
    }
    
    func roundButton() {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.grayZero, for: .normal)
        self.layer.cornerRadius = cornerRadius
      
        
    }
    func squareIcon(){
        self.setImage(UIImage(named: "add-icon"), for: .normal)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
