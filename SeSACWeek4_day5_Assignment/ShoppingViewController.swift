//
//  ShoppingViewController.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher

class ShoppingViewController: UIViewController {
    
    let shoppingList: ShoppingList = ShoppingList(items: [])
    
    let shoppingCollectionView = {
        let collectionView = UICollectionView()
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (16 * 2) - (16 * 1) //좌우여백 2개, 셀사이간격 1개
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/2) //셀 2개
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHiearachy()
        configureLayout()
        configureView()
        
    }
    
    //
}

extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        
        shoppingCollectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
    }
    
    func configureLayout() {
        shoppingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
}
