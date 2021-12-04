import SwiftUI

struct RoomsView: View {
    
    @State var roomsData: RoomsData = RoomsData()
    
    var body: some View {
        NavigationView {
            List(roomsData.rooms) { room in
                
                RoomsRowView(room: room)
            }
            .navigationTitle("Available Rooms")
        }
        .onAppear() {
            roomsData.refresh()
        }
    }
}

struct RoomsRowView: View {
    
    var room: Room
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink(destination: RoomDetailView(room: room)) {
                    Text("Room \(room.roomNumber.description)")
                }
            }
        }
    }
}
