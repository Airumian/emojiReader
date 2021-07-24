//
//  NewEmojiTableViewController.swift
//  emojiReader
//
//  Created by Alexander Airumian on 11.07.2021.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {

    var emoji = Emoji(emoji: "", name: "", discription: "", isFavourite: false)
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateSaveButtonState()
        
    }
    
    private func updateSaveButtonState() {
        let emojiTextField = emojiTextField.text ?? ""
        let nameTextField = nameTextField.text ?? ""
        let descriptionTextField = descriptionTextField.text ?? ""
        saveButton.isEnabled = !emojiTextField.isEmpty && !nameTextField.isEmpty && !descriptionTextField.isEmpty
    }
    
    private func updateUI(){
        emojiTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.discription
        
    }
    
    
    @IBAction func textChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender:sender)
        guard segue.identifier == "saveSague" else {return}
        
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, discription: description, isFavourite: self.emoji.isFavourite)
    }
}
