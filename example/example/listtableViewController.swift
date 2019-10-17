//
//  listtableViewController.swift
//  example
//
//  Created by youjin on 12/10/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit
import SQLite3

class listtableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableViewHeroes: UITableView!
    var heroList = [Hero]()
    var db: OpaquePointer?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("HeroesDatabase.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        readValues()


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let hero: Hero
        hero = heroList[indexPath.row]
        cell.textLabel?.text = hero.name
        return cell
    }
    
    func readValues(){
        heroList.removeAll()
        let queryString = "SELECT * FROM Heroes"
        
        var Stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &Stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        print("sqlite row: \(SQLITE_ROW)")
        
        while(sqlite3_step(Stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(Stmt,0)
            let name = String(cString: sqlite3_column_text(Stmt, 1 ))
            
            heroList.append(Hero(id: Int(id), name:String(describing: name)))
        }
        
        self.tableViewHeroes.reloadData()
        
    }

   

}
