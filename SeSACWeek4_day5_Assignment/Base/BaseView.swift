//
//  BaseView.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/28/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
   
    @available(*, unavailable) //버전대응할 때 사용 : unavailable은 "앞으로 안쓸꺼다"라고
    required init?(coder: NSCoder) {  //이건 안쓰는거니까
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    func configureLayout() {
        
    }
    func configureView() {
        
    }
}
