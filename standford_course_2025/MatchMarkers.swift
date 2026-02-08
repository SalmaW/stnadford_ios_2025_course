 struct MatchMarkers: View{
        var body: some View{
            HStack{
                VStack{
                    Circle()
                    Circle().strokeBorder(.primary, lineWidth: 3).aspectRatio(1,contentMode: .fit)
                }
                VStack{
                    Circle()
                    Circle().opacity(0)
                }
            }
        }
    }