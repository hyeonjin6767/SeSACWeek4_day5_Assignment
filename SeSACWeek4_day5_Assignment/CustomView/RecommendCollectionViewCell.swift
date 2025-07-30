//
//  RecommendCollectionViewCell.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/29/25.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendCollectionViewCell"
    
    let recommendImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            //make.edges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.width.equalTo(100)
        }
    }
    
    func configureView() {
        
    }
    
}
