//
//  MainScreenView.swift
//  App371
//
//  Created by Вячеслав on 3/4/24.
//

import SwiftUI
import StoreKit

struct MainScreenView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Home")
                    .foregroundColor(.black)
                    .font(.system(size: 29, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                VStack {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Welcome to\nHotelTasker")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Select the desired section and start working")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                    })
                    .padding(.vertical)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                        
                        NavigationLink(destination: {
                            
                            MyScheduleView()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            Image("My Schedule")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                        
                        NavigationLink(destination: {
                            
                            MyTasksView()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            Image("My Tasks")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                        
                        NavigationLink(destination: {
                            
                            GuestBaseView()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            Image("Guest Base")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                        
                        NavigationLink(destination: {
                            
                            CheckingHotelRoomsView()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            Image("Checking Hotel Rooms")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                    })
                    .padding()
                    
                    Button(action: {
                        
                        guard let url = URL(string: DataManager().usagePolicy) else { return }
                        
                        UIApplication.shared.open(url)
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "doc.fill")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .regular))
                            
                            Text("Usage Policy")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                        }
                        .padding()
                    })
                    
                    Button(action: {
                        
                        SKStoreReviewController.requestReview()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 16, weight: .regular))
                            
                            Text("Rate Us")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                        }
                        .padding()
                    })
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

#Preview {
    MainScreenView()
}
