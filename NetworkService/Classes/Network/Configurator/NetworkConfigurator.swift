//
//  NetworkConfigurator.swift
//  NetworkService
//
//  Created by Oleg on 02.05.2020.
//

import Foundation

public struct NetworkConfiguration {

    public let serializationService: SerializationServiceProtocol
    public let isLoggingEnabled: Bool
    public let headers: [String: String]
    public let baseURL: String

    public init(
        serializationService: SerializationServiceProtocol,
        isLoggingEnabled: Bool,
        headers: [String: String],
        baseURL: String
    ) {
        self.serializationService = serializationService
        self.isLoggingEnabled = isLoggingEnabled
        self.headers = headers
        self.baseURL = baseURL
    }
}
