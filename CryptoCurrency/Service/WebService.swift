//
//  WebService.swift
//  CryptoCurrency
//
//  Created by Melike Soygüllücü on 12.08.2024.
//

import Foundation

class WebService {
    
    enum CryptoError : Error {
        case serverError
        case parsingError
    }
    
    func getCurrencies (url : URL, completion : @escaping (Result<[Crypto], CryptoError>) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(CryptoError.serverError))
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(CryptoError.parsingError))
                }
            }
        }.resume()
    }
    
}
