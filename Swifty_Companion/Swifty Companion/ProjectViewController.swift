//
//  ProjectViewController.swift
//  Swifty Companion
//
//  Created by Lance CHANT on 2018/10/16.
//  Copyright © 2018 Lance CHANT. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectList.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Projects") as! ProjectTableViewCell
        cell.ProjectList = ProjectList.data[indexPath.row]
        if ProjectList.data[indexPath.row].0 == true {
            cell.backgroundColor = UIColor.green
        }
        else if ProjectList.data[indexPath.row].0 == false {
            cell.backgroundColor = UIColor.red
        } else {
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
    

    @IBOutlet weak var Table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
