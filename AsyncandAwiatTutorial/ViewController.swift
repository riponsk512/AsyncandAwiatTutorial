//
//  ViewController.swift
//  AsyncandAwiatTutorial
//
//  Created by Ripon sk on 08/10/22.
//

import UIKit
struct User:Codable{
    var name:String?
    var username:String?
}
class ViewController: UIViewController {
var arrUser = [User]()
    @IBOutlet weak var tables: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init { // async has deprecated
            let users = await fetchUserdata()
            self.arrUser = users
            tables.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrUser[indexPath.row].name
        return cell
    }
    
    
}
extension ViewController{
    func fetchUserdata() async ->[User]{
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else
        {
            return []
        }
        do{
            let(data,_) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([User].self, from: data)
            
        }catch{
            return []
        }
        
    }
}
