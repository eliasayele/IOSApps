//
//  Extension.swift
//  Messanger
//
//  Created by Meheretab M on 24/08/2021.
//

import Foundation
import UIKit

////make extnestion for future user not to duplicate lines of codes
extension UIView {
    public var width: CGFloat{
        return self.frame.size.width
    }
    public var height: CGFloat{
        return self.frame.size.height
    }
    public var top: CGFloat{
        return self.frame.origin.y
    }
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat{
        return self.frame.origin.x
    }
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}
