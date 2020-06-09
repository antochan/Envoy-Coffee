//
//  Fonts.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

extension UIFont {
    class func main(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size)!
    }
    
    class func mainBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
}
