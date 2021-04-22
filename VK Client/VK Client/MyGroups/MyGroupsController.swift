//
//  MyGroupsController.swift
//  VK Client
//
//  Created by Артём Калинин on 10.03.2021.
//

import UIKit

class MyGroupsController: UITableViewController, UISearchBarDelegate {

    var groupsData = [Group]()
    var filteredData = [Group]()
    
    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var endColor: UIColor = .white
    
    @IBOutlet weak var searchControl: SearchControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 0.83, green: 0.80, blue: 0.72, alpha: 1.00)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
        
        let groupName = filteredData[indexPath.row].name
        let groupImage = filteredData[indexPath.row].image
        
        cell.configure(name: groupName, image: groupImage)
        
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            
            guard let allGroupsController = segue.source as? AllGroupsController else { return }
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                
                let groupName = allGroupsController.filteredData[indexPath.row].name
                let groupImage = allGroupsController.filteredData[indexPath.row].image
                
                if groupsData.count == 0 {
                    groupsData.append(Group(name: groupName, image: groupImage))
                    filteredData.append(Group(name: groupName, image: groupImage))
                    tableView.reloadData()
                }
                
                if !groupsData.contains(Group(name: groupName, image: groupImage)) {
                    groupsData.append(Group(name: groupName, image: groupImage))
                    filteredData.append(Group(name: groupName, image: groupImage))
                    tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchControl.hideKeyboard()
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsData.remove(at: indexPath.row)
            filteredData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        filteredData = searchControl.searchText.isEmpty ? groupsData : groupsData.filter( {(item: Group) -> Bool in
            return item.name.range(of: searchControl.searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
    }
}
