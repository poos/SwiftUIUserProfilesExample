//
//  ContentView.swift
//  UserProfiles
//
//  Created by Cle on 2024/6/28.
//

import SwiftUI
import Combine

  
struct ContentView: View {
    
    // MARK：- cover VM
    @State var avatarColorText: String?
    @State var avatarImage: UIImage?
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    
    @State private var showingImagePicker = false

    // MARK: - cover Network Action
    func signUpAction() {
        print(#line, #function)
        if let avatarImage = avatarImage {
            print(avatarImage)
        }
        print(firstName)
        print(lastName)
        print(phoneNumber)
        print(email)
        if let avatarColorText = avatarColorText {
            print(avatarColorText)
        }
        // request
        
    }
    
    
    // MARK: - cover View
    func avatorView() -> some View {
        HStack(alignment: .center, spacing: 0) {
            let title = "Avatar"
            Text(title)
                .padding(.leading)
            Spacer()
            Button(action: {
                showingImagePicker = !showingImagePicker
            }, label: {
                Image(uiImage: avatarImage ?? .actions)
                    .resizable()
                    .cornerRadius(25)
                    .frame(width: 50, height: 50)
                    .padding(.all)
                    .background() {
                        if avatarColorText == "Light" {
                            Color.gray
                        } else if avatarColorText == "Dark" {
                            Color.black
                        } else if avatarColorText == "Blue" {
                            Color.blue
                        } else {
                            Color.init(white: 0.9)
                        }
                        
                    }
                    .border(Color.black, width: 1)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            })
            .sheet(isPresented: $showingImagePicker, content: {
                ImagePickerController(image: $avatarImage)
            })
        }
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke( Color.init(white: 0, opacity: 78/255),lineWidth: 2))
        .frame(maxWidth: .infinity)
    }
    
    func contentStringView(title: String, bind text: Binding<String>) -> some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .padding(.leading)
            Spacer()
            TextField(LocalizedStringKey("Please input"), text: text)
                .multilineTextAlignment(.trailing)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke( Color.init(white: 0, opacity: 78/255),lineWidth: 2))
        .frame(maxWidth: .infinity)
    }
    
    func contentColorView(title: String) -> some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .padding(.leading)
            Spacer()
            Menu(content: {
                Button {
                    avatarColorText = "Light"
                } label: {
                    Text("Light")
                }
                Button {
                    avatarColorText = "Dark"
                } label: {
                    Text("Dark")
                }
                Button {
                    avatarColorText = "Blue"
                } label: {
                    Text("Blue")
                }
            }) {
                Text(avatarColorText ?? "Please select")
                
            }
            .foregroundColor(.init(white: avatarColorText == nil ? 0.7 : 0.2))
                .multilineTextAlignment(.trailing)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                
        }
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke( Color.init(white: 0, opacity: 78/255),lineWidth: 2))
        .frame(maxWidth: .infinity)
    }
    
    func signUpView(title: String = "Sign Up") -> some View {
        Button(title,action: {
            signUpAction()
        })
            .padding(.leading)
            .frame(minHeight: 50)
            .frame(maxWidth: .infinity)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke( Color.init(white: 0, opacity: 78/255),lineWidth: 2))
    }
    
    func allContentView() -> some View {
        
        VStack(alignment: .leading, spacing: 16) {
            avatorView()
            contentStringView(title: "First Name", bind: $firstName)
            contentStringView(title: "Last Name", bind: $lastName)
            contentStringView(title: "Phone Number", bind: $phoneNumber)
            contentStringView(title: "Email", bind: $email)
            contentColorView(title: "Custom Avator Color")
            signUpView().padding(.top)
            Spacer()
            
        }
        .padding(SwiftUI.EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .frame(minHeight: 136)
        .background {
            Color.white
        }
    }
    
    public var body: some View {
        allContentView()
    }
}

#Preview {
    ContentView(avatarColorText: "Light")
}
