//
//  MyScheduleAdd.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct MyScheduleAdd: View {
    
    @StateObject var viewModel: MyScheduleViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New Schedule")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .semibold))
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.addSchedule()
                            viewModel.fetchSchedule()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.date = Date()
                            viewModel.name = ""
                            viewModel.timeline = ""
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .semibold))
                        })
                        .opacity(viewModel.name.isEmpty || viewModel.timeline.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.name.isEmpty || viewModel.timeline.isEmpty ? true : false)
                    }
                }
                .padding()
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 20, content: {
                        
                        HStack(content: {
                            
                            Text("Date")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            DatePicker(selection: $viewModel.date, displayedComponents: .date, label: {})
                                .labelsHidden()
                            
                            Spacer()
                        })
                        
                        HStack {
                            
                            Text("Name")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                        
                        HStack {
                            
                            Text("Timeline")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.timeline.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.timeline)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                    })
                    .padding()
                }
            }
        }
    }
}

#Preview {
    MyScheduleAdd(viewModel: MyScheduleViewModel())
}
