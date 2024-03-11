//
//  MyScheduleView.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct MyScheduleView: View {
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel = MyScheduleViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("My Schedule")
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
                        
                        if !viewModel.schedules.isEmpty {
                            
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
                
                HStack {
                    
                    Text(Date().convertDate(format: "MMM d"))
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                    
                    Spacer()
                }
                .padding()
                
                if viewModel.schedules.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Welcome to\nMy schedule")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Create your own work/vacation days")
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
                            
                            ForEach(viewModel.schedules, id: \.self) { index in
                                
                                HStack {
                                    
                                    VStack(alignment: .center, spacing: 5, content: {
                                        
                                        Text((index.date ?? Date()).convertDate(format: "MMM d"))
                                            .foregroundColor(Color("primary"))
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Text((index.date ?? Date()).convertDate(format: "Y"))
                                            .foregroundColor(Color("primary"))
                                            .font(.system(size: 14, weight: .medium))
                                    })
                                    
                                    Rectangle()
                                        .fill(Color("primary"))
                                        .frame(width: 1, height: 67)
                                    
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        
                                        Text(index.name ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .semibold))
                                        
                                        Text(index.timeline ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    Image(systemName: "calendar")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .regular))
                                        .frame(width: 35, height: 35)
                                        .background(Circle().fill(Color("primary").opacity(0.5)))
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            MyScheduleAdd(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchSchedule()
        }
    }
}

#Preview {
    MyScheduleView()
}
