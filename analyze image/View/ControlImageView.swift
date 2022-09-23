//
//  ControlImageView.swift
//  analyze image
//  www.silvaneimartins.com.br
//  Created by Silvanei  Martins on 22/09/22.
//  silvaneiamrtins_rcc@hotmail.com

import SwiftUI

struct ControlImageView: View {
    // MARK: - Propriedade
    
    let icon: String
    
    // MARK: - Conteudo
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

// MARK: - Visualização
struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
    }
}
