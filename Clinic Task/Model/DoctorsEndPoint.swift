//
//  DoctorsEndPoint.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/19/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import Foundation
struct DoctorsEndPoint {
    private let baseUrl = "https://admin-seena.com/api/doctors/all"
    let url: String
    let methodType: String = "POST"
   
    init(offset : Int , limit : Int) {
        let queryItem1 = URLQueryItem.init(name: "offset", value: "\(offset)")
        let queryItem2 = URLQueryItem.init(name: "limit", value: "\(limit)")
        var urlComponet = URLComponents.init(string: baseUrl)
        urlComponet!.queryItems = [queryItem1, queryItem2]
        self.url = urlComponet?.url?.absoluteString ?? ""
    }
}
