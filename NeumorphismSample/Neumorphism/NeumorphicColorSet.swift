//
//  NeumorphicColorSet.swift
//  NeumorphismSample
//
//  Created by Hansub Yoo on 4/13/25.
//

import UIKit

struct NeumorphicColorSet {
    let backgroundColor: UIColor
    let darkShadowColor: UIColor
    let lightShadowColor: UIColor
    
    static let `default` = NeumorphicColorSet(
        backgroundColor: .secondarySystemBackground,
        darkShadowColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor.black.withAlphaComponent(0.5)
            : UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.0)
        },
        lightShadowColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.1)
            : .white
        }
    )
}
