//
//  Chat.swift
//  ChatItUp
//
//  Created by Jim Campagno on 11/15/16.
//  Copyright © 2016 Jim Campagno. All rights reserved.
//

import Foundation

typealias TimeStamp = [AnyHashable : Any]

struct Chat {
    
    let uniqueID: String
    var title: String
    var timestamp: TimeStamp
    var members: [Member]
    
    var lastMessage: String?
    var messages: [Message]?
    
    init(uniqueID: String, title: String, timestamp: TimeStamp, members: [Member]) {
        self.uniqueID = uniqueID
        self.title = title
        self.timestamp = timestamp
        self.members = members
    }
}


// MARK: - Firebase
extension Chat {
    
    func chatsSerialize() -> [String : Any] {
        
        var info: [String : Any] = [:]
        
        info["title"] = title
        info["lastmessage"] = " "
        info["timestamp"] = timestamp
        
        return info
        
    }
    
    func membersSerialize() -> [String : Any] {
        
        var info: [String : Any] = [:]
        
        for member in members {
            info[member.name] = true
        }
        
        return info
    }
    
    
    
}
