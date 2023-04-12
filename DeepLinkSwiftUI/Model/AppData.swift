//
//  AppData.swift
//  DeepLinkSwiftUI
//
//  Created by JeongminKim on 2023/04/12.
//

import SwiftUI

/// App Data Observable Object
class AppData: ObservableObject {
    @Published var activeTab: Tab = .home
    @Published var homeNavStack: [HomeStack] = []
    @Published var favouriteNavStack: [FavouriteStack] = []
    @Published var settingNavStack: [SettingsStack] = []
}
