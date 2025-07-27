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
    //var url = "https://openapi.naver.com/v1/search/shop.json?query="
    
    var shoppingList: ShoppingList = ShoppingList(items: [])
    var searchBarToss: String = ""
    
    let shoppingCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        //collectionView.backgroundColor = .purple
        collectionView.backgroundColor = .black
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (10 * 2) - (10 * 1) //좌우여백 2개, 셀사이간격 1개
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/1.5) //셀 2개
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
        return collectionView
    }()
    var sortButtonStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    let totalLabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    let sortSimButton = {
        let button = UIButton()
        button.setTitle("정확도", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    let sortDateButton = {
        let button = UIButton()
        button.setTitle("날짜순", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    let sortDscButton = {
        let button = UIButton()
        button.setTitle("가격높은순", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    let sortAscButton = {
        let button = UIButton()
        button.setTitle("가격낮은순", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHiearachy()
        configureLayout()
        configureView()
        
        self.navigationItem.title = "\(searchBarToss)"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.backgroundColor = .black
        
        callRequst(sort: "")
        
        sortSimButton.addTarget(self, action: #selector(sortSimButtomClicked), for: .touchUpInside)
        sortDateButton.addTarget(self, action: #selector(sortDateButtomClicked), for: .touchUpInside)
        sortDscButton.addTarget(self, action: #selector(sortDscButtomClicked), for: .touchUpInside)
        sortAscButton.addTarget(self, action: #selector(sortAscButtomClicked), for: .touchUpInside)
    }
    
    @objc func sortSimButtomClicked() {
        print("정확도 버튼 눌림")
        callRequst(sort: "&start=1&sort=sim")
    }
    @objc func sortDateButtomClicked() {
        print("날짜순 버튼 눌림")
        callRequst(sort: "&start=1&sort=date")
    }
    @objc func sortDscButtomClicked() {
        print("가격높은순 버튼 눌림")
        callRequst(sort: "&start=1&sort=dsc")
    }
    @objc func sortAscButtomClicked() {
        print("가격낮은순 버튼 눌림")
        callRequst(sort: "&start=1&sort=asc")
    }
    
    //네이버 API 요청
    func callRequst(sort: String) {
        print(#function, "첫번째")
        var url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchBarToss)&display=100"
        if sort == "" {
            print("정렬버튼X")
        } else {
            url.append(sort)
        }
        //url.append("\(query)&display=100")
        print("url체크 : \(url)")
        let header: HTTPHeaders = ["X-Naver-Client-Id": "xA5LXXctMDL0kfcaEa4x",
                                   "X-Naver-Client-Secret": "xspwBdaWWj"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShoppingList.self) { response in
            print(#function, "두번째")
                print("url체크 : \(url)")
            switch response.result {
            case .success(let value):
                print("success")
                
                url.removeLast(18) //함정: 100개에서 10로 바뀜...........................
                print("url삭제체크 : \(url)")
                
                dump(value)
                self.shoppingList = value
                self.shoppingCollectionView.reloadData()
    
            case .failure(let error):
                print("fail", error)
            }
        }
        print(#function, "세번째")
        print("url체크 : \(url)")
    }
}

extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        totalLabel.text = "\(shoppingList.items.count)개의 검색결과"
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
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        
        view.addSubview(shoppingCollectionView)
        view.addSubview(totalLabel)
        view.addSubview(sortButtonStackView)
        sortButtonStackView.addArrangedSubview(sortSimButton)
        sortButtonStackView.addArrangedSubview(sortDateButton)
        sortButtonStackView.addArrangedSubview(sortDscButton)
        sortButtonStackView.addArrangedSubview(sortAscButton)
//
//        view.addSubview(sortSimButton)
//        view.addSubview(sortDateButton)
//        view.addSubview(sortAscButton)
//        view.addSubview(sortDscButton)
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(20)
        }
        sortButtonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(totalLabel.snp.bottom).offset(5)
            make.bottom.equalTo(shoppingCollectionView.snp.top).offset(5)
            make.height.equalTo(50)
        }
        
        //글자 길이만큼 바뀌는 동적 높이에서 부등호 설정은 어떻게?
        
//        sortSimButton.snp.makeConstraints { make in
//            make.top.equalTo(totalLabel.snp.bottom).inset(5)
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
//            make.bottom.equalTo(shoppingCollectionView.snp.top).inset(5)
//            //make.width.equalTo(60)
//            make.trailing.equalTo(sortDateButton.snp.left).offset(10)
//            make.height.equalTo(30)
//        }
//        sortDateButton.snp.makeConstraints { make in
//            make.top.equalTo(totalLabel.snp.bottom).inset(5)
//            make.leading.equalTo(sortSimButton.snp.right).offset(10)
//            make.bottom.equalTo(shoppingCollectionView.snp.top).inset(5)
//
//            make.trailing.equalTo(sortAscButton.snp.left).offset(10)
//            make.height.equalTo(30)
//        }
//        sortAscButton.snp.makeConstraints { make in
//            make.top.equalTo(totalLabel.snp.bottom).inset(5)
//            make.leading.equalTo(sortDateButton.snp.right).offset(10)
//            make.bottom.equalTo(shoppingCollectionView.snp.top).inset(5)
//
//            make.trailing.equalTo(sortDscButton.snp.left).offset(10)
//            make.height.equalTo(30)
//        }
//        sortDscButton.snp.makeConstraints { make in
//            make.top.equalTo(totalLabel.snp.bottom).inset(5)
//            make.leading.equalTo(sortAscButton.snp.right)
//            make.bottom.equalTo(shoppingCollectionView.snp.top).inset(5)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
//            make.height.equalTo(30)
//        }
        shoppingCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(sortButtonStackView.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            //make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        //shoppingCollectionView.keyboardDismissMode = .onDrag
    }
}
