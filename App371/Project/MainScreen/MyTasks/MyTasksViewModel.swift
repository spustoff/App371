//
//  MyTasksViewModel.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI
import CoreData

final class MyTasksViewModel: ObservableObject {
    
    @Published var notesList: [TaskModel] = []
    @Published var isAdd: Bool = false
    
    @Published var date: Date = Date()
    @Published var name: String = ""
    @Published var timeline: String = ""
    @Published var notes: String = ""
    
    func addTask() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: context) as! TaskModel

        loan.date = date
        loan.name = name
        loan.timeline = timeline
        loan.notes = notes

        CoreDataStack.shared.saveContext()
    }
    
    func fetchTasks() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskModel>(entityName: "TaskModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.notesList = result
            
        } catch _ as NSError {
            
            self.notesList = []
        }
    }
}
