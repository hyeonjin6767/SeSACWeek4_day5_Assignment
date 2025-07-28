//
//  BaseViewController.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/28/25.
//

import UIKit

class BaseViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Base", #function)

        setupHierarchy()
        setupLayout()
        setupView()

    }
    
    func setupHierarchy(){
        print("Base", #function)
        
    }
    
    func setupLayout(){
        print("Base", #function)

    }
    
    func setupView(){
        //view.backgroundColor = .white
        print("Base", #function)

    }
    
//    //aler같은 기능은 모든 뷰컨에 공통적으로 띄울 확률이 높으니
//    func showAlert() {
//        //얼럿기능
//    }
}

