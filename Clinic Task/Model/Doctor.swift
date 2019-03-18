//
//  Doctor.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/18/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import Foundation

struct DoctorsResponse: Codable
{
    let error: DoctorsError?
    let response: [Doctor]?
    enum CodingKeys: String, CodingKey
    {
        case response = "Response"
        case error = "Error"
    }
}
struct DoctorsError: Codable
{
    let status: Bool?
    let code: Int?
    let desc: String?
    let token: String?
}
struct Doctor: Codable
{
    let id, accountType: Int?
    let name: String?
    let image: String?
    let speciality: String?
    let minFees, accountID: Int?
    let uniqueID: String?
    let isPremium: Int?
    let title: String?
    let myRecommendsCount, followers, isRecommended: Int?
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case accountType = "account_type"
        case name, image, speciality
        case minFees = "min_fees"
        case accountID = "account_id"
        case uniqueID = "unique_id"
        case isPremium = "is_premium"
        case title
        case myRecommendsCount = "my_recommends_count"
        case followers
        case isRecommended = "is_recommended"
    }
}
