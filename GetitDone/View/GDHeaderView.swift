//
//  GDHeaderView.swift
//  GetitDone
//
//  Created by Alper on 7.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class GDHeaderView: UIView {
    
    
    let bg = GDGradient()
    let titleLabel = GDLabel( size: 14)
    let subtitleLabel = GDLabel( size: 24)
    let addButton = GDButton( size: 36, cornerRadius: 0, type: .squareButton)
    var delegate: GDHeaderDelegate?
    
    init(frame: CGRect = .zero, title: String = "Header", subtitle: String = "Header Subtitle"){
        super.init(frame: frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        setupLayout()
    
    }
    
    var itemsLeft: Int = 0 {
        didSet{
            self.subtitleLabel.text = "\(itemsLeft) Left"
        }
    }
    
    func setupLayout(){
        addSubview(bg)
        bg.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bg.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bgLeading + 16).isActive = true
        
        titleLabel.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 25).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bgLeading + 8).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(addButton)
        
        addButton.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: addButtonBottom).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: addButtonTrailing ).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: addButtonHeight).isActive = true
       addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor, multiplier: 1).isActive = true
        
        addButton.addTarget(self, action: #selector(self.handleAddButton), for: .touchUpInside)
    }
    
    @objc func handleAddButton() {
        if let delegate = self.delegate {
            delegate.openAddItemPopup()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
