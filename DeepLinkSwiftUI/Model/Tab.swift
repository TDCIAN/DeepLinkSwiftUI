//
//  Tab.swift
//  DeepLinkSwiftUI
//
//  Created by JeongminKim on 2023/04/12.
//

import SwiftUI

/// TabView Tab's
enum Tab: String, CaseIterable {
    case home = "Home"
    case favourite = "Favourites"
    case settings = "Settings"
    
    var symbolImage: String {
        switch self {
        case .home:
            return "house.fill"
        case .favourite:
            return "heart.fill"
        case .settings:
            return "gear"
        }
    }
    
    // Convert String raw value into tab enum case
    static func convert(from: String) -> Self? {
        return Tab.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
