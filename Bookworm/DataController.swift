//
//  DataController.swift
//  Bookworm
//
//  Created by Ray Nahimi on 09/10/2023.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores{ descriptoin, error in if let error = error {
            print("Core Data failer to load: \(error.localizedDescription)")
            }
        }
    }
}
