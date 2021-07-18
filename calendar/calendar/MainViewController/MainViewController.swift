//
//  MainViewController.swift
//  calendar
//
//  Created by Agustin Errecalde on 18/07/2021.
//

import UIKit


class MainViewController: UIViewController {
    
    var viewModel: MainViewModel!
    var mainView = MainView()
    var coordinator: MainCoordinator?
    
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
        mainView.continueButton.setTitle(viewModel.buttonTitle, for: .normal)
        title = viewModel.mainTitle
    }
}
