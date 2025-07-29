//
//  NetworkManager.swift
//  SeSACWeek4_day5_Assignment
//
//  Created by 박현진 on 7/29/25.
//

//import Foundation

import Alamofire
/*
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    //네이버 API 요청
    func callRequst(count: Int, start: Int, sort: String) {
        print("sort는 \(sort)")
        
        //print(#function, "첫번째")
        print("count는\(count)")
        //var url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchBarToss)&display=100"
        //var url = ""
        //var url2 = "https://openapi.naver.com/v1/search/shop.json?query=\(searchBarToss)&display=30"
        //        if start == 1 {
        //            url1.append(sort)
        //            url = url1
        //        } else {
        //            url = url2
        //        }
        
        var url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchBarToss)&display=30"
        
        print("정렬버튼X")
        url.append(sort)
        
        //url.append("\(query)&display=100")
        print("url체크 : \(url)")
        let header: HTTPHeaders = ["X-Naver-Client-Id": "xA5LXXctMDL0kfcaEa4x",
                                   "X-Naver-Client-Secret": "xspwBdaWWj"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShoppingList.self) { response in
                //print(#function, "두번째")
                print("url체크 : \(url)")
                switch response.result {
                case .success(let value):
                    print("success")
                    
                    if let range = url.range(of: sort) {
                        url.removeSubrange(range)
                    }
                    print("url삭제체크 : \(url)")
                    //dump(value)
//                    self.list.append(contentsOf: value.items)
//                    self.total = value.total
//                    self.shoppingCollectionView.reloadData()
//                    if start == 1 {
//                        self.shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
//                    }
                    //                var check = 0
                    //                if sort != "" {
                    //                    check = 1
                    //                }
                    //                if check == 1 {
                    //                    print("정렬버튼이니까 url 지우지마")
                    //                } else if check == 0 {
                    //                    print("정렬버튼아니어서 url 뒤에 지우자")
                    //                    if let range = url.range(of: "&start=1&sort=\(sort)") {
                    //                        url.removeSubrange(range)
                    //                    }
                    //                    print("url삭제체크 : \(url)")
                    //                }
                    
                    
                case .failure(let error):
                    self.showAlert(title: "데이터를 가져오는데 실패했습니다.", message: "", ok: "확인")
                    print("fail", error)
                }
            }
        //print(#function, "세번째")
        print("url체크 : \(url)")
    }
}
*/
