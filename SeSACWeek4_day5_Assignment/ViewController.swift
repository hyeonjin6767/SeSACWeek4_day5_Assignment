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
        searchbar.placeholder = "브랜드, 프로필, 상품, 태그 등"
        searchbar.backgroundColor = .black
        searchbar.barTintColor = .darkGray
        searchbar.tintColor = .gray
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
        
//        maintitleNaviItem.titleView?.tintColor = .white
//        maintitleNaviItem.title = "영캠러의 쇼핑쇼핑"
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
        //ViewController.addSubview(maintitleNaviItem)
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
            make.top.equalTo(mainKeywordSearchBar.snp.bottom).offset(100)
            make.height.equalTo(200)
        }
        mainLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        mainKeywordSearchBar.delegate = self
        mainKeywordSearchBar.showsCancelButton = true
        //maintitleNaviItem.titleView?.backgroundColor = .green
        //maintitleNaviItem.title = "영캠러의 쇼핑쇼핑"
    }
}
