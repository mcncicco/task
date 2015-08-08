package br.ufpe.cin

class Task {

    String nome
	String completa
    Date deadline
    
	Categoria categoria

    static constraints = {
        nome(size:6..45)
        categoria(nullable: true)
    }

    static mapping = {
         categoria lazy:false
    }

}
