import semillas.*
import parcelas.*

object inta {
	
	var property parcelas = []
	
	method promedioPlantas() = self.sumaPlantasTotal() / self.totalParcelas()
	
	method sumaPlantasTotal() = parcelas.sum { parcela => parcela.plantas().size() }
	
	method totalParcelas() = parcelas.size()
	
	method parcelaMasAutosustentable() = 
		self.parcelasConMasDe4Plantas().max { parcela => parcela.porcentajePlantasBienAsociadas() }
	
	method parcelasConMasDe4Plantas() = parcelas.filter { parcela => parcela.plantas().size() > 4 }
}
