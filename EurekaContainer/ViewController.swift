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

    // MARK: -

    fileprivate let containerContainerView = UIView()

    var containedViewControllers = [UIViewController]()

    fileprivate enum ContainerType: String, CustomStringConvertible, Equatable {
        case high, low
        var description: String {
            return self.rawValue
        }
    }

    // MARK: -

    fileprivate func childViewControllerIndex() -> Int {
        guard let selectedValue = form.values()["highLowRow"] as? ContainerType else { return 0 }
        return selectedValue == .high ? 1 : 0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        containedViewControllers += [HighViewController(nibName: nil, bundle: nil)]
        containedViewControllers += [LowViewController(nibName: nil, bundle: nil)]
    }

    override func viewDidLoad() {
        // Configure layout
        if tableView == nil {
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView!.autoresizingMask = UIViewAutoresizing.flexibleWidth.union(.flexibleHeight)
        }

        guard let tableView = tableView else { return }

        super.viewDidLoad()

        tableView.translatesAutoresizingMaskIntoConstraints = false

        containerContainerView.translatesAutoresizingMaskIntoConstraints = false
        containerContainerView.backgroundColor = .green
        view.addSubview(containerContainerView)

        let views: [String : Any] = ["containerContainerView" : containerContainerView, "tableView" : tableView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerContainerView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView(200)][containerContainerView]|", options: [], metrics: nil, views: views))

        // Configure child viewcontrollers
        // ripped shamelessly from Matt Neub's Programming-iOS-Book-Examples
        // https://github.com/mattneub/Programming-iOS-Book-Examples
        let vc = containedViewControllers[childViewControllerIndex()]
        addChildViewController(vc)
        vc.view.frame = containerContainerView.bounds
        containerContainerView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)

        // Configure form
        configureForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(childViewControllerIndex())
        doFlip(for: childViewControllerIndex())
    }

    fileprivate func configureForm() {
        form
            +++ PushRow<ContainerType>("highLowRow") {
                $0.title = "High or low?"
                $0.options = [.high, .low]
                }.onPresent { (_, vc) in
                    vc.enableDeselection = false
        }
    }

    // ripped shamelessly from Matt Neub's Programming-iOS-Book-Examples
    // https://github.com/mattneub/Programming-iOS-Book-Examples
    fileprivate func doFlip(for index: Int) {
        var i = index
        UIApplication.shared.beginIgnoringInteractionEvents()
        let fromvc = containedViewControllers[i]
        i = i == 0 ? 1 : 0
        let tovc = containedViewControllers[i]
        tovc.view.frame = containerContainerView.bounds

        // must have both as children before we can transition between them
        addChildViewController(tovc) // "will" called for us

        // note: when we call remove, we must call "will" (with nil) beforehand
        fromvc.willMove(toParentViewController: nil)

        // then perform the transition
        transition(from: fromvc, to: tovc, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            // finally, finish up
            // note: when we call add, we must call "did" afterwards
            tovc.didMove(toParentViewController: self)
            fromvc.removeFromParentViewController() // "did" called for us
            UIApplication.shared.endIgnoringInteractionEvents()
        })
    }
}

final class HighViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        form +++ LabelRow() {
            $0.title = "High"
        }
    }
}

final class LowViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .red
        form +++ LabelRow() {
            $0.title = "Low"
        }
    }
}
