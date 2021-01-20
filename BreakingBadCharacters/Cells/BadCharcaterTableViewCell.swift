//
//  BadCharcaterTableViewCell.swift
//  BreakingBadCharacters
//
//  Created by Srujan on 12/01/21.
//

import UIKit

class BadCharcaterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI(badCharacter : BadCharacterElement){
        characterNameLabel.text = badCharacter.name
        characterImage.downloaded(from: badCharacter.img)
    }

}
