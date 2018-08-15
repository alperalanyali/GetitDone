//
//  OptinalSet.swift
//  GetitDone
//
//  Created by Alper on 8.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import Foundation

struct ButtonOptions : OptionSet{
    let rawValue: Int
    static let roundedButton = ButtonOptions(rawValue: 1 << 0)
    static let squareButton = ButtonOptions(rawValue: 1 << 1)
}
