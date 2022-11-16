//
//  NetworkService.swift
//  GithubRepo
//
//  Created by Son Daehong on 2022/11/14.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case urlGeneration
    case responseDecoding
}

public protocol NetworkService {
    func request<R, E>(
        with endpoint: E,
        completion: @escaping (Result<R, Error>) -> Void
    ) where R : Decodable, R == E.Response, E : Requestable
}

public final class AFNetworkService {
    
}

extension AFNetworkService: NetworkService {
    public func request<R, E>(
        with endpoint: E,
        completion: @escaping (Result<R, Error>) -> Void
    ) where R : Decodable, R == E.Response, E : Requestable {
        guard let urlRequest = endpoint.asURLRequest() else {
            completion(.failure(NetworkError.urlGeneration))
            return
        }
        AF.request(urlRequest)
            .responseDecodable(of: R.self) { response in
                switch response.result {
                case .success(let decodable):
                    completion(.success(decodable))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
