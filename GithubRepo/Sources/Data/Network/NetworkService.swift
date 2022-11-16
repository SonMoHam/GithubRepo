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
                    dump(decodable)
                    completion(.success(decodable))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private func decode<R: Decodable>(data: Data?) -> Result<R, Error> {
        do {
            guard let data = data else { return .failure(NetworkError.responseDecoding)}
            let decoded: R = try JSONDecoder().decode(R.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(NetworkError.responseDecoding)
        }
    }
}
