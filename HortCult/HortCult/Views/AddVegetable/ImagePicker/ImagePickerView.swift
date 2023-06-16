import SwiftUI

struct ImagePickerView: View {
    @State private var selectedImages: [UIImage] = []
    @State private var emptyPicker = false

    var body: some View {
        HStack {
            if selectedImages.isEmpty {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        Button(action: {
                            emptyPicker = true
                        }) {
                            ZStack {
                                Color("BrancoMinhaHorta")
                                Image("AddCinza")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 120, height: 120)
                            .cornerRadius(10)
                        }
                        .sheet(isPresented: $emptyPicker) {
                            ImagePicker(selectedImages: $selectedImages)
                        }
                        ZStack {
                            Color("Branco")
                        }.overlay(
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                                .foregroundColor(Color("Cinza"))
                        )
                        
                        .frame(width: 120, height: 120)
                        .cornerRadius(10)
                        ZStack {
                            Color("Branco")
                            
                        }.overlay(
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                                .foregroundColor(Color("Cinza"))
                        )
                        
                        .frame(width: 120, height: 120)
                        .cornerRadius(10)
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120 ,height: 120)
                        }
                    }.padding(.all, 10)
                }
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        Button(action: {
                            emptyPicker = false
                        }) {
                            ZStack {
                                Color("BrancoMinhaHorta")
                                Image("Add")
                                    .resizable()
                                    .frame(width: 45, height: 46)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 120, height: 120)
                            .cornerRadius(10)
                        }
                        .sheet(isPresented: Binding<Bool>(
                            get: { selectedImages.isEmpty },
                            set: { _ in })
                        ) {
                            ImagePicker(selectedImages: self.$selectedImages)
                        }
                        
                        ForEach(selectedImages, id: \.self) { image in
                        VStack{
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 120)
                                .clipped()
                        }.frame(width: 120, height: 120)
                            .background(Color("BrancoMinhaHorta"))
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
}


struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}


