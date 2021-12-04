import SwiftUI
import Intents

@main
struct RoomsApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.onChange(of: scenePhase) { phase in
            INPreferences.requestSiriAuthorization({status in
                // Handle errors here
            })
        }
    }
}
