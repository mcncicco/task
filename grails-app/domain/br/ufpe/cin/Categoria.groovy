package br.ufpe.cin

class Categoria {
    String nome

    static constraints = {
        nome(unique: true, size: 5..15)
    }
}
