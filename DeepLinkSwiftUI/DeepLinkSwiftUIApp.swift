//
//  DeepLinkSwiftUIApp.swift
//  DeepLinkSwiftUI
//
//  Created by JeongminKim on 2023/04/12.
//

import SwiftUI

@main
struct DeepLinkSwiftUIApp: App {
    /// State Object, Contains Whole App Data and Passes it via Environmen Object
    @StateObject private var appData: AppData = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
                // Called when deep link was triggered
                .onOpenURL { url in
                    /*
                     With the onOpenURL function,
                     the entire deep link may be retrieved,
                     and the View can then updated or navigated using the URL Components.
                     */
                    let string = url.absoluteString.replacingOccurrences(of: "deeplinkswiftui://", with: "")
                    // Spliting URL Components
                    let components = string.components(separatedBy: "?")
                    
                    for component in components {
                        if component.contains("tab=") {
                            // Tab change request
                            let tabRawValue = component.replacingOccurrences(of: "tab=", with: "")
                            /*
                             We can retrieve the Tab Raw value by eliminating the "tab=" from the string component,
                             and the with the help of the method we wrote on Tab enum,
                             we can convert the string into appropriate tab case.
                             */
                            if let requestedTab = Tab.convert(from: tabRawValue) {
                                appData.activeTab = requestedTab
                            }
                        }
                        /*
                         Navigation will only be updated
                         if the link contains or specifies
                         which tab navigation needs to be changed.
                         */
                        if component.contains("nav=") && string.contains("tab") {
                            // Nav change request
                            let requestedNavPath = component
                                .replacingOccurrences(of: "nav=", with: "")
                                .replacingOccurrences(of: "_", with: " ") // Why replacing "_" -> Some of the navigation ids contain spaces, but we can't use spaces in deep link urls. Therefore, we're creating _(underscore) to address this problem. This means that if each underscore in the navigation ID represents a space.
                            
                            switch appData.activeTab {
                            case .home:
                                if let navPath = HomeStack.convert(from: requestedNavPath) {
                                    appData.homeNavStack.append(navPath)
                                }
                            case .favourite:
                                if let navPath = FavouriteStack.convert(from: requestedNavPath) {
                                    appData.favouriteNavStack.append(navPath)
                                }
                            case .settings:
                                if let navPath = SettingsStack.convert(from: requestedNavPath) {
                                    appData.settingNavStack.append(navPath)
                                }
                            }
                            /*
                             Based on the given tab, we're finding in which navigation stack
                             the view must be added, which is why we've constrained the navigation update to mention its tab.
                             */
                        }
                    }
                }
        }
    }
}
