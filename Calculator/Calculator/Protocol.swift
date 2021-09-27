//
//  Protocol.swift
//  Calculator
//
//  Created by 김민성 on 2021/03/27.
//

import Foundation

protocol Calculatable {
    @discardableResult
    func calculate(_ input: Data) -> Result<String, CalculationError>
}

