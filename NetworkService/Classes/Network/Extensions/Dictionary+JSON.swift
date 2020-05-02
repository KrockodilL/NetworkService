//
//  NetworkService.swift
//  NetworkService
//
//  Created by Oleg Sinev on 03/01/2020.
//  Copyright (c) 2020 Oleg Sinev. All rights reserved.
//

import Foundation

extension Dictionary {

    func toJSON(with options: JSONSerialization.WritingOptions = []) -> String? {
        do {
            let eventData = try JSONSerialization.data(withJSONObject: self, options: options)
            return String(data: eventData, encoding: .utf8)
        } catch {
            print("\(error)")
            return nil
        }
    }

}

