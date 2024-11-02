//
//  ContributionsResponse.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

struct ContributionDay: Codable {
    let color: String
    let contributionCount: Int
    let date: String
    let weekday: Int
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
}
