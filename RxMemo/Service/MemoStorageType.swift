//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]>

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
