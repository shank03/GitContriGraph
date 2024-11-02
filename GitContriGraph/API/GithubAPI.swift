//
//  GithubAPI.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

struct GithubAPI {
    let token: String
    let userName: String
    
    func fetchUserContributions(completion: @escaping(ContributionsResponse) -> Void, onErr: @escaping(String) -> Void) {
        let query: [String: Any] = [
            "query": "{\n            user(login: \"\(userName)\") {\n              name\n              avatarUrl\n              contributionsCollection(from: \"\(getFromDate())\") {\n                contributionCalendar {\n                  colors\n                  totalContributions\n                  weeks {\n                    contributionDays {\n                      color\n                      contributionCount\n                      date\n                      weekday\n                    }\n                    firstDay\n                  }\n                }\n              }\n            }\n          }"
        ]
        
        guard let url = URL(string: "https://api.github.com/graphql") else {
            onErr("InvalidURL")
            return
        }
        
        var req = URLRequest(url: url)
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        req.httpBody = try? JSONSerialization.data(withJSONObject: query, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: req) { data, res, err in
            guard let data = data, err == nil else {
                if err != nil {
                    onErr("\(err!)")
                } else {
                    onErr("Response data nil")
                }
                return
            }
            
            do {
                completion(try JSONDecoder().decode(ContributionsResponse.self, from: data))
            } catch {
                print("Failed making request: \(error)")
                onErr("\(error)")
            }
        }
        task.resume()
    }
    
    private func getFromDate() -> String {
        let calendar = Calendar.current
        let fromDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
        return fromDate.ISO8601Format()
    }
}
