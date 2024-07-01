//
//  BreedListViewModel.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import Foundation


class BreedListViewModel {
    private let apiManager = APIManager.shared
        
        func fetchDogBreeds(completion: @escaping (Result<BreedListResponse, Error>) -> Void) {
            guard let url = URL(string: BASEURL + listAPI) else {
                fatalError("Invalid API URL")
            }
            
            apiManager.fetchData(from: url) { (result: Result<BreedListResponse, Error>) in
                completion(result)
            }
        }
    
    
}
