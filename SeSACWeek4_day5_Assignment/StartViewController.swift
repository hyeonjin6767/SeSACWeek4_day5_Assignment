//
//  StartViewController.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/27/25.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    let startButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHiearachy()
        configureLayout()
        configureView()
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StartViewController : DesignProtocol {
    func configureHiearachy() {
        view.addSubview(startButton)
    }
    
    func configureLayout() {
        startButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(30)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        startButton.setTitle(" GoShopping ", for: .normal)
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.white.cgColor
    }
}
