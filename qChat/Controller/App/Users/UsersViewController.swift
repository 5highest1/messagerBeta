//
//  UsersViewController.swift
//  qChat
//
//  Created by Highest on 20.10.2024.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let servise = Servise.shared
    var users = [CurentUser]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UsersCellTableViewCell", bundle: nil), forCellReuseIdentifier: UsersCellTableViewCell.reoseId)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        getUsers()
        
    }
    func getUsers() {
        servise.getAllUsers { users in
            self.users = users
            self.tableView.reloadData()
            
        }
    }
}
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersCellTableViewCell.reoseId, for: indexPath) as? UsersCellTableViewCell
        cell?.selectionStyle = .none
        let cellname = users [indexPath.row]
        cell?.configCell(cellname.email)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let userId = users[indexPath.row].id
        
        let vc = ChatViewController()
        vc.otherId = userId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    
}
