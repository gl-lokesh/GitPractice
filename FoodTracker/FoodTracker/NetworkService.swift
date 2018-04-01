//
//  NetworkService.swift
//  FoodTracker
//
//  Created by G L Lokesh on 3/31/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
//protocol Serializable: Codable {
//    func serialize() -> Data?
//}
//
//extension Serializable {
//    /// Json Encoder for the ecoding the data
//    func serialize() -> Data? {
//        let encoder = JSONEncoder()
//        return try? encoder.encode(self)
//    }
//}

class NetworkService: NSObject {
    
    var responseData: NSData!
    var requestBody: [String: AnyObject] = ["": "" as AnyObject]
    var serviceURL: String = "http://localhost:2018/product/v1"
    
    enum ServiceType: String {
        case GET
        case POST
        case PUT
        case DELETE
    }

    
    
    func startService(serverApi: String, httpMethod:ServiceType) {
        let url: String
        let configuration = URLSessionConfiguration.default
        url = self.serviceURL + serverApi
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod.rawValue
        
        let session: URLSession = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        print("request : \(request)")
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print("error \(String(describing: error))")
                session.finishTasksAndInvalidate()
            } else if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                } else {
                    if let responseData = try? JSONDecoder().decode(CategoryResponse.self, from: data!) {
                        print("   ---====>>>   ", responseData)
                        
                    } else {
                        print("Failed to Serialize the data")
                    }
                    
                    
                }
            } else {
                session.finishTasksAndInvalidate()
            }
        })
        dataTask.resume()
    }
    
}
