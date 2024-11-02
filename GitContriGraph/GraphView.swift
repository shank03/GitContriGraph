//
//  GraphView.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

struct GraphView: View {
    
    let contributionData: ContributionData
    
    @Environment(\.colorScheme) private var colorScheme
    private let gridItem: GridItem = GridItem(.fixed(16), spacing: 3)
    
    var body: some View {
        VStack {
            LazyHGrid(rows: [gridItem, gridItem, gridItem, gridItem, gridItem, gridItem, gridItem], spacing: 3) {
                ForEach(contributionData.contributions, id: \.self) { item in
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                            .fill(Color(level: item.contributionLevel, colorScheme: colorScheme))
                            .frame(width: 16, height: 16, alignment: .center)
                    }
                }
            }
            .padding()
        }
        .background(colorScheme == .dark ? .black : .white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
    }
}
