import parcelas.*
import inta.*

class Planta {
	
	var property anioDeObtencion
	var property altura	
	
	constructor(_anioObtencion, _altura) {
		anioDeObtencion = _anioObtencion
		altura = _altura
	}

	method horasDeSolToleradas()
	method esFuerte() = self.horasDeSolToleradas() > 10
	method daSemillas() = self.esFuerte() or self.condicionSecundaria()
	method condicionSecundaria()
	method espacioOcupado() = 1
	method esIdeal(parcela)
}

class Menta inherits Planta {
	
	override method horasDeSolToleradas() = 6
	
	override method condicionSecundaria() = self.altura() > 0.4
	
	override method espacioOcupado() = altura * 3
	
	override method esIdeal(parcela) = parcela.superficie() > 6
}

class Soja inherits Planta {
	
	override method horasDeSolToleradas() = 
		if (altura < 0.5) { 6 }
		else if (altura.between(0.5, 1)) { 7 }
		else { 9 }
	
	override method condicionSecundaria() = (anioDeObtencion > 2007 and altura > 1)
	
	override method espacioOcupado() = altura / 2
	
	override method esIdeal(parcela) = self.horasDeSolToleradas() == parcela.horasDeSol()
}

class Quinoa inherits Planta {
	
	var property horasDeSolToleradas
	
	override method condicionSecundaria() = anioDeObtencion < 2005
	
	override method espacioOcupado() = 0.5
	
	override method esIdeal(parcela) = parcela.plantas().all { planta => planta.altura() <= 1.5 }
}

class Hierbabuena inherits Menta {
	
	override method espacioOcupado() = altura * 6
}

class SojaTransgenica inherits Soja {
	
	override method daSemillas() = false
	
	override method esIdeal(parcela) = parcela.maximoPlantas() == 1
}