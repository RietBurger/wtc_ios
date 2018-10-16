//
//  ApiController.swift
//  SwiftyCompanion
//
//  Created by Jeanette Henriette BURGER on 2018/10/15.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit

class ApiController: NSObject {
    
    let uid = "751327c0145179dc9c35e5d37a1bbf0234bf747f73470612acbbc5c5c54ed275";
    let secret = "0918d73431090567e47753b5ee61cca99e4d81a72621fa2151d35e24cc30a2d3";
    
//    func getAccessToken(){
//
//        // create post request
//        let url = URL(string: "https://api.intra.42.fr/oauth/token?grant_type=authorization_code&client_id=\(uid)&client_secret=\(secret)&code=\(code)&redirect_uri=http://Rush00")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        let group = DispatchGroup();
//        let task = URLSession.shared.dataTask(with: request) {
//            (data, response, error) in
//            print(response as Any)
//            if let err = error{
//                print(err)
//            }
//            else if let d = data{
//                do{
//                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
//                        if let temp = dic["access_token"]
//                        {
//                            print("your token: ")
//                            userToken = (temp as! String)
//                            print(userToken)
//                        }
//                    }
//                }
//                catch(let err){
//                    print(err)
//                }
//            }
//            group.leave()
//        }
//        group.enter()
//        task.resume()
//        group.wait()
//    }

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
//                            print("get token", token)
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
