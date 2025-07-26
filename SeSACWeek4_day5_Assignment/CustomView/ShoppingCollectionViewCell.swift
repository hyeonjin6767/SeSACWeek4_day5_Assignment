//
//  ShoppingCollectionViewCell.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/26/25.
//

import UIKit
import SnapKit

class ShoppingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShoppingCollectionViewCell"
    
    let shoppoingImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15 //클래스로 빼보기
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    let shoppingMallNameLabel = {
        let label = ShoppingLabel(textColor: .white, font: .systemFont(ofSize: 12), numberOfLines: 0)
        //label.backgroundColor = .red
        return label
    }()
    let shoppingTitleLabel = {
        let label = ShoppingLabel(textColor: .white, font: .systemFont(ofSize: 15), numberOfLines: 2)
        //label.backgroundColor = .blue
        return label
    }()
    let shoppingPriceLabel = {
        let label = ShoppingLabel(textColor: .white, font: .boldSystemFont(ofSize: 17), numberOfLines: 0)
        //label.backgroundColor = .brown
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHiearachy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShoppingCollectionViewCell: DesignProtocol {
    
    func configureHiearachy() {
        contentView.addSubview(shoppoingImageView)
        contentView.addSubview(shoppingMallNameLabel)
        contentView.addSubview(shoppingTitleLabel)
        contentView.addSubview(shoppingPriceLabel)
    }
    
    func configureLayout() {
        shoppoingImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.width.equalTo(170)
        }
        shoppingMallNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(shoppoingImageView.snp.bottom).offset(5)
        }
        shoppingTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(shoppingMallNameLabel.snp.bottom).offset(5)
        }
        shoppingPriceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(shoppingTitleLabel.snp.bottom).offset(5)
            //make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(5)
        }
    }
    
    func configureView() {
        //contentView.backgroundColor = .orange
    }
}
