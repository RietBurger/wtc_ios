//
//  ApiController.swift
//  Swifty Companion
//
//  Created by Lance CHANT on 2018/10/15.
//  Copyright © 2018 Lance CHANT. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiController: NSObject {
    
    let uid = "b654f310dbf2bada79b1ed5cb10d6b19ece7fc5649ad79ca9e4dbfc349fd082c";
    let secret = "71ae6d11e5da5bdd03c9dcae3afe961c16089038137df2da7875ebc33d33f820";
    
    struct Message: Decodable {
        let id: Int
        let name: String
        let created_at: String
    }
    
    func getUser(username: String, completion: @escaping (JSON?) -> Void) {
        let userUrl = NSURL(string: "https://api.intra.42.fr/v2/users/" + username)
        let bearer = "Bearer " + token
        print("this is token in getUser: \(token)")
        var request = URLRequest(url: userUrl! as URL)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completion(json)
                }
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getToken() {
        let verify = UserDefaults.standard.object(forKey: "token")
        print("this is token in getToken: \(token)")
        print("this is verify in getToken(): \(verify)")
        if verify == nil {
            let url = URL(string: "https://api.intra.42.fr/v2/oauth/token")
            
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = "grant_type=client_credentials&client_id=\(uid)&client_secret=\(secret)".data(using: String.Encoding.utf8)
            let group = DispatchGroup();
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                (data, response, error) in
                print(response as Any)
                if let err = error{
                    print(err)
                }
                else if let d = data{
                    do{
                        if token == "" {//RED
                        if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                            if let temp = dic["access_token"]
                            {
                                token = temp as! String
                                self.checkToken()
                            }
                        }
                        } else {//RED
                            self.checkToken()
                        }
                    }
                    catch(let err){
                        print(err)
                    }
                }
                group.leave()
            }
            group.enter()
            task.resume()
            group.wait()
        } else {
            token = verify as! String
            checkToken()
        }
    }
    
    func checkToken() {
        let check = NSURL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + token
        var request = URLRequest(url: check! as URL)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
                
            case .success:
                print("this is .success response.result: \(response.result)")
                print("this is .success token: \(token)")
                if let value = response.result.value {
                    let json = JSON(value)
                    print("The token will expire in:", json["expires_in_seconds"], "seconds.")
                }
            case .failure:
                print("this is .failure response.result: \(response.result)")
                print("this is .failure token: \(token)")
                print("Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
    }
    
}

