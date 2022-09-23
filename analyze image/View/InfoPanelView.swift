//
//  InfoPanelView.swift
//  analyze image
//  www.silvaneimartins.com.br
//  Created by Silvanei  Martins on 22/09/22.
//  silvaneimartins_rcc@hotmail.com

import SwiftUI

struct InfoPanelView: View {
    // MARK: - Propriedadde
    
    var scale: CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelvisible: Bool = false
    
    // MARK: - Conteudo
    var body: some View {
        HStack {
            // MARK: - PONTO DE ACCESSO
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30,height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPanelvisible.toggle()
                    }
                }
            
            Spacer()
            
            // MARK: - PANEL INFORMAÇÃO
            HStack(spacing:2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
            }//: HSTACK
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420 )
            .opacity(isInfoPanelvisible ? 1 : 0 )
            
            Spacer()
        }//: HSTACK
        .padding()
    }
}

// MARK: - Visualização
struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
    }
}
