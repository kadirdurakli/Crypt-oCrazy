//
//  WebService.swift
//  CryptoCrazy
//
//  Created by Kadir Duraklı on 17.12.2024.
//

import Foundation

enum CryptoError : Error {
    case ServerError
    case ParsingError
}

class WebService {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto],CryptoError>) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _error = error {
                completion(.failure(CryptoError.ServerError))
            }
            
            else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoLit = cryptoList {
                    completion(.success(cryptoLit))
                } else {
                    completion(.failure(CryptoError.ParsingError))
                }
            }
        }.resume()
    }
    
}
