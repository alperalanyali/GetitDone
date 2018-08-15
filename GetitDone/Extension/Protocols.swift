//
//  Protocol.swift
//  GetitDone
//
//  Created by Alper on 8.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit


protocol GDHeaderDelegate {
    func openAddItemPopup()
}

protocol GDNewItemPopupDelegate{
    
    func addItemToList(text: String)
}

protocol GDListCellDelegate {
//    func toggleToDo(id: Int,status: Bool)
    func toggleToDo()
}
