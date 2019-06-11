import semillas.*
import inta.*

class Parcela {
	
	var property ancho
	var property largo
	var property horasDeSol
	var property tipo
	var plantas = []
	
	constructor (_ancho, _largo, _horasDeSol, _tipo) {
		ancho = _ancho
		largo = _largo
		horasDeSol = _horasDeSol
		tipo = _tipo
	}
	
	method plantas() = plantas
	
	method superficie() = ancho * largo
	
	method maximoPlantas() = 
		if (self.esAncha()) { self.superficie() / 5 }
		else { self.superficie() / 3 + largo }
	
	method esAncha() = ancho > largo
	
	method tieneComplicaciones() = plantas.any { planta => planta.horasDeSolToleradas() < horasDeSol }
	
	method plantar(planta) {
		if (plantas.size() == self.maximoPlantas()) { self.error("Se ha alcanzado el maximo de plantas para esta Parcela.") }
		if (horasDeSol - 2 > planta.horasDeSolToleradas()) { self.error("La Parcela recibe demaciado sol para esta Planta.") }
		plantas.add(planta)
	}
	
	method seAsociaBien(planta) = tipo.parcelaAsociaA(self, planta)
	
	//Estos 2 metodos sirven para la consulta que requiere inta sobre la planta mas autosustentable.
	method cantidadPlantasBienAsociadas() = self.plantasBienAsociadas().size()
	
	method plantasBienAsociadas() = plantas.filter { planta => self.seAsociaBien(planta) }
	
	method porcentajePlantasBienAsociadas() = (self.cantidadPlantasBienAsociadas() / plantas.size()) * 100
}

object ecologica {
	
	method parcelaAsociaA(parcela, planta) = not parcela.tieneComplicaciones() and planta.esIdeal(parcela)
}

object industrial {
	
	method parcelaAsociaA(parcela, planta) = parcela.plantas().size() <= 2 and planta.esFuerte()
}