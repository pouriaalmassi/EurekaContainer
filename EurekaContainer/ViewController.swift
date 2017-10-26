//
//  ViewController.swift
//  EurekaContainer
//
//  Created by Pouria Almassi on 26/10/17.
//  Copyright © 2017 Pouria Almassi. All rights reserved.
//

import UIKit
import Eureka

final class ViewController: FormViewController {
    fileprivate enum ContainerType: String, CustomStringConvertible, Equatable {
        case high, low
        var description: String {
            return self.rawValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedValue = form.values()["x"] as? ContainerType {
            print(selectedValue)
        }
    }

    func configureForm() {
        form
            +++ PushRow<ContainerType>("x") {
                $0.title = "High or low?"
                $0.options = [.high, .low]
                }.onPresent { (_, vc) in
                    vc.enableDeselection = false
        }
    }
}
