//
//  ViewController.swift
//  MakeMeRich
//
//  Created by Arnaud Dupuy on 10/06/2019.
//  Copyright © 2019 Arnaud Dupuy. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var addUnitButton: UIButton!

    var productsLoaded = false

    var items = [
        Item(name: "10", identifier: ""),
        Item(name: "100", identifier: ""),
        Item(name: "1000", identifier: "com.qeezon.inapp.mmr1000"),
        Item(name: "10000", identifier: "")
    ]

    var products: Set<SKProduct> = []

    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self


        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        PurchaseManager.getProductsInfo(items: items) { products in
            self.products = products
            self.productsLoaded = true
            self.tableView.reloadData()
        }
    }

    func setupUI() {
        title = "MakeMeRich"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        amountLabel.text = "\(count)"
        addUnitButton.layer.cornerRadius = 10
        addUnitButton.layer.masksToBounds = true
    }

    func updateUI() {
        self.amountLabel.text = "\(count)"
    }

    @IBAction func addUnitButtonTapped(_ sender: Any) {
        count += 1
        updateUI()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as? PurchaseTableViewCell {
            let item = items[indexPath.row]
            cell.titleLabel.text = "Buy \(item.name!) item"
            if let product = products.first(where: { $0.productIdentifier == item.identifier }) {
                cell.purchaseButton.setTitle(product.localizedPrice, for: .normal)
            } else {
                if productsLoaded {
                    cell.purchaseButton.setTitle("Error", for: .normal)
                } else {
                    cell.purchaseButton.setTitle("Loading price", for: .normal)
                }
            }

            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if let product = products.first(where: { $0.productIdentifier == item.identifier }) {
            PurchaseManager.purchase(product: product) { purchase in
                guard let purchase = purchase else { return }
                self.count += Int(item.name) ?? 0
                self.updateUI()
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
        }
    }


}
