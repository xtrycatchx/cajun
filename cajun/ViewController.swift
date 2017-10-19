//
//  ViewController.swift
//  cajun
//
//  Created by Paul Sydney Orozco on 7/10/17.
//  Copyright © 2017 Paul Sydney Orozco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var secretList: [Secret] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            secretList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secretList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell =
            tableView.dequeueReusableCell(withIdentifier: "tableViewCell") else {
                return UITableViewCell()
        }
        cell.textLabel?.textColor = hexStringToUIColor(hex: "8BC34A")
        cell.textLabel?.text = secretList[indexPath.row].target + " : **********"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.contentView.backgroundColor = hexStringToUIColor(hex: "9CCC65")
        cell.textLabel?.textColor = UIColor.white
    }
    
   @IBAction func unwindToViewController(segue: UIStoryboardSegue){
        if segue.identifier == "unwindSegue" {
            guard let addNewToDoViewController = segue.source as? SecretViewController else {
                return
            }
            guard let target = addNewToDoViewController.target.text else { return }
            guard let content = addNewToDoViewController.content.text else { return }
            let targetTrimmed = target.trimmingCharacters(in: .whitespaces)
            let contentTrimmed = content.trimmingCharacters(in: .whitespaces)
            secretList.append(Secret(target: targetTrimmed, content: contentTrimmed))
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //let sourceItemIndexPath = sourceIndexPath.row
        //let destinationItemIndexPath = destinationIndexPath.row
        //let toDoItem = secretList[sourceItemIndexPath]
        
        //if sourceItemIndexPath != destinationItemIndexPath {
        //    secretList.swapAt(sourceItemIndexPath, destinationItemIndexPath)
        //}// else {
        //   todoList.insert(toDoItem, at: destinationItemIndexPath)
        //   todoList.remove(at: sourceItemIndexPath)
        //}
    }
}

