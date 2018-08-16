//
//  ViewController.swift
//  GetitDone
//
//  Created by Alper on 6.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let bg: UIView = {
        let view = GDGradient()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = bgCorner
        return view
        
    }()
    
    let titleLabel = GDLabel(title: "GET IT DONE", size: 36, textAlign: .center)
    let infoLabel: GDLabel = {
        let label  = GDLabel(title: "WELCOME,\n GET IT DONE IS A TO DO APP", color: .white, size: 20, textAlign: .center)
        label.numberOfLines = 2
        return label
    }()
    
    let copyright: GDLabel = {
        let label = GDLabel(title: "© 2018 | AlperAlanyali", color: .grayOne, size: 14,textAlign: .center)
        return label
    }()
    
    let nextButton = GDButton(title: "STARTING WINNING", size: 14, cornerRadius: nextCorner, type: .roundedButton)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "view-controller-visited")
        
        view.backgroundColor = .white
        
        view.addSubview(bg)
        bg.addSubview(titleLabel)
        bg.addSubview(infoLabel)
        bg.addSubview(nextButton)
        view.addSubview(copyright)
        setupUI()
        
        nextButton.addTarget(self, action: #selector(self.handleNext), for: .touchUpInside)
        
        bg.alpha = 0
        titleLabel.alpha = 0
        infoLabel.alpha = 0
        nextButton.alpha = 0
        copyright.alpha = 0
        
    }
    
    private func setupUI(){
        
        bg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: bgLeading).isActive = true
        bg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: bgTopAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bgBottomAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: bgTrailingAnchor).isActive = true
        
        titleLabel.widthAnchor.constraint(equalToConstant: titleWidth).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: titleHeight).isActive = true
        titleLabel.topAnchor.constraint(equalTo: bg.topAnchor, constant: titleTopAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        
        infoLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: infoWidth).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: infoHeight).isActive = true
        
        nextButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: nextBottomAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: nextWidth).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: nextHeight).isActive = true
        
        copyright.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: copyrightBottonAnchor).isActive = true
        copyright.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseIn, animations: {
            self.bg.alpha = 1
            self.copyright.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseIn, animations: {
                self.titleLabel.alpha = 1
                self.infoLabel.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseIn, animations: {
                    self.nextButton.alpha = 1
                }, completion: nil)
            })
        }
    }
 
    @objc func handleNext(){
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
            self.nextButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
                self.nextButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
                    self.nextButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: { (true) in
                    self.present(ListVC(), animated: true, completion: nil)
                })
            })
        }
    }
    
}

