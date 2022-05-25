//
//  NeumorphismView.swift
//  NeumorphismSample
//
//  Created by Hansub Yoo on 2022/05/24.
//

import UIKit

class NeumorphicView: UIView {
    
    var cornerRadius: CGFloat = 15
    
    // 검은 그림자
    // lazy 키워드로 호출될 때(init의 setupView 함수 내에서 insertSublayer의 인자값으로 호출될 때) 실행된다.
    lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
        darkShadow.shadowColor = UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.0).cgColor
        darkShadow.backgroundColor = UIColor.secondarySystemBackground.cgColor
        darkShadow.shadowOffset = CGSize(width: 2, height: 2)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 2
        darkShadow.cornerRadius = 15
        
        return darkShadow
    }()
    
    // 하얀 그림자
    lazy var lightShadow: CALayer = {
        let lightShadow = CALayer()
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.backgroundColor = UIColor.secondarySystemBackground.cgColor
        lightShadow.shadowOffset = CGSize(width: -2, height: -2)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 2
        lightShadow.cornerRadius = cornerRadius
        
        return lightShadow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = cornerRadius
        self.layer.insertSublayer(lightShadow, at: 0)
        self.layer.insertSublayer(darkShadow, at: 0)
    }
    
    /// 위치와 크기 재조정 함수
    override func layoutSubviews() {
        super.layoutSubviews()
        darkShadow.frame = self.bounds
        lightShadow.frame = self.bounds
    }
}

class NeumorphicInnerView: UIView {
    
    var cornerRadius: CGFloat = 15
    
    lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
        darkShadow.shadowOffset = CGSize(width: 5, height: 5)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 3
        darkShadow.cornerRadius = cornerRadius
        
        return darkShadow
    }()
    
    lazy var lightShadow: CALayer = {
        let lightShadow = CALayer()
        lightShadow.shadowOffset = CGSize(width: -5, height: -5)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 3
        lightShadow.cornerRadius = cornerRadius

        return lightShadow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.addSublayer(darkShadow)
        self.layer.addSublayer(lightShadow)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        darkShadow.frame = self.bounds
        lightShadow.frame = self.bounds
        
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy: -3), cornerRadius: cornerRadius)
        let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
        path.append(cutout)
        
        darkShadow.shadowPath = path.cgPath
        lightShadow.shadowPath = path.cgPath
        
        darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.9).cgColor
    }
}

extension UIColor {
    static let offWhite = UIColor(red: 225/255, green: 225/255, blue: 235/255, alpha: 1)
}
