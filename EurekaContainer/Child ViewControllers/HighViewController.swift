//
//  HighViewController.swift
//  EurekaContainer
//
//  Created by Pouria Almassi on 27/10/17.
//  Copyright © 2017 Pouria Almassi. All rights reserved.
//

import UIKit
import Eureka

final class HighViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ LabelRow() {
                $0.title = "High"
            }

            <<< DateRow() { $0.value = Date(); $0.title = "DateRow" }

            <<< CheckRow() {
                $0.title = "CheckRow"
                $0.value = true
        }
    }
}
