//
//  BreedListApiResponse.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import Foundation


struct BreedListResponse : Codable {
    let message: [String: [String]]
    let status: String
}



