# Juice Maker 🧃 

- STEP1 PR : https://github.com/yagom-academy/ios-juice-maker/pull/38
- STEP2 PR : https://github.com/yagom-academy/ios-juice-maker/pull/49
- STEP3 PR : https://github.com/yagom-academy/ios-juice-maker/pull/62

🎰 쥬스 주문! 재고 관리! 

🗓 21.03.08 ~ 21.03.19 

👥 Fezz, SooKim (2)

## Feature

- MVC Pattern
- Notification Center

---

## MVC (Model - View - Controller)


<img width="750" alt="image" src="https://user-images.githubusercontent.com/44525561/111880129-e3ad3a80-89ec-11eb-8fdb-7b96530c83a2.png">




---

### [Step 1] - 데이터 구조 (Model)


#### 고민했던 점 ⁉️ && 해결한 방법 ❗️

- **`enum`, `struct`, `class`의 적정한 선택 기준 정하기**
  - 값 타입, 레퍼런스 타입을 잘 생각해보자 !
  
- **`프로퍼티`, `메소드`의 적절한 네이밍 (상태, 반환, 상수, 변수, 연산 ...) 생각해보기**

- **상태 값에 따른 분류를 `switch-case`로 하는 것이 최선일까? (딸기 쥬스 - 딸기 / 딸기 바나나 쥬스 - 딸기, 바나나)**
  - 열거형과 딕셔너리로 과일 레시피를 구성
  
- **옵셔널 처리를 위해 `guard let`, `if let` 의 사용 기준 정하기**
  - *guard let*
    - `enum`과 `Error` 프로토콜을 활용하기 
    - 빠른 종료로 코드 간결화 
    - 하지만 모든 부분을 오류 던지기(`throw`)를 사용하려고 하면 `오류의 중복`이 발생하게 된다.(잘 처리해야함!)
    
  - *if let*
    - 오류 던지는 상황이 필요없거나 중복이 발생할 여지가 있을때
    - true / false 반환으로 처리 가능한 메소드
    
    
    
- **`접근 제어`, `final` 키워드의 적재적소에 맞게 사용하기**
  - 외부에서 사용되지 않는 프로퍼티, 메소드는 `private` 
  - 상속하지 않아도 되는 클래스는 `final`
  - 성능에도 영향이 있다. -  `간접 참조`, `직접 참조`
  
- **`MVC 모델`을 지향하기 위해 `Model`의 로직과 데이터 구조를 구분하는 단위별 파일 분류하기**

- **과일 저장소에 싱글톤 패턴 사용하기 (과일, 야채, 채소.. 있을 수 있지만, 현재 프로젝트의 과일 저장소만 존재한다고 생각함!)**
  - 과일 저장소만 있다고 했을 때 



#### 구현

- **JuiceData**
  - `enum`을 통해 쥬스, 과일, 레시피(딕셔너리)를 열거했다.
  
- **FruitStorage**
  - `enum`의 데이터 구조를 토대로 `읽기전용` 과일 저장소를 생성하고 저장소를 다루는 (넣기, 빼기) 메소드를 만들었다.
    - 과일 저장소 다루기 - `managerStorage`
    
- **JuiceMaker**
  - 쥬스를 주문하거나 재고를 추가하는 자판기
  - `Controller`에서 저장소에 직접 접근하지 않고 `JuiceMaker`를 통해 기능을 할 수 있도록 했다.
    - 쥬스 만들기 (현재 과일의 재고 수량 확인) - `make` (hasFruitStock)
    - 현재 과일 재고 확인 - `currentFruit`
    - 과일 재고 수정 - `consume` 




---

### [Step 2] - 주문 페이지 (ViewController)

#### 고민했던 점 ⁉️ && 해결한 방법 ❗️

- **레이아웃을 어떻게 잡을 것 인가?**
  - 스토리보드 
  - 스택 뷰 + 오토 레이아웃
  - Content Hugging Prority, Content Compression Resistance Prority
    - 내가 설정한 제한을 위배(?) 하는 순간에 콘텐츠의 `우선순위`로 작아지거나 커지기는 순서를 결정할 수 있다 (**중요**)
    
- **싱글톤 패턴이 과일 저장소, 쥬스 메이커 둘 다 적용되는 사항이 아닐까?**
  - 상황에 따라 모든게 가능했다.
  - 이번 프로젝트는 과일, 야채 ... 여러개의 저장소가 있을 수 있다고 가정 ([Step 1] 에서 생각한 저장소를 싱글톤으로 지정한 것을 변경)
  - 쥬스 메이커가 무조건 1개 있다고 가정하고 저장소는 다수 존재함 (상황에 따라 모두 싱글톤도 가능 - 쥬스 메이커 1, 저장소 1)
  - 쥬스 메이커 - `싱글톤` 
  
