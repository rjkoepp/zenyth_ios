//
//  RelationshipManager.swift
//  Zenyth
//
//  Created by Hoang on 8/7/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class RelationshipManager: RelationshipManagerProtocol {
    func sendFriendRequest(toRequesteeId requesteeId: UInt32,
                           onSuccess: RelationshipCallback? = nil,
                           onFailure: JSONCallback? = nil,
                           onRequestError: ErrorCallback? = nil) {
        let route = Endpoint.SendFriendRequests.route()
        APIClient.sharedClient.setAuthorization()
        
        let parameters: Parameters = ["requestee_id" : requesteeId]
        
        APIClient.sharedClient.executeJSON(route: route, parameters: parameters,
                                           onSuccess:
            { json in
                let relationshipJSON = json["data"]["relationship"]
                onSuccess?(Relationship(json: relationshipJSON))
        }, onFailure: onFailure, onRequestError: onRequestError)
    }
    
    func respondToFriendRequest(fromRequesterId requesterId: UInt32,
                                status: Bool,
                                onSuccess: RelationshipCallback? = nil,
                                onFailure: JSONCallback? = nil,
                                onRequestError: ErrorCallback? = nil) {
        let route = Endpoint.RespondToFriendRequests.route()
        APIClient.sharedClient.setAuthorization()
        
        let parameters: Parameters = [
            "requester_id" : requesterId,
            "status" : status
        ]
        
        APIClient.sharedClient.executeJSON(route: route, parameters: parameters,
                                           onSuccess:
            { json in
                let relationshipJSON = json["data"]["relationship"]
                onSuccess?(Relationship(json: relationshipJSON))
        }, onFailure: onFailure, onRequestError: onRequestError)
    }
    
    func deleteFriend(withUserId userId: UInt32,
                      onSuccess: JSONCallback? = nil,
                      onFailure: JSONCallback? = nil,
                      onRequestError: ErrorCallback? = nil) {
        let route = Endpoint.DeleteFriend(userId).route()
        APIClient.sharedClient.setAuthorization()
        
        APIClient.sharedClient.executeJSON(route: route,
                                           onSuccess:
            { json in
                onSuccess?(json)
        }, onFailure: onFailure, onRequestError: onRequestError)
    }
    
    func blockUser(withUserId userId: UInt32,
                   onSuccess: RelationshipCallback? = nil,
                   onFailure: JSONCallback? = nil,
                   onRequestError: ErrorCallback? = nil) {
        let route = Endpoint.BlockUser.route()
        APIClient.sharedClient.setAuthorization()
        
        let parameters: Parameters = ["user_id" : userId]
        
        APIClient.sharedClient.executeJSON(route: route, parameters: parameters,
                                           onSuccess:
            { json in
                let relationshipJSON = json["data"]["relationship"]
                onSuccess?(Relationship(json: relationshipJSON))
        }, onFailure: onFailure, onRequestError: onRequestError)
    }
}