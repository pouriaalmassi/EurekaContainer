//
//  LowViewController.swift
//  EurekaContainer
//
//  Created by Pouria Almassi on 27/10/17.
//  Copyright © 2017 Pouria Almassi. All rights reserved.
//

import UIKit
import Eureka

final class LowViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ LabelRow() {
                $0.title = "Low"
            }

            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }

            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }

            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }

            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }

            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }

            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }

            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }

            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }

            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }


            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }

            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }

            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
            }

            <<< SwitchRow() {
                $0.title = "SwitchRow"
                $0.value = true
            }

            <<< SliderRow() {
                $0.title = "SliderRow"
                $0.value = 5.0
            }

            <<< StepperRow() {
                $0.title = "StepperRow"
                $0.value = 1.0
        }



    }
}
