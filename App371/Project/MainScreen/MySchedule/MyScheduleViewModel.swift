//
//  MyScheduleViewModel.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI
import CoreData

final class MyScheduleViewModel: ObservableObject {
    
    @Published var schedules: [ScheduleModel] = []
    @Published var isAdd: Bool = false
    
    @Published var date: Date = Date()
    @Published var name: String = ""
    @Published var timeline: String = ""
    
    func addSchedule() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ScheduleModel", into: context) as! ScheduleModel

        loan.date = date
        loan.name = name
        loan.timeline = timeline

        CoreDataStack.shared.saveContext()
    }
    
    func fetchSchedule() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ScheduleModel>(entityName: "ScheduleModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.schedules = result
            
        } catch _ as NSError {
            
            self.schedules = []
        }
    }
}
