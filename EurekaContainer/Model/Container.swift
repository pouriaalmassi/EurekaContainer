//
//  Container.swift
//  EurekaContainer
//
//  Created by Pouria Almassi on 26/10/17.
//  Copyright © 2017 Pouria Almassi. All rights reserved.
//

import Foundation

struct Container: CustomStringConvertible, Equatable {
    var id: Int = 0
    var name: String = ""

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    var description: String { return name }

    static func ==(lhs: Container, rhs: Container) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