- **7개의 쥬스 주문 버튼을 하나의 @IBAction으로 처리하기**
  - tag 
    - 버튼마다 `tag` 값을 지정
  - currentTitle 
    - 버튼의 `String` 값을 활용해서 7가지 판단
  - Custom Button 
    - 커스텀 버튼 클래스를 통해 각각의 `인스턴스`에 쥬스를 지정
    
- **Model의 변화를 감지하고 과일 하나씩 바뀔 때마다 라벨에 반영해주기 (기존에 모든 라벨을 업데이트 하는 방식 사용 - 자원 소모)**
  - 커스텀 라벨 클래스를 통해 각각의 인스턴스에 과일을 지정
  - Notification Center를 통해 각각의 과일에 변화가 있을때 과일에 맞는 라벨에 즉시 업데이트 해주기
    - 커스텀 라벨 클래스에 있으면 `Model -> View` 이므로 `MVC`에 위배된다.
    - `Model -> Controller -> View` 이렇게 `Controller`를 통해 업데이트 해주도록 한다.
    
  - Notification Center, Delegate Pattern, Closer 고려해보자! 



#### 구현

- **레이아웃 (iPhone 11 Pro Max, iPhone SE)**

<img width="450" alt="스크린샷 2021-03-21 오전 1 23 43" src="https://user-images.githubusercontent.com/44525561/111880148-fcb5eb80-89ec-11eb-8cad-ce57880dc865.png">
<img width="450" alt="스크린샷 2021-03-21 오전 1 24 15" src="https://user-images.githubusercontent.com/44525561/111880152-ff184580-89ec-11eb-8c49-5fbbb42fc746.png">

- **실행 영상**

![JuiceMaker_Step1](https://user-images.githubusercontent.com/44525561/111880171-24a54f00-89ed-11eb-897c-8913ab2da961.gif)



---

### [Step 3] - 재고 수정 페이지 (ViewController)

#### 고민했던 점 ⁉️ && 해결한 방법 ❗️

- **커스텀 스테퍼 사용하기**

  - `UIView`를 `상속`받아 커스텀 스태퍼 구현 (양쪽 스테퍼, 중앙 레이블)

    <img width="149" alt="스크린샷 2021-03-21 오전 2 09 09" src="https://user-images.githubusercontent.com/44525561/111880174-2a029980-89ed-11eb-8982-bb02b6c0c20a.png"> 

  - 양쪽의 버튼이 비슷하다 -> `커스텀 버튼 클래스`으로 코드의 중복 감소
  

- **이전 페이지의 반영된 과일 재고를 재고 수정 페이지의 레이블에 반영하기**

  - 실수 했던 부분 
    - 보이는 부분은 `스토리보드로` `뷰`에 `커스텀 스테퍼 클래스`를 올리고 로직은 코드로 작성 (ViewController에 코드로 `인스턴스`를 또 생성)
    - 중앙의 라벨을 로직에 따라 업데이트를 해도 전혀 반영이 되지 않았다 ..
    - 코드로 생성한 `인스턴스`를 제거하고 `@IBoutlet`으로 연결함으로 해결 !
    
  - `MVC` 지향하기 위해 재고 관련 부분을 `Controller`에서 받아서 각각의 스테퍼에 맞게 라벨을 업데이트 시켰다.
  

- **스테퍼의 이벤트를 과일 재고에 반영하기 (재고 수정)**

  - 왼쪽 tag = -1, 오른쪽 tag = 1 로 지정해서 스테퍼의 이벤트를 `tag`로 계산하여 라벨에 반영했다.
  

- **재고 수정 후 재고가 완료되었다는 메시지를 사용자에게 주기**

  - 스테퍼 이벤트로 재고를 변경하고 `SAVE 버튼`을 통해 최종 재고 수정을 했다. 
    - `SAVE 버튼`을 누르면 `Alert`으로 재고의 수정 여부를 확인하고 예 버튼을 누르게 되면 클로저로 각각의 반영된 내용을 과일 저장소에 반영함
    - dismiss 실수 
      - `self.dismiss` 이 부분이 현재 올라와 있는 부분이 사라지게 하므로 재고 수정 확인 `Alert`도 따로 내려줘야 했다
      - 즉, 2번의 dismiss가 필요하며, `클로저` 밖과 클로저 속에서 호출해줘야 서로간 간섭이 안생기고 정상적으로 동작한다.



- **실행 영상**

  ![JuiceMaker_Step2](https://user-images.githubusercontent.com/44525561/111880172-27a03f80-89ed-11eb-8108-b28bddfc3591.gif)
