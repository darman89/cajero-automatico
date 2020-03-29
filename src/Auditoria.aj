import java.io.IOException;
import java.util.Date;
import java.util.logging.FileHandler;
import java.util.logging.LogRecord;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import ejemplo.cajero.control.Comando;

public aspect Auditoria {
	FileHandler handler;
	Logger logger;
	
	public Auditoria() {
		super();
		this.setLogger();
	}
	
	pointcut metodosComando() : execution(private static Comando ejemplo.cajero.Cajero.retornaComandoSeleccionado(..));
	pointcut metodoMenuPrincipal() : execution(static * main(..));
	pointcut metodosCajero() : call( * ejemplo.cajero.control..ejecutar(..));
	
	before(): metodoMenuPrincipal() {
		logger.info("Abriendo el Cajero");           
	}
	
	after(): metodoMenuPrincipal() {
		logger.info("Cerrando el Cajero");           
	}
	
	after() returning(Comando resultado): metodosComando() {
		if (resultado != null)
			logger.info("Actividad Realizada: " + resultado.getNombre());
	  }
	
	// ejecución antes de ejecutar el método 
	  before(): metodosCajero() {
		  logger.info("objeto     : " + thisJoinPoint.getTarget());
		  logger.info("método     : " + thisJoinPoint.getSignature());
	  }
	
	
	public void setLogger() {
		try {
			this.handler = new FileHandler("log/default.log");
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		this.handler.setFormatter(new SimpleFormatter() {
            private static final String format = "[%1$tF %1$tT] [%2$-7s] %3$s %n";

            @Override
            public synchronized String format(LogRecord lr) {
                return String.format(format,
                        new Date(lr.getMillis()),
                        lr.getLevel().getLocalizedName(),
                        lr.getMessage()
                );
            }
        });
        
		this.logger = Logger.getLogger("ejemplo.cajero.Cajero");
		this.logger.addHandler(this.handler);
		this.logger.setUseParentHandlers(false);
	}

	 
}
