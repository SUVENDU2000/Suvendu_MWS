//
//  ViewController.swift
//  MaybeLLine
//
//  Created by Suvendu Kumar on 08/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var MyTableView: UITableView!
    
    var data: [MakeupProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        
        MyTableView.rowHeight = 420
        
        MyTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        
    }
    func fetch() {
        fetchData{ result, error in
            guard let result = result else{
                return
            }
            self.data = result
            print(result)
            DispatchQueue.main.async {
                self.MyTableView.reloadData()
            }
            
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.FifthLabel.text = data[indexPath.row].name
        cell.SecondLabel.text = data[indexPath.row].description
        cell.ThirdLabel.text = data[indexPath.row].price
     //   cell.ForthLabel.text = data[indexPath.row].rating
        cell.FifthLabel.text = data[indexPath.row].brand
        cell.UserImage.load(url: URL(string: data[indexPath.row].image_link)!)
        
        
        
        return cell
    }
    
}

extension ViewController {
    func fetchData(completion: @escaping ([MakeupProduct]?, Error?) -> Void) {
        let url = URL(string: "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline")!
        var request = URLRequest(url: url, timeoutInterval: 20)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let products = try decoder.decode([MakeupProduct].self, from: data)
                completion(products, nil)
            } catch {
                completion(nil, error)
            }
            
        }
        task.resume()
    }
}
