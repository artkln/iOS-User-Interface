//
//  FriendsController.swift
//  VK Client
//
//  Created by Артём Калинин on 11.03.2021.
//

import UIKit

class FriendsController: UITableViewController, UISearchBarDelegate {
    
    static var selectedFriend: String?
    static var friendsData = [User]()
    static var filteredData: [User] = [] {
        didSet {
            var tempFirstLetters: [String] = []
            for friend in FriendsController.filteredData {
                if !tempFirstLetters.contains(String(friend.name.first!)) {
                    tempFirstLetters.append(String(friend.name.first!))
                }
            }
            FriendsController.firstLetters = tempFirstLetters
        }
    }
    static var firstLetters: [String] = [] {
        didSet {
            FriendsController.letterControl.setupView()
            FriendsController.letterControl.frame = CGRect(
            x: UIScreen.main.bounds.size.width - 20,
            y: UIScreen.main.bounds.size.height / 2 - (CGFloat(FriendsController.firstLetters.count) * 18) / 2,
            width: 20,
            height: CGFloat(FriendsController.firstLetters.count * 18))
        }
    }
    private let headerReuseIdentifier = "FriendsHeader"
    
    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var endColor: UIColor = .white
    
    static var letterControl = LetterControl(frame: CGRect(
            x: UIScreen.main.bounds.size.width - 20,
            y: UIScreen.main.bounds.size.height / 2 - (CGFloat(FriendsController.firstLetters.count) * 18) / 2,
            width: 20,
            height: CGFloat(FriendsController.firstLetters.count * 18)))
    
    @IBOutlet weak var searchControl: SearchControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 0.83, green: 0.80, blue: 0.72, alpha: 1.00)
        tableView.register(UINib(nibName: "FriendsTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
        
        FriendsController.friendsData = User.getData()
        FriendsController.friendsData.sort { $0.name < $1.name }
        FriendsController.filteredData = FriendsController.friendsData
        
        self.navigationController?.view.addSubview(FriendsController.letterControl)
        FriendsController.letterControl.addTarget(self, action: #selector(indexDidChange), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FriendsController.filteredData = FriendsController.friendsData
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return FriendsController.firstLetters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstLetter = FriendsController.firstLetters[section]
        var count: Int = 0
        for friend in FriendsController.filteredData {
            if String(friend.name.first!) == firstLetter {
                count += 1
            }
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        let firstLetter = FriendsController.firstLetters[indexPath.section]
        let startIndex = FriendsController.filteredData.firstIndex { String($0.name.first!) == firstLetter }
        
        let friendName = FriendsController.filteredData[startIndex! + indexPath.row].name
        let friendImage = FriendsController.filteredData[startIndex! + indexPath.row].profileImage
        
        cell.configure(name: friendName, image: friendImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let firstLetter = FriendsController.firstLetters[indexPath.section]
        let startIndex = FriendsController.filteredData.firstIndex { String($0.name.first!) == firstLetter }
        
        FriendsController.selectedFriend = FriendsController.filteredData[startIndex! + indexPath.row].name
        
        FriendsController.firstLetters = []
        
        searchControl.hideKeyboard()
        
        performSegue(withIdentifier: "toPhotos", sender: self)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! FriendsTableViewHeader
        
        header.configure(text: FriendsController.firstLetters[section])
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toPhotos",
           let destination = segue.destination as? PhotosController {
            destination.title = FriendsController.selectedFriend
        }
    }
    
    @objc func indexDidChange(_ sender: LetterControl) {
        let indexPath = IndexPath(row: 0, section: sender.selectedIndex!)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        FriendsController.filteredData = searchControl.searchText.isEmpty ? FriendsController.friendsData : FriendsController.friendsData.filter( {(item: User) -> Bool in
            return item.name.range(of: searchControl.searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
    }
}
