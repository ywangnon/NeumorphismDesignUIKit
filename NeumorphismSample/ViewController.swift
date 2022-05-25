//
//  ViewController.swift
//  NeumorphismSample
//
//  Created by Hansub Yoo on 2022/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    var neumorphicView: NeumorphicView = {
        let view = NeumorphicView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var selectedNeumorphicView: NeumorphicInnerView = {
        let view = NeumorphicInnerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundations()
        self.setAddSubViews()
        self.setLayouts()
        self.setDelegates()
        self.setAddTargets()
        self.setGestures()
    }
    
    func setViewFoundations() {
        self.view.backgroundColor = .secondarySystemBackground
    }
    
    func setAddSubViews() {
        self.view.addSubview(neumorphicView)
        self.view.addSubview(selectedNeumorphicView)
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            self.neumorphicView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.neumorphicView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.neumorphicView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.neumorphicView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.selectedNeumorphicView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.selectedNeumorphicView.topAnchor.constraint(equalTo: self.neumorphicView.bottomAnchor, constant: 40),
            self.selectedNeumorphicView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.selectedNeumorphicView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setDelegates() {
        
    }
    
    func setAddTargets() {
        
    }
    
    func setGestures() {
        
    }
}

