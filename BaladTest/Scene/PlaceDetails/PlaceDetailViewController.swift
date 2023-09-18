//
//  PlaceDetailViewController.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import Kingfisher

class PlaceDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var extraInfo1: UILabel!
    @IBOutlet weak var extraInfo2: UILabel!
    @IBOutlet weak var extraInfo3: UILabel!
    var viewModel: PlaceDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = PlaceDetailViewModel.Input()
        let output = self.viewModel.transform(input: input)
        output.isFetching
            .drive()
            .disposed(by: disposeBag)
        output.selectedPlace
            .drive(placeDetailBinding)
            .disposed(by: disposeBag)
    }
    
    var placeDetailBinding: Binder<PlaceModel> {
        return Binder(self, binding: { (vc, place) in
            if let url = URL(string: "\(String(describing: place.categories?.first?.icon.iconPrefix))" + "\(String(describing: place.categories?.first?.icon.suffix))") {
                vc.placeImage.kf.setImage(with: url)
            }
            vc.extraInfo1.text = place.categories?.first?.name
            vc.extraInfo2.text = place.timezone
            vc.extraInfo3.text = place.location?.region
        })
    }

}
