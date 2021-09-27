import Foundation

func startGame() {
    var exitCheck = true //무한루프 확인하는 논리형 변수
    
    while (exitCheck) {
        print(" ---------------- 정수 또는 exit을 입력하시오 -------------------")
        print("                                ")
        print("구구단을 외자 : ", terminator : "") //개행제거

        let inputLine = readLine()! //입력받는 함수
        
        if (inputLine == "exit") //exit입력받으면 종료
        {
            exitCheck = false
        }
        else
        {
            let isLine = Int(inputLine)! // 구구단을 곱할 때 입력받은 문자를 정수로 사용하기 위해서 (int.parser)
                                                                    // 입력받은 String을 정수형으로 변환
            if (isLine > -2 && isLine < 2) // -1 , 0 , 1
            {
                print("입력값이 잘못되었습니다. 다시 입력해주세요.")
            }
            else if (isLine > 1 && isLine < 10) // 2 ~ 9일때
            {
                //반복문(구구단) 실행
                for i in 1...9{
                    print("\(isLine) X \(i) = \(isLine*i)")
                }
            }
            else // 2 ~ 9인 숫자가아닐때 에러처리
            {
                print("구구단 2 ~ 9까지의 숫자를 입력하세요")
            }
        }
    }
}

startGame()
