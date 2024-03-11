//
//  GuestBaseAdd.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct GuestBaseAdd: View {
    
    @StateObject var viewModel: GuestBaseViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New Guest Base")
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
                            
                            viewModel.addGuest()
                            viewModel.fetchGuests()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.left_hotel = Date()
                            viewModel.name = ""
                            viewModel.evaluation = 0
                            viewModel.room_number = ""
                            viewModel.notes = ""
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .semibold))
                        })
                        .opacity(viewModel.name.isEmpty || viewModel.notes.isEmpty || viewModel.room_number.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.name.isEmpty || viewModel.notes.isEmpty || viewModel.room_number.isEmpty ? true : false)
                    }
                }
                .padding()
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 20, content: {
                        
                        HStack(content: {
                            
                            Text("Left Hotel")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            DatePicker(selection: $viewModel.left_hotel, displayedComponents: .date, label: {})
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
                        
                        HStack(content: {
                            
                            Text("Evaluation")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            ForEach(1...5, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.evaluation = index
                                    
                                }, label: {
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.evaluation >= index ? Color("primary") : .gray.opacity(0.2))
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
    GuestBaseAdd(viewModel: GuestBaseViewModel())
}
