//
//  CustomLabel.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class CustomLabel: UILabel {

    init(text: String? = nil, textColor: UIColor, font: UIFont? = UIFont(name: Constant.FONT_REGULAR, size: Constant.SIZE_MEDIUM), lines: Int = 0, textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = lines
        self.textAlignment = textAlignment
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

