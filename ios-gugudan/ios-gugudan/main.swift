import Foundation

func startgugudan (stringNum : String) {
    
    // 정수형으로 변환 후 Int형 맞는지 확인
    if let inputNum = Int(stringNum) {
        if inputNum < 2 || inputNum > 9 {
            print("2부터 9까지 입력해주세요")
        } else {
            for i in 1...9 {
                print("\(inputNum) X \(i) = \(inputNum * i)")
            }
        }
    }
    // 조건에 맞지 않는 문자가 입력받을 때 에러처리
    else {
        print("잘못된 입력입니다.")
    }
}

while (true) {
    print("구구단을 외자 : ", terminator: "")
    
    let inputString = readLine()!
    
    if inputString == "-1" || inputString == "0" || inputString == "1" {
        print("다시 입력해주세요")
    } else if inputString == "exit" {
        break
    } else {
        startgugudan(stringNum : inputString)
    }
}
