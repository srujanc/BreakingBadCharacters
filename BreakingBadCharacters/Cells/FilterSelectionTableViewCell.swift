//
//  FilterSelectionTableViewCell.swift
//  BreakingBadCharacters
//
//  Created by Srujan on 12/01/21.
//

import UIKit

class FilterSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var filterNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI(name : String){
        filterNameLabel.text = name
    }

}
