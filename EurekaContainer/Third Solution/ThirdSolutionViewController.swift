//
//  ThirdSolutionViewController.swift
//  EurekaContainer
//
//  Created by Pouria Almassi on 27/10/17.
//  Copyright © 2017 Pouria Almassi. All rights reserved.
//

import Foundation
import Eureka

final class ThirdSolutionViewController: FormViewController {

    fileprivate let formChooserTag = "formChooserTag"

    fileprivate var selectedOption: Int?
    fileprivate let options = [0, 1]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // re-config form after selection
        guard let selectedValue = form.values()[formChooserTag] as? Int else {
            configureForm(with: -1)
            return
        }
        configureForm(with: selectedValue)
    }

    func emptyForm() -> Form {
        let eForm = Form()
        eForm
            +++ PushRow<Int>(formChooserTag) {
                $0.title = "which form?"
                $0.options = self.options
                if let selectedOption = self.selectedOption {
                    $0.value = selectedOption
                }
                }
                .onPresent { _, vc in
                    vc.enableDeselection = false
        }
        return eForm
    }

    func configureChooser() {
        form = emptyForm()
    }

    func configureForm(with index: Int) {
        defer { tableView.reloadData() }

        switch index {
        case 0:
            selectedOption = index
            configureChooser()
            let _ = XFormModel().configuredForm().allSections.map { form.append($0) }
        case 1:
            selectedOption = index
            configureChooser()
            let _ = YFormModel().configuredForm().allSections.map { form.append($0) }
        default:
            form = emptyForm()
        }
    }

    @IBAction func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
        print(form.values())
    }
}

protocol FormModelRepresentable  {
    var productTypeId: Int { get set }
    var name: String { get set }
    func configuredForm() -> Form
}

struct XFormModel: FormModelRepresentable {
    var productTypeId: Int = 9
    var name: String = "x"

    func configuredForm() -> Form {
        let form = Form()
        form
            +++ LabelRow("a") { $0.title = "x Form" }
            <<< SliderRow("b")
            <<< DateRow("c") { $0.value = Date(); $0.title = "DateRow" }
            <<< CheckRow("d") {
                $0.title = "CheckRow"
                $0.value = true
        }
        return form
    }
}

struct YFormModel: FormModelRepresentable {
    var productTypeId: Int = 8
    var name: String = "y"

    func configuredForm() -> Form {
        let form = Form()
        form
            +++ LabelRow("a") { $0.title = "y Form" }
            <<< DateRow("y c") { $0.value = Date(); $0.title = "DateRow" }
            <<< CheckRow("y d") {
                $0.title = "y CheckRow"
                $0.value = true
        }
        return form
    }
}
