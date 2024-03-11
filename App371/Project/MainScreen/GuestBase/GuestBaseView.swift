//
//  GuestBaseView.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI

struct GuestBaseView: View {
    
    @StateObject var viewModel = GuestBaseViewModel()
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Guest Base")
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
                        
                        if !viewModel.guestbases.isEmpty {
                            
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
                
                if viewModel.guestbases.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Welcome to\nGuest Base")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Register and rate your own database of visitors")
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
                            
                            ForEach(viewModel.guestbases, id: \.self) { index in
                            
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 10, content: {
                                        
                                        Text(index.name ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 20, weight: .semibold))
                                        
                                        HStack {
                                            
                                            ForEach(1...5, id: \.self) { indexer in
                                            
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(Int(index.evaluation) >= indexer ? Color("primary") : .gray.opacity(0.2))
                                                    .font(.system(size: 16, weight: .regular))
                                            }
                                        }
                                        
                                        HStack {
                                            
                                            Text("Date")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Text((index.left_hotel ?? Date()).convertDate(format: "MMM d"))
                                                .foregroundColor(.black)
                                                .font(.system(size: 15, weight: .semibold))
                                            
                                            Text("Room")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                            
                                            Text("\(index.room_number)")
                                                .foregroundColor(.black)
                                                .font(.system(size: 15, weight: .semibold))
                                        }
                                    })
                                    
                                    Spacer()
                                    
                                    Image(systemName: "person.fill")
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
            
            viewModel.fetchGuests()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            GuestBaseAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    GuestBaseView()
}
