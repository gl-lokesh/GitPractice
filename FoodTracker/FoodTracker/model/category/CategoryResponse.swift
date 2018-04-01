//
//  CategoryResponse.swift
//  FoodTracker
//
//  Created by G L Lokesh on 3/31/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class CategoryResponse: Codable {

    var errorCode : Int!
    var message : String!
    var responseData : ResponseData!
    var statusCode : Int!
    
}
