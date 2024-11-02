//
//  GraphView.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

struct GraphView: View {
    
    let contributionData: ContributionData
    var isWidget: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    private let gridItem: GridItem = GridItem(.fixed(16), spacing: 3)
    
    var body: some View {
        VStack {
            LazyHGrid(rows: [gridItem, gridItem, gridItem, gridItem, gridItem, gridItem, gridItem], spacing: 3) {
                ForEach(isWidget ? contributionData.getRestrainedContributions() : contributionData.contributions, id: \.self) { item in
                    RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                        .fill(Color(level: item.contributionLevel, colorScheme: colorScheme))
                        .frame(width: 15, height: 15, alignment: .center)
                }
            }
            .padding(.horizontal, 2)
        }
        .containerBackground(.fill.tertiary, for: .widget)
        
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
    }
}
