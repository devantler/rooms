import SwiftUI
import Intents

struct BookingView: View {
    @State var bookedBy: String = ""
    @State var roomNumber: Int?
    @State var isCancelationOfBooking: Bool = false
    @State var status: String = "Enter your name and room number."
    
    @State var roomsData: RoomsData = RoomsData()
    
    @AppStorage("rooms", store: UserDefaults(
        suiteName: "group.com.niem94.rooms")) var store: Data = Data()
    
    var body: some View {
        
        VStack {
            Form {
                HStack {
                    Spacer()
                    Text("Book Room")
                        .bold()
                    Spacer()
                }
                TextField("Your name", text: $bookedBy)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Room Number", value: $roomNumber, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Toggle(isOn: $isCancelationOfBooking) {
                    Text("Cancelation")
                }.toggleStyle(.automatic)
                
                HStack {
                    Spacer()
                    Text(status)
                        .font(.footnote)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        bookRoom()
                    }) {
                        Text("Book room")
                    }
                    Spacer()
                }
            }
        }
        .onAppear() {
            roomsData.refresh()
        }
    }
    
    private func bookRoom() {
        if (bookedBy == "" || roomNumber == nil) {
            status = "Please enter your name and room number."
        } else if (roomNumber! > 10 || roomNumber! < 0){
            status = "Please enter a room number between 0 and 10."
        } else {
            if roomsData.handleBooking(roomNumber: roomNumber!, bookedBy: bookedBy, isCancelation: isCancelationOfBooking) {
                status = "Booking completed"
                makeDonation(roomNumber: roomNumber! , bookedBy: bookedBy, isCancelationOfBooking: isCancelationOfBooking)
            } else {
                status = "Booking not possible"
            }
        }
    }
    
    func makeDonation(roomNumber: Int, bookedBy: String, isCancelationOfBooking: Bool) {
        let intent = BookRoomIntent()
        
        intent.roomNumber = NSNumber.init(value: roomNumber)
        intent.bookedBy = bookedBy
        intent.isCancelationOfBooking = NSNumber.init(value: isCancelationOfBooking)
        intent.suggestedInvocationPhrase = "Book room with Rooms"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print(
                        "Donation failed: %@" + error.localizedDescription)
                }
            } else {
                print("Successfully donated interaction")
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
