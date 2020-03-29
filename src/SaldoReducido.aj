import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {
	
	Cuenta cuenta;
	
	pointcut metodoCuenta() : call(* ejemplo.cajero.modelo.Banco.buscarCuenta(..));
	pointcut retiroCuenta(long valor) : call(* ejemplo.cajero.modelo.Cuenta.retirar(long)) && args(valor);
	
	after() returning(Cuenta resultado): metodoCuenta() {
		cuenta = resultado;
	}
	
	void around(long valor): retiroCuenta(valor) {
		double monto = cuenta.getSaldo() - valor;
		if(monto >= 200000)
		proceed(valor);
		System.out.println("No se puede llevar a cabo la transacción (saldo reducido). \nEl monto de la cuenta tras el retiro no puede ser inferior a 200000: " + monto);
	}
}
