//
//  DataService.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

struct DataService {
    @AppStorage("ghToken", store: UserDefaults(suiteName: "TRS835V4P2.com.shank03.GitContriGraph")) private var ghToken: String = ""
    @AppStorage("ghUserName", store: UserDefaults(suiteName: "TRS835V4P2.com.shank03.GitContriGraph")) private var ghUserName: String = ""
    
    func setCredentials(token: String, userName: String) {
        ghToken = token
        ghUserName = userName
    }
    
    func getCredentials() -> (token: String, userName: String) {
        return (ghToken, ghUserName)
    }
}
