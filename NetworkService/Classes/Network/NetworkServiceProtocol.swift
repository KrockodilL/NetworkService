//
//  NetworkService.swift
//  NetworkService
//
//  Created by Oleg Sinev on 03/01/2020.
//  Copyright (c) 2020 Oleg Sinev. All rights reserved.
//

import RxSwift

public protocol NetworkServiceProtocol {
    /**
     Send request to the server
     - Parameter request: Model for session request creation
     - Returns: Observable-encoded model.
     - Throws: Error with ServerError type
     - Author: Oleg Sinev
     */
    func data<T: Decodable>(for request: Request) -> Single<T>
    /**
     Отправляет запрос на сервер
     - Parameter isEnabled: Turn logging on if true, otherwise off
     - Author: Oleg Sinev
     */
    func setLoggingEnabled(_ isEnabled: Bool)
    /**
     Updates headers sent to server. Create new key-value pair  if it does not exist
     - Parameter value: Header value
     - Parameter key: Header key. Example: "Content-Type"
     - Author: Oleg Sinev
     */
    func updateHeaderValue(_ value: String, for key: String)
}
