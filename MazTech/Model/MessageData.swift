//
//  Message.swift
//  MazTech
//
//  Created by Yury Morozov on 11.10.2018.
//  Copyright © 2018 Yury Morozov. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessageData: NSObject {
    
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    var videoUrl: String?
    
    var imageUrl: String?
    var imageWidth: Float?
    var imageHeight: Float?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.imageUrl = dictionary["imageUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? Float
        self.imageHeight = dictionary["imageHeight"] as? Float
        self.videoUrl = dictionary["videoUrl"] as? String
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
}
