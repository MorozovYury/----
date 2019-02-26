//
//  EventScheduleViewController.swift
//  MazTech
//
//  Created by Yury Morozov on 09.12.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit

class EventScheduleViewController: UIViewController {
    
    let firstTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "С 12:30"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let firstNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Сбор гостей и участников конкурса."
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Second Row
    let secondTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "13:50 - 14:20"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let secondNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Торжественное открытие конкурса."
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Third Row
    let thirdTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "14:20 - 15:45"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let thirdNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Конкурс технических специалистов."
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Fourth Row
    
    let fourthTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "15:50 - 17:10"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let fourthNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Конкурс мастеров-консультантов."
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Fifth Row

    let fifthTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "17:10 - 18:25"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let fifthNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Конкурс инженеров по гарантии."
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Sixth Row
    let sixthTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "18:25 - 22:00"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let sixthNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Подведение итогов конкурса. Награждение победителей. Ужин."
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textColor = UIColor.white
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Расписание 7 февраля 2019"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    // MARK - Status Bar change color
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        setupConstraints()
        setupNavBar()
    }
    
    // MARK: - MainImageView adding into view and add constraints
    private func setupConstraints() {

        // MARK: - firstTimeLabel
        view.addSubview(firstTimeLabel)
        firstTimeLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        firstTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        firstTimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        firstTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        // MARK: - firstNoteLabel
        view.addSubview(firstNoteLabel)
        firstNoteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        firstNoteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        firstNoteLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        firstNoteLabel.leftAnchor.constraint(equalTo: firstTimeLabel.rightAnchor).isActive = true

        // MARK: - secondTimeLabel
        view.addSubview(secondTimeLabel)
        secondTimeLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        secondTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        secondTimeLabel.topAnchor.constraint(equalTo: firstTimeLabel.bottomAnchor).isActive = true
        secondTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        // MARK: - secondNoteLabel
        view.addSubview(secondNoteLabel)
        secondNoteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        secondNoteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        secondNoteLabel.topAnchor.constraint(equalTo: firstNoteLabel.bottomAnchor).isActive = true
        secondNoteLabel.leftAnchor.constraint(equalTo: secondTimeLabel.rightAnchor).isActive = true

        // MARK: - thirdRowTimeView
        view.addSubview(thirdTimeLabel)
        thirdTimeLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        thirdTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        thirdTimeLabel.topAnchor.constraint(equalTo: secondTimeLabel.bottomAnchor).isActive = true
        thirdTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        // MARK: - thirdRowNoteView
        view.addSubview(thirdNoteLabel)
        thirdNoteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        thirdNoteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        thirdNoteLabel.topAnchor.constraint(equalTo: secondNoteLabel.bottomAnchor).isActive = true
        thirdNoteLabel.leftAnchor.constraint(equalTo: thirdTimeLabel.rightAnchor).isActive = true

        // MARK: - fourthRowTimeView
        view.addSubview(fourthTimeLabel)
        fourthTimeLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fourthTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        fourthTimeLabel.topAnchor.constraint(equalTo: thirdTimeLabel.bottomAnchor).isActive = true
        fourthTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        // MARK: - fourthRowNoteView
        view.addSubview(fourthNoteLabel)
        fourthNoteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fourthNoteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        fourthNoteLabel.topAnchor.constraint(equalTo: thirdNoteLabel.bottomAnchor).isActive = true
        fourthNoteLabel.leftAnchor.constraint(equalTo: fourthTimeLabel.rightAnchor).isActive = true

        // MARK: - fifthRowTimeView
        view.addSubview(fifthTimeLabel)
        fifthTimeLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fifthTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        fifthTimeLabel.topAnchor.constraint(equalTo: fourthTimeLabel.bottomAnchor).isActive = true
        fifthTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        // MARK: - fifthRowNoteView
        view.addSubview(fifthNoteLabel)
        fifthNoteLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fifthNoteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        fifthNoteLabel.topAnchor.constraint(equalTo: fourthNoteLabel.bottomAnchor).isActive = true
        fifthNoteLabel.leftAnchor.constraint(equalTo: fifthTimeLabel.rightAnchor).isActive = true

        // MARK: - sixthRowTimeView
        view.addSubview(sixthTimeLabel)
        sixthTimeLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sixthTimeLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        sixthTimeLabel.topAnchor.constraint(equalTo: fifthTimeLabel.bottomAnchor).isActive = true
        sixthTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        // MARK: - sixthRowNoteView
        view.addSubview(sixthNoteLabel)
        sixthNoteLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sixthNoteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        sixthNoteLabel.topAnchor.constraint(equalTo: fifthNoteLabel.bottomAnchor).isActive = true
        sixthNoteLabel.leftAnchor.constraint(equalTo: sixthTimeLabel.rightAnchor).isActive = true
    }
}//end of class
