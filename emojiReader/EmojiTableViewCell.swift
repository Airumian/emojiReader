//
//  EmojiTableViewCell.swift
//  emojiReader
//
//  Created by Alexander Airumian on 10.07.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func set(object: Emoji) {
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.discriptionLabel.text = object.discription
    }
}
