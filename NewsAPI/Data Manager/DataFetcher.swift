//
//  DataFetcher.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

enum NewsAPIError: Error {
    case badRequest
    case unauthorized
    case tooManyRequests
    case serverError
}

extension NewsAPIError {
    var errorDescription: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable, often due to a missing or misconfigured parameter"
        case .unauthorized:
            return "Your API key was missing from the request, or wasn't correct"
        case .tooManyRequests:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while"
        case .serverError:
            return "Something went wrong on our side."
        }
    }
}

protocol DataFetcher {
    func getSource(endpoint: Endpoint,completion: @escaping (Result<[Source], NewsAPIError>) -> Void)
    func getArticle(endpoint: Endpoint,completion: @escaping (Result<[Article], NewsAPIError>) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    private let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func getSource(endpoint: Endpoint,completion: @escaping (Result<[Source], NewsAPIError>) -> Void) {
        service.request(endpoint: endpoint) { data, response, error in
            if let _ = error {
                completion(.failure(.badRequest))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
            case 200:
                if let decode = self.decode(jsonData: SourceResponse.self, from: data) {
                    completion(.success(decode.sources))
                }
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 429:
                completion(.failure(.tooManyRequests))
            case 500:
                completion(.failure(.serverError))
            default:
                break
            }
        }
    }
    
    func getArticle(endpoint: Endpoint, completion: @escaping (Result<[Article], NewsAPIError>) -> Void) {
        service.request(endpoint: endpoint) { data, response, error in
            if let _ = error {
                completion(.failure(.badRequest))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
            case 200:
                if let decode = self.decode(jsonData: ArticlesResponse.self, from: data) {
                    completion(.success(decode.articles))
                }
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 429:
                completion(.failure(.tooManyRequests))
            case 500:
                completion(.failure(.serverError))
            default:
                break
            }
        }
    }
    
    private func decode<T: Decodable>(jsonData type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data else { return nil }
        
        do {
            let response = try decoder.decode(type, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
    }
}
