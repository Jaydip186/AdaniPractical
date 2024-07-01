//
//  BreedDetailResponse.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import Foundation

struct BreedDetailResponse : Codable {
    let message: [String]
    let status: String
    
    private enum CodingKeys: String, CodingKey {
        case message
        case status
    }
}
