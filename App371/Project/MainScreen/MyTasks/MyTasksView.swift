//
//  MyTasksView.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct MyTasksView: View {
    
    @StateObject var viewModel = MyTasksViewModel()
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("My Tasks")
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
                        
                        if !viewModel.notesList.isEmpty {
                            
                            Button(action: {
                                
                                viewModel.isAdd = true
                                
                            }, label: {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .semibold))
                            })
                        }
                    }
                }
                .padding()
                
                DatePicker(selection: .constant(Date()), displayedComponents: .date, label: {})
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding([.horizontal, .top])
                
                if viewModel.notesList.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Welcome to\nMy Tasks")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Create your daily tasks and don't miss anything important")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .regular))
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            
                            viewModel.isAdd = true
                            
                        }, label: {
                            
                            Text("Create")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .padding()
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                                .padding(.top)
                        })
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                     
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.notesList, id: \.self) { index in
                            
                                HStack {
                                    
                                    Text(index.name ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 21, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 100)
                                        .padding(.horizontal)
                                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.2)))
                                    
                                    VStack(alignment: .leading, spacing: 10, content: {
                                        
                                        Text("Time")
                                            .foregroundColor(.black)
                                            .font(.system(size: 21, weight: .semibold))
                                            
                                        Text((index.date ?? Date()).convertDate(format: "MMM d HH:mm"))
                                            .foregroundColor(.black.opacity(0.7))
                                            .font(.system(size: 14, weight: .regular))
                                    })
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 100)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary").opacity(0.2)))
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchTasks()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            MyTasksAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    MyTasksView()
}
