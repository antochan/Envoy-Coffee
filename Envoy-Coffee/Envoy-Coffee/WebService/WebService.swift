//
//  WebService.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

enum Result<T> {
    case success(T)
    case failure(AppError)
}

enum AppError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidURL
}

protocol NetworkRouter: AnyObject {
    func fetchData<T: Decodable>(urlString: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void)
}

class WebService: NetworkRouter {
    var fetchDataWasCalled = false
    
    func fetchData<T>(urlString: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        fetchDataWasCalled = true
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataNotFound))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(objectType, from: data)
                completion(.success(decodedObject))
            } catch let error {
                completion(.failure(.jsonParsingError(error)))
            }
        }
        task.resume()
    }
}
