//
//  ExtensionRequest.swift
//  GiveFreely Extension
//
//  Created by Matheus Weber on 28/01/24.
//

import Foundation

struct ExtensionRequest {
    struct ExtensionMessage {
        var action: SafariWebExtensionAction
        var size: Int?
        var newColor: String?
        var keyword: [String]?
        
        init(from dict: [String: Any]) throws {
            guard let stringAction = dict["action"] as? String, let action = SafariWebExtensionAction(rawValue: stringAction) else {
                throw SafariWebExtensionError.cannotDecode
            }
            self.action = action
            self.size = Int(dict["size"] as? String ?? "0")
            self.newColor = dict["color"] as? String
            self.keyword = dict["keyword"] as? [String] ?? []
        }
    }
    var message: ExtensionMessage
    
    init(from dict: [String: Any]) throws {
        guard let message = dict["message"] as? [String: Any] else {
            throw SafariWebExtensionError.cannotDecode
        }
        self.message = try ExtensionMessage(from: message)
    }
}

