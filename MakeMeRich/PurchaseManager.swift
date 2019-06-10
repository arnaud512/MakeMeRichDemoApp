//
//  PurchaseManager.swift
//  MakeMeRich
//
//  Created by Arnaud Dupuy on 10/06/2019.
//  Copyright © 2019 Arnaud Dupuy. All rights reserved.
//

import Foundation
import StoreKit
import SwiftyStoreKit

class PurchaseManager {

    static func getProductsInfo(items: [Item], completion: @escaping (Set<SKProduct>) -> Void) {
        SwiftyStoreKit.retrieveProductsInfo(Set(items.map { $0.identifier })) { results in
            completion(results.retrievedProducts)
        }
    }

    static func purchase(product: SKProduct, completion: @escaping (PurchaseDetails?) -> Void) {
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: false, simulatesAskToBuyInSandbox: false) { result in
            switch result {
            case .success(let purchase):
                completion(purchase)
            case .error(_):
                completion(nil)
            }
        }
    }
}
