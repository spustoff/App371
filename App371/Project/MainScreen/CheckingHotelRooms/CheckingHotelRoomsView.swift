//
//  CheckingHotelRoomsView.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct CheckingHotelRoomsView: View {
    
    @StateObject var viewModel = CheckingHotelRoomsViewModel()
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Checking Hotel Rooms")
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
                        
                        if !viewModel.rooms.isEmpty {
                            
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
                
                if viewModel.rooms.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Welcome to\nChecking hotel rooms")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Keep an eye on the rooms and leave notes")
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
                            
                            ForEach(viewModel.rooms, id: \.self) { index in
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 10, content: {
                                        
                                        Text("Rooms \(index.room_number) | Floor \(index.floor)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20, weight: .semibold))
                                        
                                        HStack {
                                            
                                            Text("Date of verification")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Text((index.verification ?? Date()).convertDate(format: "MMM d"))
                                                .foregroundColor(.black)
                                                .font(.system(size: 15, weight: .semibold))
                                        }
                                    })
                                    
                                    Spacer()
                                    
                                    Image(systemName: "bed.double.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .regular))
                                        .frame(width: 55, height: 55)
                                        .background(Circle().fill(Color("primary").opacity(0.5)))
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchRooms()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            CheckingHotelRoomsAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    CheckingHotelRoomsView()
}
