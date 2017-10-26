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
    let options: [Container] = [
        Container(id: 0, name: "Low"),
        Container(id: 1, name: "Middle"),
        Container(id: 2, name: "High"),
        ]
    
    fileprivate var presentedChildViewControllerIndex: Int = 0
    fileprivate let containerContainerView = UIView()
    fileprivate var containedViewControllers = [UIViewController]()
    
    fileprivate func childViewControllerIndex() -> Int {
        guard let selectedValue = form.values()["highLowRow"] as? Container else {
            return presentedChildViewControllerIndex
        }
        return selectedValue.id
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // load all potential options
        containedViewControllers = [
            LowViewController(nibName: nil, bundle: nil),
            MiddleViewController(nibName: nil, bundle: nil),
            HighViewController(nibName: nil, bundle: nil),
        ]
    }
    
    override func viewDidLoad() {
        // Configure layout
        if tableView == nil {
            tableView = UITableView(frame: view.bounds, style: .grouped)
            tableView!.autoresizingMask = UIViewAutoresizing.flexibleWidth.union(.flexibleHeight)
        }
        
        guard let tableView = tableView else { return }
        
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        containerContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerContainerView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        let views: [String : Any] = ["containerContainerView" : containerContainerView, "tableView" : tableView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerContainerView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView(150)][containerContainerView]|", options: [], metrics: nil, views: views))
        
        // Configure child viewcontrollers
        // ripped shamelessly from Matt Neub's Programming-iOS-Book-Examples
        // https://github.com/mattneub/Programming-iOS-Book-Examples
        let vc = containedViewControllers[childViewControllerIndex()]
        let _ = containedViewControllers.map { addChildViewController($0) }
        
        vc.view.frame = containerContainerView.bounds
        containerContainerView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        // Configure form
        configureForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateOnAppear()
    }
    
    fileprivate func configureForm() {
        form
            +++ PushRow<Container>("highLowRow") {
                $0.title = "High or low?"
                $0.options = self.options
                $0.value = self.options[0]
                }
                .onPresent { _, vc in
                    vc.enableDeselection = false
        }
    }
    
    fileprivate func updateOnAppear() {
        guard childViewControllerIndex() != presentedChildViewControllerIndex else { return }
        updatePresentedChildViewController(to: childViewControllerIndex())
        presentedChildViewControllerIndex = childViewControllerIndex()
    }
    
    // ripped shamelessly from Matt Neub's Programming-iOS-Book-Examples
    // https://github.com/mattneub/Programming-iOS-Book-Examples
    fileprivate func updatePresentedChildViewController(to index: Int) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let fromvc = containedViewControllers[presentedChildViewControllerIndex]
        let tovc = containedViewControllers[index]
        
        // update frame
        tovc.view.frame = containerContainerView.bounds
        
        let _ = containedViewControllers.map { $0.removeFromParentViewController()}
        // must have all as children before we can transition between them. "will" called for us.
        let _ = containedViewControllers.map { addChildViewController($0) }
        
        // note: when we call remove, we must call "will" (with nil) beforehand
        fromvc.willMove(toParentViewController: nil)
        
        // then perform the transition
        transition(from: fromvc, to: tovc, duration: 0.4, options: [], animations: nil, completion: { _ in
            // finally, finish up. note: when we call add, we must call "did" afterwards
            tovc.didMove(toParentViewController: self)
            fromvc.removeFromParentViewController() // "did" called for us
            UIApplication.shared.endIgnoringInteractionEvents()
        })
    }
}

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

final class MiddleViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
            +++ LabelRow() {
                $0.title = "Middle"
            }
            
            <<< DateRow() { $0.value = Date(); $0.title = "DateRow" }
            
            <<< CheckRow() {
                $0.title = "CheckRow"
                $0.value = true
            }
            
            <<< CheckRow() {
                $0.title = "CheckRow"
                $0.value = true
        }
    }
}

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
