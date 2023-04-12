//
//  HomeStack.swift
//  DeepLinkSwiftUI
//
//  Created by JeongminKim on 2023/04/12.
//

import SwiftUI

/// Home View Nav Link's
enum HomeStack: String, CaseIterable {
    case myPosts = "My Posts"
    case oldPosts = "Old Posts"
    case latestPosts = "Latest Posts"
    case deletedPosts = "Deleted Posts"
    
    static func convert(from: String) -> Self? {
        return self.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
