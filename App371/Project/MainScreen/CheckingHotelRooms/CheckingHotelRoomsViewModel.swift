//
//  CheckingHotelRoomsViewModel.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI
import CoreData

final class CheckingHotelRoomsViewModel: ObservableObject {
    
    @Published var rooms: [RoomModel] = []
    @Published var isAdd: Bool = false
    
    @Published var room_number: String = ""
    @Published var floor: String = ""
    @Published var verification: Date = Date()
    
    @Published var purity: Int = 0
    @Published var safety: Int = 0

    @Published var notes: String = ""
    
    func addRoom() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "RoomModel", into: context) as! RoomModel

        loan.room_number = Int16(room_number) ?? 0
        loan.floor = Int16(floor) ?? 0
        loan.verification = verification
        loan.purity = Int16(purity)
        loan.safety = Int16(safety)

        CoreDataStack.shared.saveContext()
    }
    
    func fetchRooms() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<RoomModel>(entityName: "RoomModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.rooms = result
            
        } catch _ as NSError {
            
            self.rooms = []
        }
    }
}
