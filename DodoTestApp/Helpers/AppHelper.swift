//
//  AppHelper.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit
import SwiftKeychainWrapper
import SwiftyJSON

struct Constant {
    
    //Fonts
    static let FONT_REGULAR = "CorpidE3SCd-Regular"
    static let FONT_LIGHT = "CorpidE3SCd-Light"
    static let FONT_BOLD = "CorpidE3SCd-Bold"
    
    //Fonts sizes
    static let SIZE_HEADER: CGFloat = 24
    static let SIZE_EXTRA_SMALL: CGFloat = 13
    static let SIZE_SMALL: CGFloat = 14
    static let SIZE_MEDIUM: CGFloat = UIScreen.main.bounds.width > 320 ? 16 : 14
    static let SIZE_LARGE: CGFloat = UIScreen.main.bounds.width > 320 ? 18 : 16
    static let SIZE_EXTRA_LARGE: CGFloat = UIScreen.main.bounds.width > 320 ? 20 : 18
    static let SIZE_EXTRA_EXTRA_LARGE: CGFloat = UIScreen.main.bounds.width > 320 ? 22 : 20
    static let SIZE_SUPER_LARGE: CGFloat = UIScreen.main.bounds.width > 320 ? 32 : 28
    static let SIZE_SUPER_LARGE_35: CGFloat = UIScreen.main.bounds.width > 320 ? 35 : 32
    static let SIZE_24: CGFloat = UIScreen.main.bounds.width > 320 ? 24 : 20
    static let SIZE_50: CGFloat = 50
    static let NAVIGATION_BAR_LARGE_TITLE: CGFloat = UIScreen.main.bounds.width > 320 ? 34 : 30
}
extension UIWindow {
    
    func getVisibleVC() -> UIViewController? {
        
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            return getVC(vc: vc)
        }
        
        return nil
    }
    
    private func getVC(vc: UIViewController) -> UIViewController? {
        
        if let vc = vc as? UITabBarController {
            return getVC(vc: vc.viewControllers![0])
        } else if let vc = vc as? UINavigationController {
            return vc.topViewController
        } else {
            return vc
        }
        
    }
    
}

extension UIColor {
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String {
    
    func replaceOccurrences(_ occurrences: [String]) -> String {
        
        var str = self
        
        for occur in occurrences {
            str = str.replacingOccurrences(of: occur, with: "")
        }
        
        print(str)
        
        return str
    }
    
}

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

extension CGFloat {
    
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
    
}
