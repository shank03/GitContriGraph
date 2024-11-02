//
//  ContentView.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

struct ContentView: View {
    
    func loginGithub() {
        errMsg = ""
        colors = []
        
        let token = ghToken
        let userName = ghUserName
        
        if token.isEmpty {
            self.errMsg = "Token is empty !"
            return
        }
        if userName.isEmpty {
            self.errMsg = "Username is empty !"
            return
        }
        
        GithubAPI(token: token, userName: userName).fetchUserContributions(completion: { data in
            DispatchQueue.main.async {
                self.colors = data.data.user.contributionsCollection.contributionCalendar.colors
            }
        }, onErr: { err in
            DispatchQueue.main.async {
                self.errMsg = err
            }
        })
    }
    
    @State private var errMsg: String = ""
    @State private var colors: [String] = []
    @State private var ghToken: String = ""
    @State private var ghUserName: String = ""
    
    var body: some View {
        VStack {
            TextField("Github username", text: $ghUserName).autocorrectionDisabled(true).textFieldStyle(.roundedBorder)
            SecureField("Github token", text: $ghToken).autocorrectionDisabled(true).textFieldStyle(.roundedBorder)
            
            Button(action: {
                loginGithub()
            }, label: {
                Text("Login with Github")
            })
            
            if !colors.isEmpty {
                Text(colors.joined(separator: ","))
            }
            
            if !errMsg.isEmpty {
                Text("Error: \(errMsg)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
