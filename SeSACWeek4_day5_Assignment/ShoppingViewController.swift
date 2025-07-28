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
    
    var list: [ProductsList] = []
    var total: Int = 0
    var page = 1
    var count = 0

    
    //var shoppingList: [ProductsList] = []
    var searchBarToss: String = ""
    let priceFormat = NumberFormatter()
    
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
        let button = SortButton(setTitle: "정확도")
        return button
    }()
    let sortDateButton = {
        let button = SortButton(setTitle: "날짜순")
        return button
    }()
    let sortDscButton = {
        let button = SortButton(setTitle: "가격높은순")
        return button
    }()
    let sortAscButton = {
        let button = SortButton(setTitle: "가격낮은순")
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
        
        count = 30
        callRequst(sort: "")
        
        sortSimButton.addTarget(self, action: #selector(sortSimButtomClicked), for: .touchUpInside)
        sortDateButton.addTarget(self, action: #selector(sortDateButtomClicked), for: .touchUpInside)
        sortDscButton.addTarget(self, action: #selector(sortDscButtomClicked), for: .touchUpInside)
        sortAscButton.addTarget(self, action: #selector(sortAscButtomClicked), for: .touchUpInside)
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc func sortSimButtomClicked() {
        print("정확도 버튼 눌림")
        //list.removeAll()
        page = 1
        count = 0
        shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        callRequst(sort: "&start=1&sort=sim")
    }
    @objc func sortDateButtomClicked() {
        print("날짜순 버튼 눌림")
        //list.removeAll()
        page = 1
        count = 0
        shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        callRequst(sort: "&start=1&sort=date")
    }
    @objc func sortDscButtomClicked() {
        print("가격높은순 버튼 눌림")
        //list.removeAll()
        page = 1
        count = 0
        shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        callRequst(sort: "&start=1&sort=dsc")

    }
    @objc func sortAscButtomClicked() {
        print("가격낮은순 버튼 눌림")
        //list.removeAll()
        page = 1
        count = 0
        shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        callRequst(sort: "&start=1&sort=asc")
    }
    
    //네이버 API 요청
    func callRequst(sort: String) {
        print(#function, "첫번째")
        //var url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchBarToss)&display=100"
        var url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchBarToss)&display=\(count)"
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
                
                if let range = url.range(of: sort) {
                    url.removeSubrange(range)
                }
                print("url삭제체크 : \(url)")
                dump(value)
                self.list.append(contentsOf: value.items)
                self.total = value.total
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
        //totalLabel.text = "\(shoppingList.items.count)개의 검색결과"
        totalLabel.text = "\(list.count)개의 검색결과"
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCollectionViewCell.identifier, for: indexPath) as! ShoppingCollectionViewCell
            print("indexPath.item체크 :\(indexPath.item)")
            let item = list[indexPath.item]
            let url = URL(string: item.image)
            cell.shoppoingImageView.kf.setImage(with: url)
            cell.shoppingMallNameLabel.text = item.mallName
            cell.shoppingTitleLabel.text = item.title
            priceFormat.numberStyle = .decimal
            cell.shoppingPriceLabel.text = priceFormat.string(for: Int(item.lprice))
            return cell
    }
    
    //페이지네이션
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //30 > 60 > 90 > 120
        // 9 > 39 > 69 > 99
        // 1 > 2 > 3 > 4
        print("indexPath.item : \(indexPath.item) ,list.count: \(list.count), self.total: \(self.total),")
        if indexPath.item == (list.count - 21) && count < 100 {
            //print("count : \(count)")
            count += 30
            //page += 1
            //print("page : \(page)")
            callRequst(sort: "")
        }
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
        
        
        //월욜 질문 모음
        //동적 높이에서 부등호 설정은 코드로 어떻게? :greaterThanOrEqualTo,lessThanOrEqualTo 같은 것들이 존재
        //자꾸 스택뷰에 의존하게 되도 될까 : 지금은 괜춘
        //문법을 완전히 익히지 못하고 공식처럼 방법들을 적용하는거 같은데 이 순서가 맞는건가 : 이하 동문
        //네비게이션은 기본 포함 : 이번주 예정
        //스크롤시에 위에 하얗게 :  이번주 예정
        
        //
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
