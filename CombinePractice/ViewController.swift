//
//  ViewController.swift
//  CombinePractice
//
//  Created by 방선우 on 2022/12/30.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // 데이터를 갖고 있는 프로퍼티
        //        let publisher = ["a", "b", "c", "d", "e", "f", "g"].publisher
        //
        //        // 구독방식, 데이터 스트림, 데이터 스트림 완료를 전부 하나의 모델로 뺀거
        //        let subscriber = CustomSubscribe()
        //
        //        // 구독 시작
        //        publisher.subscribe(subscriber)
        
        //MARK: sink 예제
        //        let formatter = NumberFormatter()
        //        formatter.numberStyle = .ordinal
        //        //데이터 받음 -> 1번 스트림 변경
        //        (1...10).publisher.map { value in
        //            formatter.string(from: NSNumber(integerLiteral: value)) ?? ""
        //            // 구독 -> 데이터 반영
        //        }.sink { str in
        //            print("데이터 스트림이 바뀜 \(str)")
        //        }.cancel() // disposed랑 비슷함
        
        //MARK: PassthroughSubject
        let subject = PassthroughSubject<String, Never>()
        
       //한번 담아줘야 실행이 됨 왜지? PassthroughSubject이게 클래스라서 객체를 만들어줘야하나
        let subscriber = subject.sink { completion in
            print("완료")
        } receiveValue: { value in
            print(value)
        }
        
        subject.send("ㅇ ㅏ")
        subject.send("옹")
        
        subject.send(completion: .finished)
    }
}
/*
 { completion in
     switch completion {
     case .finished:
         print("데이터 발행이 끝났다")
     case .failure(_):
         print("Error가 발생했습니아")
     }
 } receiveValue: { value in
     print(value)
     print("구독구독 방출방출")
 }.cancel()
 */

class CustomSubscribe: Subscriber {
    
    typealias Input = String
    typealias Failure = Never
    
    // 구독
    func receive(subscription: Subscription) {
        print("데이터 구독을 시작합니다")
        subscription.request(.max(4)) // 이벤트 방출 횟수에 제한이 없음
    }
    
    // 이벤트를 받을 거임, 데이터 스트림을 바꿀 때 사용하는 메서드, .none으로 리턴하면 현재 데이터 스트림을 유지한다는 뜻
    func receive(_ input: String) -> Subscribers.Demand {
        print("데이터 들어옴\(input)")
        return .none // 최대 몇개의 이벤트를 받을건지 정할 수 있음
    }
    
    // 모든 데이터가 발행되지 않으면 호출되지 않음
    func receive(completion: Subscribers.Completion<Never>) {
        print("데이터 발행이 완료됐습니다")
    }
}
