//
//  SettingsViewController.swift
//  MazTech
//
//  Created by Yury Morozov on 01.12.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    // MARK: - Update Profile Information Button creating
    lazy var updateUserProfileButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Изменить данные пользователя", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleUpdateUserInfo), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Update Profile Email and Pass Information Button creating
    lazy var updateUserEmailAndPasswordProfileButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Изменить почту и пароль", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleUpdateUserEmailAndPassInfo), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LogOut Button creating
    lazy var logOutButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        setupNavBar()
        setupAllConstraintsForAllElements()
        
    }
    
    // MARK: - Setup Navigation Bar
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Настройки"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    func setupAllConstraintsForAllElements() {
        
        // MARK: - Constraints Update User Information button
        view.addSubview(updateUserProfileButton)
        updateUserProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateUserProfileButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        updateUserProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // MARK: - Constraints Update User Email and Password Information button
        view.addSubview(updateUserEmailAndPasswordProfileButton)
        updateUserEmailAndPasswordProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateUserEmailAndPasswordProfileButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        updateUserEmailAndPasswordProfileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        updateUserEmailAndPasswordProfileButton.topAnchor.constraint(equalTo: updateUserProfileButton.bottomAnchor, constant: 10).isActive = true
        
        // MARK: - LogOut button
        view.addSubview(logOutButton)
        logOutButton.topAnchor.constraint(equalTo: updateUserEmailAndPasswordProfileButton.bottomAnchor, constant: 10).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)  .isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
    }
    
    // MARK: - LogOut Button Method
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LogInViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    // MARK: - Update User Info Button Method
    @objc func handleUpdateUserInfo() {
        let updateUserInfoContr = UpdateUserInformationViewController()
        present(updateUserInfoContr, animated: true, completion: nil)
    }
    
    // MARK: - Update User Pass and EmailInfo Button Method
    @objc func handleUpdateUserEmailAndPassInfo() {
        let updateUserEmailAndPassInfoContr = UpdateUserEmailAndPasswordInformationViewController()
        present(updateUserEmailAndPassInfoContr, animated: true, completion: nil)
    }
    
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
}// end of class
