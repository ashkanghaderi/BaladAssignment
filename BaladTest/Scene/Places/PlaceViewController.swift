//
//  PlaceViewController.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import MapKit

class PlaceViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    var viewModel: PlaceViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }

    private func configureTableView() {
       // tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        LocationManager.shared.getLocation {[unowned self] (location:CLLocation?, error:NSError?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let location = location else {
                return
            }
            print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
        
            fetchPolicy.share.shouldFetchPlacesFromServer = true
//            let viewWillAppear = self.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
//            .mapToVoid()
//            .asDriverOnErrorJustComplete()
//            let pull = self.tableView.refreshControl!.rx
//            .controlEvent(.valueChanged)
//            .asDriver()
        
            let input = PlaceViewModel.Input(latitude: Driver.of(location.coordinate.latitude), longitude: Driver.of(location.coordinate.longitude), selectionTrigger: self.tableView.rx.itemSelected.asDriver())
        
            let output = self.viewModel.transform(input: input)
            
            output.places.drive(self.tableView.rx.items(cellIdentifier: PlaceTableViewCell.reuseID, cellType: PlaceTableViewCell.self)) { tv, viewModel, cell in
                cell.bind(viewModel)
            }.disposed(by: self.disposeBag)
            
            output.isFetching
                .drive()
                .disposed(by: disposeBag)
            output.selectedPlace
                .drive()
                .disposed(by: disposeBag)
        }
    }

}
