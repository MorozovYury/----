//
//  OrganizorsContactsViewController.swift
//  MazTech
//
//  Created by Yury Morozov on 23.12.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit

class OrganizorsContactsViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.delegate = self
        
        setupConstraintsForAllElements()
        setupNavBar()
    }
    
    // MARK: - Setup Navigation Bar
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Контакты организаторов"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    // MARK: Create a Scrollview
    private let myScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.indicatorStyle = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    // MARK: - Organizers info: Alexandra Image
    public let morozovaProfileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Morozova")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Organizers info: Morozova Label
    public let morozovaLabel: UILabel = {
        let label = UILabel()
        label.text = "Александра Морозова"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Call to Morozova button creating
    lazy var callToMorozovaButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("+7 123 456-78-90", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(callToMorozovaMethodButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - callToMorozovaMethodButton action
    @objc func callToMorozovaMethodButton() {
        let url: NSURL = URL(string: "Tel://+71234567890")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
        print(url)
    }
    
    // MARK: - Organizers info: Pegachkov Image
    public let pegachkovProfileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Pegachkov")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        
        return image
    }()
    // MARK: - Organizers info: Pegachkov Label
    public let pegachkovLabel: UILabel = {
        let label = UILabel()
        label.text = "Алексей Пегачков"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Call to Pegachkov button creating
    lazy var callToPegachkovButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("+7 123 456-78-90", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(callToPegachkovMethodButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - callToPegachkovMethodButton action
    @objc func callToPegachkovMethodButton() {
        let url: NSURL = URL(string: "Tel://+71234567890")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
        print(url)
    }
    
    
    // MARK: - Organizers info: Knyazev Image
    public let knyazevProfileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Knyazev")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.size.width/2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        
        return image
    }()
    
    // MARK: - Organizers info: Knyazev Label
    public let knyazevLabel: UILabel = {
        let label = UILabel()
        label.text = "Павел Князев"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Call to Knyazev button creating
    lazy var callToKnyazevButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("+7 123 456-78-90", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(callToKnyazevMethodButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - callToKnyazevMethodButton action
    @objc func callToKnyazevMethodButton() {
        let url: NSURL = URL(string: "Tel://+71234567890")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
        print(url)
    }
    
    // MARK: - Address label
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес: Москва, 5-ый лучевой просек, д. 7, стр. 2, павильон 7А "
        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Create constarints
    fileprivate func setupConstraintsForAllElements() {
        
        // MARK: - constarints for myScrollView
        view.addSubview(myScrollView)
        
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // MARK: - Organizers info constraints: Morozova
        myScrollView.addSubview(morozovaProfileImage)
        myScrollView.addSubview(morozovaLabel)
        myScrollView.addSubview(callToMorozovaButton)
        
        morozovaProfileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        morozovaProfileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        morozovaProfileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        morozovaProfileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        morozovaLabel.leftAnchor.constraint(equalTo: morozovaProfileImage.rightAnchor, constant: 8).isActive = true
        morozovaLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        morozovaLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        morozovaLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        callToMorozovaButton.leftAnchor.constraint(equalTo: morozovaProfileImage.rightAnchor, constant: 8).isActive = true
        callToMorozovaButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        callToMorozovaButton.topAnchor.constraint(equalTo: morozovaLabel.bottomAnchor).isActive = true
        callToMorozovaButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: - Organizers info constraints: Pegachkov
        myScrollView.addSubview(pegachkovProfileImage)
        myScrollView.addSubview(pegachkovLabel)
        myScrollView.addSubview(callToPegachkovButton)
        
        pegachkovProfileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        pegachkovProfileImage.topAnchor.constraint(equalTo: morozovaProfileImage.bottomAnchor, constant: 10).isActive = true
        pegachkovProfileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        pegachkovProfileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        pegachkovLabel.leftAnchor.constraint(equalTo: pegachkovProfileImage.rightAnchor, constant: 8).isActive = true
        pegachkovLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        pegachkovLabel.topAnchor.constraint(equalTo: callToMorozovaButton.bottomAnchor, constant: 10).isActive = true
        pegachkovLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        callToPegachkovButton.leftAnchor.constraint(equalTo: pegachkovProfileImage.rightAnchor, constant: 8).isActive = true
        callToPegachkovButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        callToPegachkovButton.topAnchor.constraint(equalTo: pegachkovLabel.bottomAnchor).isActive = true
        callToPegachkovButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: - Organizers info constraints: Knyazev
        myScrollView.addSubview(knyazevProfileImage)
        myScrollView.addSubview(knyazevLabel)
        myScrollView.addSubview(callToKnyazevButton)
        
        knyazevProfileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        knyazevProfileImage.topAnchor.constraint(equalTo: pegachkovProfileImage.bottomAnchor, constant: 10).isActive = true
        knyazevProfileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        knyazevProfileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        knyazevLabel.leftAnchor.constraint(equalTo: knyazevProfileImage.rightAnchor, constant: 8).isActive = true
        knyazevLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        knyazevLabel.topAnchor.constraint(equalTo: callToPegachkovButton.bottomAnchor, constant: 10).isActive = true
        knyazevLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        callToKnyazevButton.leftAnchor.constraint(equalTo: knyazevProfileImage.rightAnchor, constant: 8).isActive = true
        callToKnyazevButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        callToKnyazevButton.topAnchor.constraint(equalTo: knyazevLabel.bottomAnchor).isActive = true
        callToKnyazevButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: - Address constraint
        view.addSubview(addressLabel)
        
        addressLabel.topAnchor.constraint(equalTo: callToKnyazevButton.bottomAnchor, constant: 40).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        
    }//end of method
    
    
    // MARK - Status Bar change color
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    
}//end of class
