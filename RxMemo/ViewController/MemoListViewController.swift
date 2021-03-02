//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!

    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx_disposeBag)
        viewModel.memoList
            .bind(to: listTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx_disposeBag)

        addButton.rx.action = viewModel.makeCreateAction()

        Observable.zip(listTableView.rx.modelSelected(Memo.self),
                       listTableView.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                self.listTableView.deselectRow(at: indexPath, animated: true)
            })
            .map { $0.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx_disposeBag)

        listTableView.rx.modelDeleted(Memo.self)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx_disposeBag)
    }
}
