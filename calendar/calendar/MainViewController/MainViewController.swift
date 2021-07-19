//
//  MainViewController.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit
import RxCocoa
import RxSwift


class MainViewController: UIViewController {
    
    var viewModel: MainViewModel!
    var mainView = MainView()
    var coordinator: MainCoordinator?
    private let bag = DisposeBag()
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
}

fileprivate extension MainViewController {
    func bindViewModel() {
        updateButtonTitle()
        mainView.titleLabel.text = viewModel.appTitle
        mainView.continueButton.rx.tap.subscribe { _ in
            self.viewModel.getHolidays { _ in
                DispatchQueue.main.async {
                    self.generateSuccessImpact()
                    self.coordinator?.coordinateToCalendar(delegate: self, holidays: self.viewModel.holidays)
                }
            }
        }.disposed(by: bag)
    }
}

fileprivate extension MainViewController {
    func updateButtonTitle() {
        mainView.continueButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
}

extension MainViewController: DidFinishDateSelectedDelegate {
    func didFinishSelectDate(date: Date?, description: String?) {
        guard let date = date else {
            return
        }
        viewModel.dateSelected = true
        updateButtonTitle()
        mainView.descriptionLabel.text = description
        mainView.dateSelectedLabel.text = date.convertToString()
    }

}
