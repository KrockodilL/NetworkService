//
//  NetworkService.swift
//  NetworkService
//
//  Created by Oleg Sinev on 03/01/2020.
//  Copyright (c) 2020 Oleg Sinev. All rights reserved.
//

import RxCocoa
import RxSwift

public final class NetworkService {

    // MARK: - Protocol properties
    private let serializationService: SerializationServiceProtocol
    private let baseURL: String

    // MARK: -  Properties
    private var isLoggingEnabled: Bool
    private var httpHeaders: [String: String]

    // MARK: - Init
    public init(with configuration: NetworkConfiguration) {
        self.serializationService = configuration.serializationService
        self.baseURL = configuration.baseURL
        self.httpHeaders = configuration.headers
        self.isLoggingEnabled = configuration.isLoggingEnabled
    }

    // MARK: - Private methods
    private func makeSessionRequest(from request: Request) throws -> URLRequest {
        let urlString = [baseURL, request.apiVersion.rawValue, request.query].joined(separator: "/")
        guard let url = URL(string: urlString) else {
            print("Session query url failed: base \(baseURL) and query \(request.query)")
            throw ServerError.invalidURL
        }

        var sessionRequest = URLRequest(url: url)
        sessionRequest.httpMethod = request.method.rawValue
        sessionRequest.allHTTPHeaderFields = httpHeaders
        sessionRequest.httpBody = request.bodyParameters?.toJSON()?.data(using: .utf8)

        return sessionRequest
    }

    private func performRequest<T: Decodable>(request: Request) -> Single<T> {
        guard let sessionRequest = try? makeSessionRequest(from: request) else {
            return .error(ServerError.invalidURL)
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20
        sessionConfig.timeoutIntervalForResource = 20

        return URLSession(configuration: sessionConfig).rx.response(request: sessionRequest)
            .flatMap { [unowned self] response, data -> Observable<T> in
                if self.isLoggingEnabled {
                    String(data: data, encoding: .utf8).map { print("Network Service Response: ", $0) }
                }
                do {
                    let successData: T = try self.serializationService.deserialize(data)
                    return Observable.just(successData)
                } catch let deserializationError {
                    if self.isLoggingEnabled {
                        print(deserializationError.localizedDescription)
                        if let error = deserializationError as? DecodingError {
                            if case let DecodingError.keyNotFound(_, context) = error {
                                print(context.debugDescription, "codingPath: ", context.codingPath)
                            } else {
                                print("JSON DecodingError: ", error)
                            }
                        }
                    }
                    return Observable.error(deserializationError)
                }
            }.asSingle()
    }

}

// MARK: - NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {

    public func updateHeaderValue(_ value: String, for key: String) {
        httpHeaders[key] = value
    }

    public func setLoggingEnabled(_ isEnabled: Bool) {
        isLoggingEnabled = isEnabled
    }


    public func data<T: Decodable>(for request: Request) -> Single<T> {
        return performRequest(request: request)
    }

}
