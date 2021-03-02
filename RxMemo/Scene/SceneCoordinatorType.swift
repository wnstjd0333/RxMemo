//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    // Completable 구독자를 추가하고 화면전환이 완료한후 원하는 작업 구현할 수 있다
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable

    @discardableResult
    func close(animated: Bool) -> Completable
}
