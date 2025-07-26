//
//  ShoppingViewController.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class ShoppingViewController: UIViewController {
    
    static let identifier = "ShoppingViewController"
    
    var shoppingList: ShoppingList = ShoppingList(items: [])
    var searchBarToss: String = ""
    
    let shoppingCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (10 * 2) - (10 * 1) //좌우여백 2개, 셀사이간격 1개
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/1.5) //셀 2개
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHiearachy()
        configureLayout()
        configureView()
        
        print("전달 받은 검색어: \(searchBarToss)")
        callRequst(query: searchBarToss)
    }
    
    //네이버 API 요청
    func callRequst(query: String) {
        print(#function, "첫번째")
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=10" //100개로 변경
        let header: HTTPHeaders = ["X-Naver-Client-Id": "xA5LXXctMDL0kfcaEa4x",
                                   "X-Naver-Client-Secret": "xspwBdaWWj"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShoppingList.self) { response in
            print(#function, "두번째")
            switch response.result {
            case .success(let value):
                print("success")
                
                dump(value)
                self.shoppingList = value
                self.shoppingCollectionView.reloadData()
    
            case .failure(let error):
                print("fail", error)
            }
        }
        print(#function, "세번째")
    }
}

extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function, "\(shoppingList.items.count)개")
        return shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCollectionViewCell.identifier, for: indexPath) as! ShoppingCollectionViewCell
        let url = URL(string: shoppingList.items[indexPath.item].image)
        cell.shoppoingImageView.kf.setImage(with: url)
        cell.shoppingMallNameLabel.text = shoppingList.items[indexPath.item].mallName
        cell.shoppingTitleLabel.text = shoppingList.items[indexPath.item].title
        cell.shoppingPriceLabel.text = shoppingList.items[indexPath.item].lprice
        return cell
    }
}

extension ShoppingViewController: DesignProtocol {
    
    func configureHiearachy() {
        view.addSubview(shoppingCollectionView)
        
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        
    }
    
    func configureLayout() {
        shoppingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        shoppingCollectionView.keyboardDismissMode = .onDrag
    }
}
