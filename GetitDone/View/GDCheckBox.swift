//
//  GDCheckBox.swift
//  GetitDone
//
//  Created by Alper on 12.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDCheckBox: UIButton {

   

    var toggled: Bool? {
        didSet{
            UIView.animate(withDuration: 0.2) {
                if let toggled  = self.toggled {
                    if toggled == true {
                        self.backgroundColor = .green
                        self.setImage(UIImage(named: "done-icon"), for: .normal)
                    } else {
                        self.backgroundColor = .clear
                        self.setImage(UIImage(), for: .normal)
                    }
                    
                }
            }
            
        }
    }
  
    override init(frame:CGRect ){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = checkBorderWidth
        layer.borderColor = UIColor.grayZero.cgColor
        layer.cornerRadius = 4
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
