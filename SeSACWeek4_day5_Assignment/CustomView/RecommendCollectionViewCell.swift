//
//  RecommendCollectionViewCell.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/29/25.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendCollectionViewCell"
    
    let recommendImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 30
        imageView.layer.borderColor = UIColor.yellow.cgColor
        return imageView
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

extension RecommendCollectionViewCell: DesignProtocol {
    
    func configureHiearachy() {
        contentView.addSubview(recommendImageView)
    }
    
    func configureLayout() {
        recommendImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        
    }
    
}
