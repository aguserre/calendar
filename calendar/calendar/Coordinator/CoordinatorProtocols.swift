//
//  CoordinatorProtocols.swift
//  bootcamp
//
//  Created by Agustin Errecalde on 17/06/2021.
//

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
