//
//  EmojiTableViewController.swift
//  emojiReader
//
//  Created by Alexander Airumian on 10.07.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var objects = [Emoji(emoji: "🥰", name: "Love", discription: "Love you", isFavourite: false),
                   Emoji(emoji: "😎", name: "Cool", discription: "Very cool", isFavourite: false),
                   Emoji(emoji: "🧠", name: "Brain", discription: "You genius", isFavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
      
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else {return}
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
        let newIndexPath = IndexPath(row: objects.count, section: 0)
        objects.append(emoji)
        tableView.insertRows(at: [newIndexPath], with: .fade)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji "  else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newEmoji = navigationVC.topViewController as! NewEmojiTableViewController
        newEmoji.emoji = emoji
        newEmoji.title = "Edit Emoji"
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        
        let object = objects[indexPath.row]
        cell.set(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at:indexPath)
        let favourite = isFavourite(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done,favourite])
    }
    
    func doneAction(at indexpath:IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action,view, completion) in
            self.objects.remove(at: indexpath.row)
            self.tableView.deleteRows(at: [indexpath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func isFavourite(at indexpath:IndexPath) -> UIContextualAction {
        var object = objects[indexpath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view,complection) in
            object.isFavourite = !object.isFavourite
            self.objects[indexpath.row] = object
            complection(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
