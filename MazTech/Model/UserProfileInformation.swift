//
//  User.swift
//  MazTech
//
//  Created by Yury Morozov on 11.10.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit

class UserProfileInformation: NSObject {
    var userID: String?
    var city: String?
    var companyName: String?
    var email: String?
    var fullName: String?
    var jobPosition: String?
    var profileImageUrl: String?
    //var scoreOfTest: Int
    
    init(dictionary: [String: AnyObject]) {
        self.userID = dictionary["userID"] as? String
        self.fullName = dictionary["fullName"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        self.city = dictionary["city"] as? String
        self.companyName = dictionary["companyName"] as? String
        self.jobPosition = dictionary["jobPosition"] as? String
    }
    
}
