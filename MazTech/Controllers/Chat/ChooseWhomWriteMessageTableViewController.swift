//
//  NewMessageController.swift
//  MazTech
//
//  Created by Yury Morozov on 11.10.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//NewMessageController
class ChooseWhomWriteMessageTableViewController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [UserProfileInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(ListOfUsersCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
        setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Написать сообщение"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    
    func fetchUser() {
        Database.database().reference().child("listOfUsers").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UserProfileInformation(dictionary: dictionary)
                user.userID = snapshot.key
                
                self.users.append(user)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListOfUsersCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.fullName
        cell.detailTextLabel?.text = user.jobPosition
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var listOfChatsTableViewController: ListOfChatsTableViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("Dismiss completed")
            let user = self.users[indexPath.row]
            self.listOfChatsTableViewController?.showTypingMessagesCollectionViewController(user)
        }
    }
    
}
