//
//  AllGroupsСontroller.swift
//  VK Client
//
//  Created by Артём Калинин on 09.03.2021.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {

    var groupsData = [Group]()
    var filteredData = [Group]()
    
    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var endColor: UIColor = .white
    
    @IBOutlet weak var searchControl: SearchControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 0.83, green: 0.80, blue: 0.72, alpha: 1.00)
        
        groupsData = Group.getData()
        
        filteredData = groupsData
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsCell
        
        let groupName = filteredData[indexPath.row].name
        let groupImage = filteredData[indexPath.row].image
        
        cell.configure(name: groupName, image: groupImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchControl.hideKeyboard()
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        filteredData = searchControl.searchText.isEmpty ? groupsData : groupsData.filter( {(item: Group) -> Bool in
            return item.name.range(of: searchControl.searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
    }
}
