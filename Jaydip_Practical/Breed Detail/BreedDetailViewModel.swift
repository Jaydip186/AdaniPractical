//
//  BreedDetailViewModel.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import Foundation
class BreedDetailViewModel {
    private let apiManager = APIManager.shared
        
    func fetchBreedsDetail(name:String, completion: @escaping (Result<BreedDetailResponse, Error>) -> Void) {
            guard let url = URL(string: BASEURL + BreedDetailAPI.replacingOccurrences(of: "//", with: "/\(name)/")) else {
                fatalError("Invalid API URL")
            }
            print(url)
            apiManager.fetchData(from: url) { (result: Result<BreedDetailResponse, Error>) in
                completion(result)
            }
        }
    
    
}
