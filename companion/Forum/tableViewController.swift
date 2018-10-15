//
//  tableViewController.swift
//  Forum
//
//  Created by Jeanette Henriette BURGER on 2018/10/05.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    var userData = String()
    
//    init (json: [String: Any]) {
//        opened = false
//        title = (json["name"] as? String)!
//        sectionData = ["this", "is", "me"]
//        userData = (json["author"] as? String)!
//    }
}

struct Author: Decodable{
    let login:String
}
struct Message: Decodable {
    let id: Int
    let name: String
    let created_at: String
    let author: Author
}

//struct newData {
////    var opened = Bool()
//    vat titles = String()
////    var sectionData = [String]()
//    var userDatas = String()
//
//        init (json: [String: Any]) {
////            opened = false
//            titles = (json["name"] as? String)!
////            sectionData = ["this", "is", "me"]
//            userDatas = (json["author"] as? String)!
//        }
//}

class tableViewController: UITableViewController {

    var apiUse = token

    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(apiUse)
        
        func getTopic(_ page: Int) {
            var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics?access_token=" + (token) + "&page=\(page)")!)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    (data, response, error) in
//                    print(response as Any)
                    if error != nil {
                        print(error as Any)
                    } else {
                    guard let data = data else { return }
                
                        if let httpResponse = response as? HTTPURLResponse {
                            if httpResponse.statusCode == 200 {
                        do {
                            
                            print("enter d = data")
                            let _messages = try JSONDecoder().decode([Message].self, from: data)
                            for message in _messages{
//                                Data.messages.append(message)
                                print("hererererere", message.id)
                                self.tableViewData = [cellData(opened: false, title: message.name, sectionData: ["Cell1", "Cell2", "Cell3", "cell4"], userData: message.created_at)
                                ]
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }

                                print("json finished")
//                                print(json)
                        
                    }
                    catch (let err) {
                        print(err)
                    }
                }
            }
                    }
//                else {
//                        print("not getting data to d")
//                }
                }
                task.resume()
        }
        getTopic(1)
        
        tableViewData = [cellData(opened: false, title: "Title1", sectionData: ["Cell1", "Cell2", "Cell3", "cell4"], userData: "rburger - data/time"),
                         cellData(opened: false, title: "Title2", sectionData: ["Cell1", "Cell2", "Cell3"], userData: "rburger - data/time"),
                         cellData(opened: false, title: "Title3", sectionData: ["Cell1", "Cell2", "Cell3", "cell4", "cell5"], userData: "rburger - data/time"),
                         cellData(opened: false, title: "Title4", sectionData: ["Cell1", "Cell2", "Cell3"], userData: "rburger - data/time")
        ]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
                cell.textLabel?.text = tableViewData[indexPath.section].title
                cell.detailTextLabel?.text = tableViewData[indexPath.section].userData
                return cell
            } else {
                // use different cell identifier if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            cell.detailTextLabel?.text = tableViewData[indexPath.section].userData
            
//            print("this is cell: ")
//            print(cell)
//            print("this is : tableViewData[indexPath.section] ")
//            print(tableViewData[indexPath.section])
//            print("this is: tableViewData[indexPath.section].sectionData[indexPath.row - 1]")
//            print(tableViewData[indexPath.section].sectionData[indexPath.row - 1])
                return cell
            }
    }
    
    func options(position: Int) {
        print("row position is: ")
        print(position)

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
//                print("this is title [true]: ")
//                print(tableViewData[indexPath.section].title)
                let sections = IndexSet.init(integer: indexPath.section)
//                print("this should be sections as int: ")
//                print(sections)
                tableView.reloadSections(sections, with: .none) // play with these
            } else {
//                print("this is title [false]: ")
//                print(tableViewData[indexPath.section].title)
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none) // play with these
            }
        }
        else {
        // put edit or delete popup/function here
//            options(position: indexPath.row)
    }
    }
}
