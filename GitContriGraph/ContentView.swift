//
//  ContentView.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    func fetchContributions() {
        loading = true
        errMsg = ""
        contributionData = nil
        
        let token = ghToken
        let userName = ghUserName
        
        if token.isEmpty {
            self.errMsg = "Token is empty !"
            loading = false
            return
        }
        if userName.isEmpty {
            self.errMsg = "Username is empty !"
            loading = false
            return
        }
        
        GithubAPI(token: token, userName: userName).fetchUserContributions(completion: { data in
            DispatchQueue.main.async {
                self.contributionData = data.mapToData()
                loading = false
            }
        }, onErr: { err in
            DispatchQueue.main.async {
                self.errMsg = err
                loading = false
            }
        })
    }
    
    @State private var errMsg: String = ""
    @State private var loading: Bool = false
    @State private var contributionData: ContributionData? = nil
    
    @AppStorage("ghToken", store: UserDefaults(suiteName: "TRS835V4P2.com.shank03.GitContriGraph")) private var ghToken: String = ""
    @AppStorage("ghUserName", store: UserDefaults(suiteName: "TRS835V4P2.com.shank03.GitContriGraph")) private var ghUserName: String = ""
    
    var body: some View {
        VStack {
            TextField("Github username", text: $ghUserName).autocorrectionDisabled(true).textFieldStyle(.roundedBorder)
            SecureField("Github token", text: $ghToken).autocorrectionDisabled(true).textFieldStyle(.roundedBorder)
            
            if loading {
                ProgressView()
            } else {
                Button(action: {
                    fetchContributions()
                    
                    WidgetCenter.shared.reloadTimelines(ofKind: "GraphWidget")
                }, label: {
                    Text("Fetch graph")
                })
            }
            
            if let contributions = contributionData {
                GraphView(contributionData: contributions)
            }
            
            if !errMsg.isEmpty {
                Text("Error: \(errMsg)").foregroundStyle(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
