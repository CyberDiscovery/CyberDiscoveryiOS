//
//  EventsTableViewController.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EventsTableViewController: UITableViewController {
    var ref:DatabaseReference!
    var events = [eventStruct]()
    
    struct eventStruct {
        let name: String!
        let countdown: String!
        let image: String!
        let subtext: String!
    }
    
    func loadEvents() {
        ref = Database.database().reference()
        ref.child("Events").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let count = value?["count"] as! Int
            
            for i in (0..<count).reversed() {
                let currValue = value?[String(i)] as? NSDictionary
                
                let name = currValue?["name"] as? String ?? ""
                let timestamp = currValue?["timestamp"] as? Int ?? 0
                let image = currValue?["image"] as? String ?? ""
                let subtext = currValue?["description"] as? String ?? ""
                
                let date = Date(milliseconds: timestamp)
                
                self.events.insert(eventStruct(name: name, countdown: countdown(to: date), image: image, subtext: subtext), at: 0)
            }
            //Reload tableView
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.tableView.estimatedRowHeight = 320.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.allowsSelection = false
        
        loadEvents()
    }


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! EventTableViewCell
        
        
        let url = URL(string:events[indexPath.row].image)
        if let data = try? Data(contentsOf: url!)
        {
            cell.headerImage.image = UIImage(data: data)
        }
        
        cell.name.text = events[indexPath.row].name
        cell.subtext.text = events[indexPath.row].subtext
        cell.time.text = events[indexPath.row].countdown
        return cell
    }    
}
