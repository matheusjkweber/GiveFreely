//
//  SafariWebExtensionHandler.swift
//  GiveFreely Extension
//
//  Created by Matheus Weber on 28/01/24.
//

import SafariServices
import os.log

typealias WebExtensionRequest = [AnyHashable : Any]

enum SafariWebExtensionAction: String, Codable {
    case changeFontSize
    case changeColor
    case highlightWord
}

enum SafariWebExtensionError: Error {
    case cannotDecode
    case actionNotReceived
    case noColorProvided
    case noFontSizeProvided
    case noWordsProvided
    
    func descriptionError() -> String {
        switch self {
        case .actionNotReceived:
            return "Message or action cannot be null."
        case .cannotDecode:
            return "Cannot decode request."
        case .noColorProvided:
            return "No color provided."
        case .noWordsProvided:
            return "No words provided."
        case .noFontSizeProvided:
            return "No font size provided."
        }
    }
}

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        guard let data = item.userInfo?[SFExtensionMessageKey] as? [String : Any] else {
            return
        }
        
        do {
            try handle(ExtensionRequest(from: data), context)
        } catch {
            if let safariError = error as? SafariWebExtensionError {
                let response = NSExtensionItem()
                response.userInfo = [ SFExtensionMessageKey: [ "error": safariError.descriptionError() ] ]

                context.completeRequest(returningItems: [ response ], completionHandler: nil)
            } else {
                let response = NSExtensionItem()
                response.userInfo = [ SFExtensionMessageKey: [ "error": error.localizedDescription ] ]

                context.completeRequest(returningItems: [ response ], completionHandler: nil)
            }
            
        }
    }
    
    func handle(_ request: ExtensionRequest, _ context: NSExtensionContext) throws {
        switch request.message.action {
        case .changeFontSize:
            guard let newFontSize = request.message.size else {
                throw SafariWebExtensionError.noFontSizeProvided
            }
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: [ "status": "success", "fontSize": newFontSize ] ]
            context.completeRequest(returningItems: [ response ], completionHandler: nil)
        case .changeColor:
            guard let newColor = request.message.newColor else {
                throw SafariWebExtensionError.noColorProvided
            }
            
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: [ "status": "success", "newColor": newColor ] ]
            context.completeRequest(returningItems: [ response ], completionHandler: nil)
        case .highlightWord:
            guard let keyword = request.message.keyword else {
                throw SafariWebExtensionError.noWordsProvided
            }
            
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: [ "status": "success", "keyword": keyword ] ]
            context.completeRequest(returningItems: [ response ], completionHandler: nil)
        }
    }
}
