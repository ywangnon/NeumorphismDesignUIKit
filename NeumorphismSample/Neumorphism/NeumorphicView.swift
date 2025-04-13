//
//  NeumorphicView.swift
//  NeumorphismSample
//
//  Created by Hansub Yoo on 4/13/25.
//

import UIKit

enum NeumorphicStyle {
    case outer
    case inner
}

class NeumorphicView: UIView {
    
    var style: NeumorphicStyle = .outer {
        didSet { animateStyleChange() }
    }
    
    var cornerRadius: CGFloat = 15 {
        didSet { updateCornerRadius() }
    }
    
    var colorSet: NeumorphicColorSet = .default {
        didSet { updateColors() }
    }
    
    private lazy var darkShadow: CALayer = createShadowLayer()
    private lazy var lightShadow: CALayer = createShadowLayer()
    
    init(style: NeumorphicStyle = .outer, colorSet: NeumorphicColorSet = .default) {
        self.style = style
        self.colorSet = colorSet
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = colorSet.backgroundColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = (style == .inner)
        
        layer.insertSublayer(lightShadow, at: 0)
        layer.insertSublayer(darkShadow, at: 0)
        
        setupShadowStyle()
    }
    
    private func createShadowLayer() -> CALayer {
        let layer = CALayer()
        layer.shadowOpacity = 1
        layer.cornerRadius = cornerRadius
        return layer
    }
    
    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
        darkShadow.cornerRadius = cornerRadius
        lightShadow.cornerRadius = cornerRadius
        setNeedsLayout()
    }
    
    private func updateColors() {
        backgroundColor = colorSet.backgroundColor
        setupShadowStyle()
    }
    
    private func animateStyleChange() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.25)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        
        setupShadowStyle()
        
        CATransaction.commit()
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupShadowStyle() {
        switch style {
        case .outer:
            layer.masksToBounds = false
            darkShadow.shadowOffset = CGSize(width: 2, height: 2)
            darkShadow.shadowRadius = 2
            darkShadow.shadowColor = colorSet.darkShadowColor.cgColor
            darkShadow.backgroundColor = colorSet.backgroundColor.cgColor
            
            lightShadow.shadowOffset = CGSize(width: -2, height: -2)
            lightShadow.shadowRadius = 2
            lightShadow.shadowColor = colorSet.lightShadowColor.cgColor
            lightShadow.backgroundColor = colorSet.backgroundColor.cgColor
            
        case .inner:
            layer.masksToBounds = true
            darkShadow.shadowOffset = CGSize(width: 5, height: 5)
            darkShadow.shadowRadius = 3
            darkShadow.shadowColor = colorSet.darkShadowColor.cgColor
            darkShadow.backgroundColor = nil
            
            lightShadow.shadowOffset = CGSize(width: -5, height: -5)
            lightShadow.shadowRadius = 3
            lightShadow.shadowColor = colorSet.lightShadowColor.cgColor
            lightShadow.backgroundColor = nil
        }
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        darkShadow.frame = bounds
        lightShadow.frame = bounds
        
        if style == .inner {
            let outerPath = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy: -3), cornerRadius: cornerRadius)
            let cutoutPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
            outerPath.append(cutoutPath)
            
            darkShadow.shadowPath = outerPath.cgPath
            lightShadow.shadowPath = outerPath.cgPath
        } else {
            darkShadow.shadowPath = nil
            lightShadow.shadowPath = nil
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }
}
