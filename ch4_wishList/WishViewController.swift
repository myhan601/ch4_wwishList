//
//  WishViewController.swift
//  ch4_wishList
//
//  Created by 한철희 on 4/16/24.
//

import UIKit
import CoreData

class WishViewController: UIViewController, UITableViewDelegate {
    var wishProducts: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchWishProducts()
        // Do any additional setup after loading the view.
    }
    
}

extension WishViewController: UITableViewDataSource {
    
    func fetchWishProducts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WishProduct")
        
        do {
            wishProducts = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishProductCell", for: indexPath) as? WishProductCell else {
            fatalError("The dequeued cell is not an instance of WishProductCell.")
        }
        
        let product = wishProducts[indexPath.row]
        
        cell.idLabel.text = product.value(forKeyPath: "id") as? String ?? ""
        cell.titleLabel.text = product.value(forKeyPath: "title") as? String ?? ""
        if let price = product.value(forKeyPath: "price") as? Int32 {
            cell.priceLabel.text = "$\(price)"
        } else {
            cell.priceLabel.text = "$0"
        }
        
        return cell
    }
}
