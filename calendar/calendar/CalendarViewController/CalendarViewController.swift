//
//  CalendarViewController.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 14/07/2021.
//

import UIKit
import RxSwift

protocol DidFinishDateSelectedDelegate {
    func didFinishSelectDate(date: Date?, description: String?)
}

class CalendarViewController: UIViewController {

    let viewModel: CalendarViewModel!
    let calendarView = CalendarView()
    let disposedBag = DisposeBag()
    var delegate: DidFinishDateSelectedDelegate!
    var oldIndexSelected: IndexPath?

    var coordinator: MainCoordinator?

    init(holidays: [HolidayModel]) {
        self.viewModel = CalendarViewModel(holidays: holidays)
        super.init(nibName: .none, bundle: .none)
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = calendarView
    }

}

fileprivate extension CalendarViewController {
    
    func bindViewModel() {
        calendarView.selectButton.setTitle(viewModel.buttonTitle, for: .normal)
        viewModel.addGesture(view: calendarView.calendarCollectionView)
        updateMonthNameText()
        calendarView.titleLabel.text = viewModel.titleLabelText
        viewModel.setDelegates(collection: calendarView.calendarCollectionView, delegate: self)
        viewModel.registerCell(collection: calendarView.calendarCollectionView)
        viewModel.swipeLeft.rx.event.bind(onNext: { recognizer in
            if !self.viewModel.isMaxIndexSelected {
                self.generateSuccessImpact()
                self.viewModel.addIndex()
                self.updateCalendarToShow()
            }
        }).disposed(by: disposedBag)
        viewModel.swipeRight.rx.event.bind(onNext: { recognizer in
            if !self.viewModel.isMinIndexSelected {
                self.generateSuccessImpact()
                self.viewModel.delIndex()
                self.updateCalendarToShow()
            }
        }).disposed(by: disposedBag)
        calendarView.calendarCollectionView.rx.itemSelected.subscribe { (newIndexSelected: IndexPath) in
            self.generateSuccessImpact()
            self.updateRowsSelected(newIndexSelection: newIndexSelected)
            self.viewModel.createDate(indexSelected: newIndexSelected)
            self.calendarView.selectedDateLabel.text = self.viewModel.labelText
            self.calendarView.descriptionLabel.text = self.viewModel.obtaintDescriptionText()
        }.disposed(by: disposedBag)
        calendarView.backButton.rx.tap.subscribe { _ in
            self.generateErrorImpact()
            self.coordinator?.popWithDismissAnimation()
        }.disposed(by: disposedBag)
        calendarView.selectButton.rx.tap.subscribe { _ in
            self.generateSuccessImpact()
            self.delegate.didFinishSelectDate(date: self.viewModel.dateSelected, description: self.viewModel.getDateDescription())
            self.coordinator?.popWithDismissAnimation()
        }.disposed(by: disposedBag)
    }
        
}

fileprivate extension CalendarViewController {
    func updateMonthNameText() {
        UIView.animate(withDuration: 0.2) {
            self.calendarView.subtitleLabel.text = self.viewModel.subtitleMonthText
            self.calendarView.descriptionLabel.text = self.viewModel.obtaintDescriptionText()
        }
    }
}

fileprivate extension CalendarViewController {
    func updateRowsSelected(newIndexSelection: IndexPath?) {
        let indexs = viewModel.updateRows(oldIndexSelected: oldIndexSelected, newIndexSelection: newIndexSelection)
        DispatchQueue.main.async {
            self.calendarView.descriptionLabel.isHidden = self.viewModel.labelText.isEmpty
            self.calendarView.calendarCollectionView.reloadItems(at: indexs)
        }
        oldIndexSelected = newIndexSelection
    }
    
    func clearSelection() {
        DispatchQueue.main.async {
            
        }
    }
}

fileprivate extension CalendarViewController {
    func updateCalendarToShow() {
        clearSelection()
        viewModel.reloadItems()
        UIView.animate(withDuration: 0.1) {
            self.calendarView.calendarCollectionView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0) {
                self.updateMonthNameText()
                DispatchQueue.main.async {
                    self.calendarView.calendarCollectionView.reloadData()
                }
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.calendarView.calendarCollectionView.alpha = 1
                }
            }
        }
    }
}

extension CalendarViewController: UICollectionViewDelegate { }

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = viewModel.cellHeight
        calendarView.collectionHeight.constant = cellHeight * viewModel.maxItemsVertical

        let width = collectionView.bounds.width / viewModel.maxItemsHorizontal
        let height = cellHeight
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.calendars[section].daysInMonth.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        let date = viewModel.convertToDate(index: indexPath)
        let day = viewModel.calendarSelected.daysInMonth[indexPath.row]
        cell.isSelectedCell =  date == viewModel.dateSelected && day != 0
        
        cell.setupCell(day: day, isHoliday: viewModel.checkIsHoliday(date: date), isWeekEnd: viewModel.checkIsWeekEnd(date: date))

        return cell
    }
    
}

