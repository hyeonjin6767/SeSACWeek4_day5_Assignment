//
//  SortButton.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/27/25.
//

import UIKit

class SortButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(setTitle: String) {
        super.init(frame: .zero)
        
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
