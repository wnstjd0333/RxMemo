//
//  MemoComposeViewController.swift
//  RxMemo
//
//  Created by kimjunseong on 2021/03/01.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoComposeViewModel!

    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx_disposeBag)

        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx_disposeBag)

        cancelButton.rx.action = viewModel.cancelAction
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx_disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
}
