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
        
        // 데이터를 갖고 있는 프로퍼티
        let publisher = ["a", "b", "c", "d", "e", "f", "g"].publisher
        
        // 구독방식, 데이터 스트림, 데이터 스트림 완료를 전부 하나의 모델로 뺀거
        let subscriber = CustomSubscribe()
        
        // 구독 시작
        publisher.subscribe(subscriber)
        
    }


}

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
