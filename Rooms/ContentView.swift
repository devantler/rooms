import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            BookingView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Book room")
                }

            RoomsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Available rooms")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
