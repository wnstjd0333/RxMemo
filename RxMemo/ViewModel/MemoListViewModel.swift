//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import RxDataSources

typealias MemoSectionModel = AnimatableSectionModel<Int, Memo>

class MemoListViewModel: CommonViewModel {
    let dataSource: RxTableViewSectionedAnimatedDataSource<MemoSectionModel> = {
        let ds =
            RxTableViewSectionedAnimatedDataSource<MemoSectionModel>(configureCell: {
                (dataSource, tableView, indexPath, memo) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = memo.content
                return cell
            })
        ds.canEditRowAtIndexPath = {
            _, _ in return true
        }
        return ds
    }()

    var memoList: Observable<[MemoSectionModel]> {
        return storage.memoList()
    }

    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }

    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }

    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "새 메모", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))

                    let composeScene = Scene.compose(composeViewModel)
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
                }
        }
    }

    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)

            let detailScene = Scene.detail(detailViewModel)

            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()

    lazy var deleteAction: Action<Memo, Swift.Never> = {
        return Action { memo in
            return self.storage.delete(memo: memo).ignoreElements()
        }
    }()
}
