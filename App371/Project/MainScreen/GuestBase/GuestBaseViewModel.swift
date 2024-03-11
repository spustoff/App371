//
//  GuestBaseViewModel.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI
import CoreData

final class GuestBaseViewModel: ObservableObject {
    
    @Published var guestbases: [GuestModel] = []
    @Published var isAdd: Bool = false
    
    @Published var left_hotel: Date = Date()
    @Published var name: String = ""
    @Published var room_number: String = ""
    @Published var evaluation: Int = 0
    @Published var notes: String = ""
    
    func addGuest() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "GuestModel", into: context) as! GuestModel

        loan.left_hotel = left_hotel
        loan.name = name
        loan.room_number = Int16(room_number) ?? 0
        loan.evaluation = Int16(evaluation)
        loan.notes = notes

        CoreDataStack.shared.saveContext()
    }
    
    func fetchGuests() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GuestModel>(entityName: "GuestModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.guestbases = result
            
        } catch _ as NSError {
            
            self.guestbases = []
        }
    }
}
