//
//  AppBrowser.swift
//  AppBrowser
//
//  Created by Nicolás Miari on 2020/02/19.
//  Copyright © 2020 Nicolás Miari. All rights reserved.
//
import UIKit
import StoreKit

/**
 */
public final class AppBrowser: NSObject, SKStoreProductViewControllerDelegate {

    public static let `default` = AppBrowser()

    public weak var delegate: AppBrowserDelegate?

    public func loadStoreViewControllerForProduct(
        id: Int,
        completion: @escaping ((UIViewController) -> Void),
        failure: @escaping ((Error) -> Void)
    ) {

        let parametersDictionary = [SKStoreProductParameterITunesItemIdentifier: id]

        let store = SKStoreProductViewController()
        store.delegate = self

        store.loadProduct(withParameters: parametersDictionary, completionBlock: { (result: Bool, error: Error?) in
            if result {
                completion(store)

            } else {
                failure(error ?? AppBrowserError.unknown)
            }
        })
    }

    public func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        delegate?.viewControllerDidFinish(viewController)
    }
}

// MARK: - Supporting Types

public protocol AppBrowserDelegate: AnyObject {
    func viewControllerDidFinish(_ viewController: UIViewController)
}

public enum AppBrowserError: Error {
    case unknown
}
