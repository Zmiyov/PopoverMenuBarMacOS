//
//  MenuView.swift
//  PopoverMenuBarMacOS
//
//  Created by Vladimir Pisarenko on 24.05.2024.
//

import SwiftUI

struct MenuView: View {
    //For slide animation
    @Namespace var animation
    //Current tab
    @State var currentTab = "Uploads"
    
    var body: some View {
        VStack{
            
            HStack{
                TabButton(title: "Help", currentTab: $currentTab, animation: animation)
                TabButton(title: "Uploads", currentTab: $currentTab, animation: animation)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
                .padding(.top, 4)
            
            Image(.box)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(30)
            
            HStack{
                Text("Export your artboards...")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.primary)
                })

            }
            
            Spacer(minLength: 15)
            
            Divider()
                .padding(.bottom, 2)
            
            //Bottom View
            HStack{
                Image(.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                
                Text("iJustie")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Spacer(minLength: 0)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.primary)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        //Max menu size
        .frame(width: 250, height: 300)
    }
}

#Preview {
    MenuView()
}

struct TabButton: View {
    
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation {
                currentTab = title
            }
        }, label: {
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
            //For dark mode adaption
                .foregroundStyle(currentTab == title ? .white : .primary)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background( 
                    ZStack {
                        if currentTab == title {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.blue)
                                .matchedGeometryEffect(id: "Tab",  in: animation)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.primary, lineWidth: 0.6)
                        }
                    }
                )
                .contentShape(RoundedRectangle(cornerRadius: 4))
        })
        .buttonStyle(PlainButtonStyle())
    }
}
