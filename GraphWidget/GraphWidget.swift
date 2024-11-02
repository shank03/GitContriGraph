//
//  GraphWidget.swift
//  GraphWidget
//
//  Created by Shashank on 02/11/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let data = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), contributions: nil, errMsg: "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping(SimpleEntry) -> ()) {
        let (token, userName) = data.getCredentials()
        
        GithubAPI(token: token, userName: userName).fetchUserContributions(completion: {contributionData in
            let entry = SimpleEntry(date: Date(), contributions: contributionData.mapToData(), errMsg: "")
            completion(entry)
        }, onErr: { err in
            let entry = SimpleEntry(date: Date(), contributions: nil, errMsg: err)
            completion(entry)
        })
    }
    
    func getTimeline(in context: Context, completion: @escaping(Timeline<SimpleEntry>) -> ()) {
        let (token, userName) = data.getCredentials()
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 0, to: currentDate)!
        
        GithubAPI(token: token, userName: userName).fetchUserContributions(completion: {contributionData in
            let entry = SimpleEntry(date: entryDate, contributions: contributionData.mapToData(), errMsg: "")
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }, onErr: { err in
            let entry = SimpleEntry(date: entryDate, contributions: nil, errMsg: err)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        })
    }
    
    //    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let contributions: ContributionData?
    let errMsg: String
}

struct GraphWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack {
            if let contributions = entry.contributions {
                GraphView(contributionData: contributions, isWidget: true)
            }
            
            if !entry.errMsg.isEmpty {
                Text(entry.errMsg).foregroundStyle(.red).fontWeight(.medium)
            }
        }
    }
}

struct GraphWidget: Widget {
    let kind: String = "GraphWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GraphWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemMedium])
    }
}
