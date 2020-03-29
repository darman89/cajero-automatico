import java.util.ArrayList;
import java.util.List;

import ejemplo.cajero.control.Comando;
public aspect ListadoOperaciones {
ArrayList<String> acciones = new ArrayList<String>();
	
	pointcut metodoMenuConComandos(List<Comando> comandos) : call( void ejemplo.cajero.Cajero.muestraMenuConComandos(List<Comando>))  && args(comandos);
	pointcut metodosComando() : execution(private static Comando ejemplo.cajero.Cajero.retornaComandoSeleccionado(..));
	pointcut metodoMenuPrincipal() : execution(static * main(..));
	
	after(List<Comando> comandos): metodoMenuConComandos(comandos) {
		String opciones = "";
		acciones.add("Mostrando Opciones de Menu:");
		for (int i=0; i < comandos.size(); i++) {
			opciones += (i + ".-" + comandos.get(i).getNombre() + " ");
		}
		acciones.add(opciones);
	}
	
	after(): metodoMenuPrincipal() {
		acciones.add("Cajero Cerrado");
		System.out.println();
		System.out.println("Acciones del Cajero al Cerrar el Día:");
		for (Object obj : acciones) {System.out.println(obj);}	           
	}
	
	after() returning(Comando resultado): metodosComando() {
		if (resultado != null)
			acciones.add("Operación: " + resultado.getNombre());
	  }
}
