//
//  NetworkManger.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/19/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import Foundation

class NetworkManger {
    static let shared = NetworkManger.init()
    private init(){}
    func getDoctors(andCompletion completion: @escaping completionType , andErrorHandler errorHandler: @escaping errorType) {
        let url = URL(string: "https://admin-seena.com/api/doctors/all")
        var request = URLRequest(url: url! )
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if  error != nil
            {
                DispatchQueue.main.async
                    {
                        errorHandler(error)
                }
            }
            else
            {
                if let data = data
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        let result  = try decoder.decode(DoctorsResponse.self, from: data)
                        DispatchQueue.main.async
                            {
                                completion(result)
                        }
                    }
                    catch
                    {
                        DispatchQueue.main.async
                            {
                                print(error)
                                errorHandler(error)
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async
                        {
                            errorHandler(error)
                    }
                }
            }
        }
        task.resume()
    }
}
