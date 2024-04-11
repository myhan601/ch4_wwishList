//
//  ViewController.swift
//  ch4_wishList
//
//  Created by 한철희 on 4/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func setWishListButtonTapped(_ sender: Any) {
        return print("setWishListButtonTapped")
    }
    
    @IBAction func setAnotherProductTapped(_ sender: Any) {
        return print("setAnotherProductTapped")
    }
    
    @IBAction func showWishListTapped(_ sender: Any) {
        return print("showWishListTapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

