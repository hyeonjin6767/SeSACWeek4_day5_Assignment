//
//  ViewController.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/26/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
//    let maintitleNaviItem = UINavigationItem()
//    let maintitleNavigationBar = {
//        let navigationBar = UINavigationBar()
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        //navigationBar.titleTextAttributes =
//        return navigationBar
//    }
    let mainKeywordSearchBar = {
        let searchbar = UISearchBar()
        searchbar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 프로필, 상품, 태그 등", attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemGray3])
        searchbar.searchTextField.leftView?.tintColor = .systemGray3
        searchbar.searchBarStyle = .minimal
        searchbar.searchTextField.layer.cornerRadius = 10
        //searchbar.searchTextField.alpha = 0.9
        searchbar.searchTextField.backgroundColor = .darkGray
        return searchbar
    }()
    let mainImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        return imageView
    }()
    let mainLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "쇼핑하구팡"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHiearachy()
        configureLayout()
        configureView()
        self.navigationItem.title = "영캠러의 쇼핑쇼핑"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        //navigationController?.navigationItem.backButtonTitle = ""
    }
}

//검색어 전달
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let input = searchBar.text, input.count >= 2 else {
            print("2글자 미만 입력")
            return
        }
        let vc = ShoppingViewController()
        vc.searchBarToss = "\(searchBar.text!)"
        vc.shoppingCollectionView.reloadData()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: DesignProtocol {
    
    func configureHiearachy() {
        //view.addSubview(maintitleNaviItem)
        view.addSubview(mainKeywordSearchBar)
        view.addSubview(mainImageView)
        view.addSubview(mainLabel)
    }
    
    func configureLayout() {
        
        mainKeywordSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
        mainImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.top.equalTo(mainKeywordSearchBar.snp.bottom).offset(170)
            make.height.equalTo(230)
        }
        mainLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        mainImageView.image = UIImage(named: "쇼핑하구팡")
        mainKeywordSearchBar.delegate = self
    }
}
