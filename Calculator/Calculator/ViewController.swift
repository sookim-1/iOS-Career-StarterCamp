//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputDataValidator = InputDataValidator()
        
        //UserInput(버튼 눌렀다고 가정, 버튼을 눌렀을때 파라미터를 입력받아 validate메서드 실행)
        inputDataValidator.validate(input: "0")
        inputDataValidator.validate(input: "1")
        inputDataValidator.validate(input: "0")
        inputDataValidator.validate(input: "1")
        inputDataValidator.validate(input: "+")
        inputDataValidator.validate(input: "1")
        inputDataValidator.validate(input: "1")
        inputDataValidator.validate(input: "1")
        inputDataValidator.validate(input: "1")


        
        //중위표현식(InputDataValidator의 validate메서드를 통해 입력받은 String을 중위표현식 순서의 배열로 변환)
        print(inputDataValidator.data.medianNotation)
        
        //계산기 인스턴스
        let calculator = Calculator(binaryCalculation: BinaryCalculation(), decimalCalculation: DecimalCalculation())
    
        //2진계산기 결과
        print(calculator.executeBinaryCalculation(inputDataValidator.data))
        
        //10진계산기 결과
        print(calculator.executeDecimalCalculation(inputDataValidator.data))
        
        // 후위표기법
        print(inputDataValidator.data.postfixNotation)
    }
}

