//
//  ApiController.swift
//  Forum
//
//  Created by Lance CHANT on 2018/10/07.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit

//var userToken = ""
//var token = ""

class ApiController: NSObject {
    
    let uid = "b654f310dbf2bada79b1ed5cb10d6b19ece7fc5649ad79ca9e4dbfc349fd082c";
    let secret = "71ae6d11e5da5bdd03c9dcae3afe961c16089038137df2da7875ebc33d33f820";

    func getAccessToken(){
        
        // create post request
        let url = URL(string: "https://api.intra.42.fr/oauth/token?grant_type=authorization_code&client_id=\(uid)&client_secret=\(secret)&code=\(code)&redirect_uri=http://Rush00")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let group = DispatchGroup();
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            print(response as Any)
            if let err = error{
                print(err)
            }
            else if let d = data{
                do{
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                        if let temp = dic["access_token"]
                        {
                            print("your token: ")
                            userToken = (temp as! String)
                            print(userToken)
                        }
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
    }
    
    func getToken() {
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
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                        if let temp = dic["access_token"]
                        {
                            token = temp as! String
                            print("get token", token)
                        }
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
    }

}
