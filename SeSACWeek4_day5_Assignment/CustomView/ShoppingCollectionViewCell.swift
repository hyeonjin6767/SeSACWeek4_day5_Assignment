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
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    let shoppingMallNameLabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        return label
    }()
    let shoppingTitleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.backgroundColor = .darkGray
        return label
    }()
    let shoppingPriceLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 10)
        label.backgroundColor = .orange
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
            make.height.equalTo(150)
        }
        shoppingMallNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(shoppoingImageView.snp.bottom).offset(5)
            make.height.equalTo(10)
        }
        shoppingTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(shoppingMallNameLabel.snp.bottom).offset(5)
            make.height.equalTo(10)
        }
        shoppingPriceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(shoppingTitleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(10)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
    }
}
