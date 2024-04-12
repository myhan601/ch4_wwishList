//
//  ViewController.swift
//  ch4_wishList
//
//  Created by 한철희 on 4/11/24.
//

import UIKit

class ViewController: UIViewController {
    let networkManager = NetworkManager()
    var product: [Product] = []

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func setWishListButtonTapped(_ sender: Any) {
        return print("setWishListButtonTapped")
    }
    
    @IBAction func setAnotherProductTapped(_ sender: Any) {
        updateData()
        return print("setAnotherProductTapped")
    }
    
    @IBAction func showWishListTapped(_ sender: Any) {
        return print("showWishListTapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        networkManager.fetchProduct { [weak self] products in
            DispatchQueue.main.async {
                if let firstProduct = products.first {
                    self?.titleLabel.text = firstProduct.title
                    self?.descriptionLabel.text = firstProduct.description
                    
                    // firstProduct.thumbnail이 이미 URL 타입이라면, 바로 사용합니다.
                    URLSession.shared.dataTask(with: firstProduct.thumbnail) { data, response, error in
                        if let data = data, error == nil {
                            DispatchQueue.main.async { // 메인 스레드에서 UI 업데이트
                                self?.productImageView.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                }
                print(products)
            }
        }
    }


}
