//
//  TransitionModel.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
