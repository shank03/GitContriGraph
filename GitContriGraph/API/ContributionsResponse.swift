//
//  ContributionsResponse.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

enum ContributionLevel: String, Codable {
    case None = "NONE"
    case FirstQuartile = "FIRST_QUARTILE"
    case SecondQuartile = "SECOND_QUARTILE"
    case ThirdQuartile = "THIRD_QUARTILE"
    case FourthQuartile = "FOURTH_QUARTILE"
    
    func toIdx() -> Int {
        switch self {
        case .None: return 0
        case .FirstQuartile: return 1
        case .SecondQuartile: return 2
        case .ThirdQuartile: return 3
        case .FourthQuartile: return 4
        }
    }
}

struct ContributionDay: Codable, Hashable {
    let color: String
    let contributionCount: Int
    let contributionLevel: ContributionLevel
    let date: String
    let weekday: Int
    
    static func == (lhs: ContributionDay, rhs: ContributionDay) -> Bool {
        lhs.date == rhs.date
    }
}

struct Week: Codable {
    let contributionDays: [ContributionDay]
    let firstDay: String
}

struct ContributionsCalendar: Codable {
    let colors: [String]
    let totalContributions: Int
    let weeks: [Week]
}

struct ContributionsCollection: Codable {
    let contributionCalendar: ContributionsCalendar
}

struct User: Codable {
    let name: String
    let avatarUrl: String
    let contributionsCollection: ContributionsCollection
}

struct Data: Codable {
    let user: User
}

struct ContributionsResponse: Codable {
    let data: Data
    
    func mapToData() -> ContributionData {
        var contributions: [ContributionDay] = []
        data.user.contributionsCollection.contributionCalendar.weeks.forEach({ el in
            contributions.append(contentsOf: el.contributionDays)
        })
        
        return ContributionData(name: data.user.name, avatarUrl: data.user.avatarUrl, contributions: contributions, colors: data.user.contributionsCollection.contributionCalendar.colors)
    }
}

struct ContributionData {
    let name: String
    let avatarUrl: String
    let contributions: [ContributionDay]
    let colors: [String]
    
    func getRestrainedContributions() -> [ContributionDay] {
        let rem = contributions.count % 7
        let cols = 17 - (rem == 0 ? 0 : 1)
        
        let restrain = contributions.count - rem - (7 * cols)
        return Array(contributions[restrain...])
    }
}
