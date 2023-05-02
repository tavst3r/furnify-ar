//
//  ProfilePage2.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 01.05.2023.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView{
            VStack{
                    Text("Profile")
                        .font(.system(size: 28).bold())
                        .frame(maxWidth: .infinity, alignment:.leading)
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
                
                ScrollView(.vertical, showsIndicators: false){
                    
                        VStack(spacing: 15){
                            
                            Image("ProfileImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .offset(y: -60)
                                .padding(.bottom, -60)
                            
                            Text("Jane Doe")
                                .font(.system(size:20))
                                .fontWeight(.semibold)
                            
                            HStack(alignment: .top, spacing: 10){
                                
                                Image(systemName: "location.north.circle.fill")
                                    .foregroundColor(.gray)
                                    .rotationEffect(.init(degrees: 180))
                                
                                Text("Address: 43 Oxford Road\nM13 4GR\nManchester, UK")
                                    .font(.system(size:15))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding([.horizontal,.bottom,.top])
                        .background(
                            Color.white
                                .cornerRadius(12)
                        )
                        .padding()
                        .padding(.top, 40)
                        
                        //Custom navigation links...
                        CustomNavigationLink(title: "Edit Profile"){
                            
                            Text("")
                                .navigationTitle("Edit Profile")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                                        .ignoresSafeArea())
                        }
                        
                        CustomNavigationLink(title: "Notifications"){
                            
                            Text("")
                                .navigationTitle("Notifications")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                                        .ignoresSafeArea())
                        }
                        
                        CustomNavigationLink(title: "Order History"){
                            
                            Text("")
                                .navigationTitle("Order History")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                                        .ignoresSafeArea())
                        }
                        
                        CustomNavigationLink(title: "Cards"){
                            
                            Text("")
                                .navigationTitle("Cards")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                                        .ignoresSafeArea())
                        }
                        
                    Spacer(minLength: 30)
                    
                        HStack{
                            
                            Text("Log out")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 200)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        NavigationLink {
            content()
        } label: {
            HStack{
                
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
