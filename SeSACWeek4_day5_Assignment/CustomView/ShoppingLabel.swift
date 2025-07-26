//
//  ShoppingLabel.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/27/25.
//

import UIKit

class ShoppingLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("이건 애플꺼라 커스텀 불가")
    }
    
    init(textColor: UIColor, font: UIFont, numberOfLines: Int) {
        super.init(frame: .zero)
        
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
