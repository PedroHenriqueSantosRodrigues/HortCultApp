//
//  AddVegetable.swift
//  HortCult
//
//  Created by João Vitor Alves Holanda on 06/06/23.
//

import SwiftUI

struct AddVegetable: View {
    @AppStorage ("selectedTheme")private var selectedTheme: Choice?
    var plantViewModel: PlantViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var colorButton: String = "CinzaClaro"
    @State private var addVegetableAlert = false
    @State private var discartVegetableAlert = false
    @State private var goToInformationViewAlert = false
    
    @State private var name : String = ""
    @State private var description : String = ""
    @State private var categoria : String = "Selecionar..."
    @State private var frequencia : String = "Selecionar..."
    @State private var isFull: Bool = false
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
    
    var isFieldsFilled: Bool{
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && categoria != "Selecionar..." && frequencia != "Selecionar..."
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                ScrollView(.vertical){
                    
                    ZStack{
                        VStack{
                            AddEditTitle(addEdit: true)
                            NameDescription(nameVegetable: $name, descriptionVegetable: $description)
                           PickerCategoria(selectedOption: $categoria)
                            PickerFrequencia(selectedOption: $frequencia)
                            AddEditPhotos()
                        }
                    }
                }
                .padding(.bottom, 100)
                
                Button(action: {
                    colorButton = "VerdeEscuro"
                    addVegetableAlert = true
                    discartVegetableAlert = true
                    if isFieldsFilled{
                        self.presentationMode.wrappedValue.dismiss()
                        if(frequencia == "Todos os dias"){
                            frequencia = "1"
                        }else if(frequencia == "A cada 2 dias"){
                            frequencia = "2"
                        }else if(frequencia == "A cada 4 dias"){
                            frequencia = "4"
                        }else{
                            frequencia = "7"
                        }
                        plantViewModel.createPlant(name: name, information: description, category: categoria, frequency: frequencia, image: UIImage())
                    }
                    
                }) {
                    HStack {
                        Text("Adicionar Novo Vegetal")
                            .foregroundColor(Color("Branco"))
                            .font(Font.custom("Satoshi-Regular", size: 16))
                            .bold()
                    }
                    .foregroundColor(Color("CinzaClaro"))
                    
                    .frame(width: 350, height: 42)
                    .background(Color(isFieldsFilled ? "VerdeEscuro" : "CinzaClaro"))
                    .cornerRadius(40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color(isFieldsFilled ? "VerdeEscuro" : "CinzaClaro"), lineWidth: 2)
                    )
                }
                .disabled(!isFieldsFilled)
                .frame(alignment: .bottom)
                .padding(.top, 602)
            }
            
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: NavBar)
        
    }
    
}

struct AddVegetable_Previews: PreviewProvider {
    static var previews: some View {
        AddVegetable(plantViewModel: PlantViewModel())
    }
}



