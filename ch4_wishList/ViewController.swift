//
//  ViewController.swift
//  ch4_wishList
//
//  Created by 한철희 on 4/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var product: [Product] = []
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    private var currentProduct: Product? = nil {
        didSet {
            guard let currentProduct = self.currentProduct else { return }
            
            DispatchQueue.main.async {
                self.productImageView.image = nil
                self.titleLabel.text = currentProduct.title
                self.descriptionLabel.text = currentProduct.description
                self.priceLabel.text = "\(currentProduct.price)$"
            }
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: currentProduct.thumbnail), let image = UIImage(data: data) {
                    DispatchQueue.main.async { self?.productImageView.image = image }
                }
            }
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func addWishListBtnTapped(_ sender: Any) {
        self.saveWishProduct()
    }
    
    @IBAction func setAnotherProductTapped(_ sender: Any) {
        self.fetchRemoteProduct()
    }
    
    @IBAction func showWishListTapped(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "WishViewController") as? WishViewController else { return }
        
        self.present(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRemoteProduct()
    }
    
    // 상품을 원격으로부터 가져옵니다.
    private func fetchRemoteProduct() {
        let productID = Int.random(in: 1 ... 100)
        
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let product = try JSONDecoder().decode(Product.self, from: data)
                    self?.currentProduct = product
                } catch {
                    print("Decode Error: \(error)")
                }
            }
            
            task.resume()
        }
    }
    
    // 상품을 Core Data에 저장합니다.
    private func saveWishProduct() {
        guard let context = self.persistentContainer?.viewContext, let currentProduct = self.currentProduct else { return }
        
        let wishProduct = Product(context: context)
        
        wishProduct.id = Int64(currentProduct.id)
        wishProduct.title = currentProduct.title
        wishProduct.description = currentProduct.description
        wishProduct.price = currentProduct.price
        
        do {
            try context.save()
        } catch {
            print("Save Error: \(error)")
        }
    }
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 1000단위로 콤마를 사용하는 숫자 형태로 설정
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
}
