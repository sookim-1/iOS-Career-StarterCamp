//
//  HeadOfficeBankTask.swift
//  BankManagerConsoleApp
//
//  Created by sookim on 2021/05/04.
//

import Foundation

class LoanScreeningTask: Operation, Taskable {
    
    private(set) var waitingNumber: Int
    private(set) var customerGrade: CustomerGrade

    init(waitingNumber: Int, customerGrade: CustomerGrade) {
        self.waitingNumber = waitingNumber
        self.customerGrade = customerGrade
    }

    override func main() {
        print("π€\(waitingNumber)λ² \(customerGrade.name)κ³ κ° λμΆμ¬μ¬ μμ")
        Thread.sleep(forTimeInterval: 0.5)
        print("π€\(waitingNumber)λ² \(customerGrade.name)κ³ κ° λμΆμ¬μ¬ μλ£")
    }

}
