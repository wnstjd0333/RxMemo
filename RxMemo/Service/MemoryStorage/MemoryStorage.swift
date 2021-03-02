//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    // 업데이트가 되면 새로운 next이벤틀를 방출해야 한다 -> subject로, 초기에 더미데이터 보여줘야하니 behavior subject
    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]

    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        sectionModel.items.insert(memo, at: 0)
        store.onNext([sectionModel])
        return Observable.just(memo)
    }

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        return store
    }

    @discardableResult
    // 새로운 배열을 방출해야 테이블을 갱신할 수 있다.
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updated, at: index)
        }
        store.onNext([sectionModel])
        return Observable.just(updated)
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
        }
        store.onNext([sectionModel])
        return Observable.just(memo)
    }
}
