//
//  CheckingHotelRoomsAdd.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct CheckingHotelRoomsAdd: View {
    
    @StateObject var viewModel: CheckingHotelRoomsViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New Rooms")
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
                            
                            viewModel.addRoom()
                            viewModel.fetchRooms()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.room_number = ""
                            viewModel.floor = ""
                            viewModel.verification = Date()
                            viewModel.purity = 0
                            viewModel.safety = 0
                            viewModel.notes = ""
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .semibold))
                        })
                        .opacity(viewModel.room_number.isEmpty || viewModel.floor.isEmpty || viewModel.notes.isEmpty || viewModel.purity == 0 || viewModel.safety == 0 ? 0.5 : 1)
                        .disabled(viewModel.room_number.isEmpty || viewModel.floor.isEmpty || viewModel.notes.isEmpty || viewModel.purity == 0 || viewModel.safety == 0 ? true : false)
                    }
                }
                .padding()
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 20, content: {
                        
                        HStack {
                            
                            Text("Room Number")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.room_number.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.room_number)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                        
                        HStack {
                            
                            Text("Floor")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.floor.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.floor)
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                        
                        HStack(content: {
                            
                            Text("Date of verification")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            DatePicker(selection: $viewModel.verification, displayedComponents: .date, label: {})
                                .labelsHidden()
                            
                            Spacer()
                        })
                        
                        HStack(content: {
                            
                            Text("Purity")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            ForEach(1...5, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.purity = index
                                    
                                }, label: {
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.purity >= index ? Color("primary") : .gray.opacity(0.2))
                                        .font(.system(size: 18, weight: .regular))
                                })
                            }
                            
                            Spacer()
                        })
                        
                        HStack(content: {
                            
                            Text("Safety of things")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            ForEach(1...5, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.safety = index
                                    
                                }, label: {
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.safety >= index ? Color("primary") : .gray.opacity(0.2))
                                        .font(.system(size: 18, weight: .regular))
                                })
                            }
                            
                            Spacer()
                        })
                        
                        HStack {
                            
                            Text("Notes")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.notes.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.notes)
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
    CheckingHotelRoomsAdd(viewModel: CheckingHotelRoomsViewModel())
}
