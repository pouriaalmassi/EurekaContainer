//
//  ParentViewController.swift
//  EurekaContainer
//
//  Created by Pouria Almassi on 27/10/17.
//  Copyright © 2017 Pouria Almassi. All rights reserved.
//

import UIKit

final class ParentViewController: UIViewController {
    fileprivate var highViewController: HighViewController?
    fileprivate var lowViewController: LowViewController?

    // Alertnate solution based from https://useyourloaf.com/blog/container-view-controllers/
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let highViewController = childViewControllers.first as? HighViewController else {
            fatalError("Check highViewController in IB.")
        }

        guard let lowViewController = childViewControllers.last as? LowViewController else {
            fatalError("Check lowViewController in IB.")
        }

        self.highViewController = highViewController
        self.lowViewController = lowViewController
    }
}
