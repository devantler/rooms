import SwiftUI

struct RoomDetailView: View {
    
    var room: Room
    
    var body: some View {
        Form {
            HStack {
                Text("RoomNumber:")
                    .bold()
                Text(room.roomNumber.description)
            }
            
            HStack {
                Text("Is Booked:")
                    .bold()
                Text(room.isBooked.description)
            }
            
            if(room.isBooked){
                HStack {
                    Text("BookedBy:")
                        .bold()
                    Text(room.bookedBy)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailView(room: Room(roomNumber: 0))
    }
}
