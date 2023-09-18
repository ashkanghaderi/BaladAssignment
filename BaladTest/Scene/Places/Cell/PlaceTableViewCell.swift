//
//  PlaceTableViewCell.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ model: PlaceModel){
        title.text = model.name
        desc.text = model.location?.address
    }
    
}
