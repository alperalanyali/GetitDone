//
//  GDLabel.swift
//  GetitDone
//
//  Created by Alper on 6.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDLabel: UILabel {

    
    
    init(title: String = "Default text",color: UIColor = .white,size: CGFloat = 18,frame: CGRect = .zero, textAlign: NSTextAlignment = .left){
        super.init(frame: frame)
        
        if frame == .zero {
            translatesAutoresizingMaskIntoConstraints = false
        }
        self.text = title
        self.textColor = color
        self.font = UIFont.init(name: "Raleway-v4020-SemiBold", size: size)
        self.textAlignment = textAlign
        numberOfLines = 5
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
