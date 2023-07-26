//
//  AddPlantView.swift
//  HortCult
//
//  Created by Joao Guilherme Araujo Canuto on 05/07/23.
//

import SwiftUI

struct AddPlantView: View {
    @Environment(\.plantListViewModel) var plantListViewModel

    @StateObject var vm: AddPlantViewModel
    @AppStorage ("selectedTheme")private var selectedTheme: Choice?
//    var load: () -> Void
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(){
        _vm = StateObject(wrappedValue: AddPlantViewModel(service: CoredataServices())
        
        )
//        self.load = load
    }

    
    var Title: some View {
        HStack{
            Text("Adicionar Vegetal")
                .font(.title)
                .font(Font.custom("Satoshi-Bold", size: 28))
                .fontWeight(.bold)
                .foregroundColor(Color("VerdeEscuro"))
                .padding(.top, 20)
                .padding(.leading, 20)
        }
    }
    
    var NavBar : some View {
        ZStack {
            HeaderLogo()
                .frame(minWidth: 400, minHeight: 200)
                .padding(.top,-40)
            HStack {
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                } ) {
                    Image(selectedTheme == .Escuro ? "Arrow-Left-Light" : "Arrow-Left-Green")
                }
                .padding(.leading, 18)
            }
            .padding(.leading,-190)
        }
    }

    var body: some View {

        NavigationView {
            ZStack{
                ScrollView(.vertical){

                    ZStack{
                        VStack(alignment: .leading, spacing: 10){
                            Title
                            NameInput(namePlant: $vm.plantName)
                            DescriptionInput(descriptionVegetable: $vm.plantInformation)
                            CategoryPicker(selectedOption: $vm.plantCategory)
                            FrequencyPicker(selectedOption: $vm.plantFrequency)
                            ImagePicker(selectedPhotosData: $vm.plantImage)
                            Spacer(minLength: 80)
                        }
                        
                    }
                    
                }
                Spacer()



                VStack{
                    Spacer()

                    Button(action: {
                        vm.addPlant()
//                        load()
                        plantListViewModel.loadPlants()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("Adicionar Novo Vegetal")
                                .foregroundColor(Color("Branco"))
                                .font(.system(size: 16))
                                .bold()
                        }
                        .foregroundColor(Color("CinzaClaro"))

                        .frame(width: 350, height: 42)
                        .background(Color(vm.isAddButtonAble ? "VerdeEscuro" : "CinzaClaro"))
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(vm.isAddButtonAble  ? "VerdeEscuro" : "CinzaClaro"), lineWidth: 2)
                        )
                    }
                    .disabled(!vm.isAddButtonAble)
                    .frame(alignment: .bottom)
                    .padding(.bottom, 20)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: NavBar)

    }
}

//struct AddPlant_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPlantView(load: {})
//            .environmentObject(AddPlantViewModel(service: CoredataServices()))
//    }
//}
