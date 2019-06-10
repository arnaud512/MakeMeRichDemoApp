//
//  ViewController.swift
//  MakeMeRich
//
//  Created by Arnaud Dupuy on 10/06/2019.
//  Copyright © 2019 Arnaud Dupuy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var addUnitButton: UIButton!

    var items = [
        Item(name: "10", identifier: ""),
        Item(name: "100", identifier: ""),
        Item(name: "1000", identifier: ""),
        Item(name: "10000", identifier: "")
    ]

    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self


        setupUI()
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
            cell.titleLabel.text = "Buy \(items[indexPath.row].name!) item"
            cell.purchaseButton.setTitle("Free", for: .normal)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        count += Int(item.name) ?? 0
        updateUI()
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
