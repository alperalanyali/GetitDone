//
//  GDTableView.swift
//  GetitDone
//
//  Created by Alper on 9.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDTableView: UITableView {

    
    override init(frame: CGRect, style: UITableViewStyle){
        super.init(frame: frame, style: style)
        checkIfAutoLayout()
        backgroundColor = .clear
        separatorStyle = .none
    
        
     
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
