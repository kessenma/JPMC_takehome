//
//  ViewController.swift
//  NYC SCHOOLS + SAT SCORES
//  data: https://data.cityofnewyork.us/resource/f9bf-2cp4.json
//  Created by Kyle Essenmacher on 7/24/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var data = [ToDo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Method Calling
        
        fetchingApiData(URL: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") { result in
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    func fetchingApiData(URL url: String, completion: @escaping ([ToDo]) -> Void) {
                             
            let url = URL(string: url)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url!) { data, response, error in
                if data != nil && error == nil {
                do {
                    let parsingData = try JSONDecoder().decode ([ToDo].self, from: data!)
                    completion(parsingData)
                }catch {
                    print ("Parsing error")
                }
                
            }
        }
            dataTask.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = data[indexPath.row].school_name
        return cell!
    }
    
}
















//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Method Calling
//
//        fetchingApiData(URL: "https://jsonplaceholder.typicode.com/todos") {result in
//            print(result)
//        }
//    }
//
//    func fetchingApiData(URL url:String, completion: @escaping ([ToDo]) -> Void) {
//
//        let url = URL(string: url)
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: url!) { data, response, error in
//            if data != nil && error == nil {
//                do {
//                let parsingData = try JSONDecoder().decode([ToDo].self, from: data!)
//                    completion([parsingData])
//                }catch {
//                    print ("Parsing erorr")
//                }
//
//            }
//        }
//        dataTask.resume()
//    }
//}

