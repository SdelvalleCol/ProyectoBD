-- -----------------------------------------------------
-- CREACION DE LA BASE DE DATOS `mydb`
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `CIUDADES`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`CIUDADES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CIUDADES` (
  `ID_CIUDAD` INT NOT NULL AUTO_INCREMENT,
  `CIUDAD` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_CIUDAD`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `SUCURSALES`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`SUCURSALES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SUCURSALES` (
  `ID_SUCURSAL` INT NOT NULL AUTO_INCREMENT,
  `DIRECCION` VARCHAR(100) NOT NULL,
  `TELEFONO_FIJO` VARCHAR(45) NOT NULL,
  `CELULAR` VARCHAR(45) NOT NULL,
  `CORREO_ELECTRONICO` VARCHAR(100) NOT NULL,
  `CIUDADES_ID_CIUDAD` INT NOT NULL,
  PRIMARY KEY (`ID_SUCURSAL`),
  CONSTRAINT `fk_SUCURSALES_CIUDADES1`
    FOREIGN KEY (`CIUDADES_ID_CIUDAD`)
    REFERENCES `mydb`.`CIUDADES` (`ID_CIUDAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_SUCURSALES_CIUDADES1_idx` ON `mydb`.`SUCURSALES` (`CIUDADES_ID_CIUDAD` ASC) VISIBLE;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `TIPOS_VEHICULO`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`TIPOS_VEHICULO` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TIPOS_VEHICULO` (
  `ID_TIPO` INT NOT NULL AUTO_INCREMENT,
  `TIPO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_TIPO`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `ESTADOS_VEHICULO`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`ESTADOS_VEHICULO` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ESTADOS_VEHICULO` (
  `ID_ESTADO` INT NOT NULL AUTO_INCREMENT,
  `ESTADO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_ESTADO`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `MARCAS_VEHICULO`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`MARCAS_VEHICULO` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MARCAS_VEHICULO` (
  `ID_MARCA` INT NOT NULL AUTO_INCREMENT,
  `MARCA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_MARCA`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `VEHICULOS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`VEHICULOS` (
  `ID_VEHICULO` INT NOT NULL AUTO_INCREMENT,
  `PLACA` VARCHAR(10) NOT NULL,
  `REFERENCIA` VARCHAR(100) NOT NULL,
  `MODELO` VARCHAR(10) NOT NULL,
  `PUERTAS` VARCHAR(10) NOT NULL,
  `COLOR` VARCHAR(45) NOT NULL,
  `CAPACIDAD` INT NOT NULL,
  `SUNROOF` TINYINT(1) NOT NULL,
  `MOTOR` VARCHAR(45) NOT NULL,
  `VALOR_DIA` INT NOT NULL,
  `SUCURSALES_ID_SUCURSAL` INT NOT NULL,
  `TIPOS_ID_TIPO` INT NOT NULL,
  `ESTADOS_VEHICULO_ID_ESTADO` INT NOT NULL,
  `MARCAS_VEHICULO_ID_MARCA` INT NOT NULL,
  PRIMARY KEY (`ID_VEHICULO`),
  CONSTRAINT `fk_VEHICULOS_SUCURSALES`
    FOREIGN KEY (`SUCURSALES_ID_SUCURSAL`)
    REFERENCES `mydb`.`SUCURSALES` (`ID_SUCURSAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VEHICULOS_TIPOS1`
    FOREIGN KEY (`TIPOS_ID_TIPO`)
    REFERENCES `mydb`.`TIPOS_VEHICULO` (`ID_TIPO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VEHICULOS_ESTADOS_VEHICULO1`
    FOREIGN KEY (`ESTADOS_VEHICULO_ID_ESTADO`)
    REFERENCES `mydb`.`ESTADOS_VEHICULO` (`ID_ESTADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VEHICULOS_MARCAS_VEHICULO1`
    FOREIGN KEY (`MARCAS_VEHICULO_ID_MARCA`)
    REFERENCES `mydb`.`MARCAS_VEHICULO` (`ID_MARCA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_VEHICULOS_SUCURSALES_idx` ON `mydb`.`VEHICULOS` (`SUCURSALES_ID_SUCURSAL` ASC) VISIBLE;

CREATE INDEX `fk_VEHICULOS_TIPOS1_idx` ON `mydb`.`VEHICULOS` (`TIPOS_ID_TIPO` ASC) VISIBLE;

CREATE INDEX `fk_VEHICULOS_ESTADOS_VEHICULO1_idx` ON `mydb`.`VEHICULOS` (`ESTADOS_VEHICULO_ID_ESTADO` ASC) VISIBLE;

CREATE INDEX `fk_VEHICULOS_MARCAS_VEHICULO1_idx` ON `mydb`.`VEHICULOS` (`MARCAS_VEHICULO_ID_MARCA` ASC) VISIBLE;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `PERSONAS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`PERSONAS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PERSONAS` (
  `ID_PERSONA` INT NOT NULL AUTO_INCREMENT,
  `CEDULA` VARCHAR(15) NOT NULL,
  `NOMBRES` VARCHAR(100) NOT NULL,
  `APELLIDOS` VARCHAR(100) NOT NULL,
  `DIRECCION` VARCHAR(100) NOT NULL,
  `CELULAR` VARCHAR(45) NOT NULL,
  `CORREO_ELECTRONICO` VARCHAR(100) NOT NULL,
  `CONTRASEÑA` VARCHAR(45) NOT NULL,
  `CIUDADES_ID_CIUDAD` INT NOT NULL,
  PRIMARY KEY (`ID_PERSONA`),
  CONSTRAINT `fk_PERSONAS_CIUDADES1`
    FOREIGN KEY (`CIUDADES_ID_CIUDAD`)
    REFERENCES `mydb`.`CIUDADES` (`ID_CIUDAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_PERSONAS_CIUDADES1_idx` ON `mydb`.`PERSONAS` (`CIUDADES_ID_CIUDAD` ASC) VISIBLE;

CREATE UNIQUE INDEX `CORREO_ELECTRONICO_UNIQUE` ON `mydb`.`PERSONAS` (`CORREO_ELECTRONICO` ASC) VISIBLE;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `EMPLEADOS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`EMPLEADOS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEADOS` (
  `ID_EMPLEADO` INT NOT NULL AUTO_INCREMENT,
  `SUCURSALES_ID_SUCURSAL` INT NOT NULL,
  `PERSONAS_ID_PERSONA` INT NOT NULL,
  PRIMARY KEY (`ID_EMPLEADO`),
  CONSTRAINT `fk_EMPLEADOS_SUCURSALES1`
    FOREIGN KEY (`SUCURSALES_ID_SUCURSAL`)
    REFERENCES `mydb`.`SUCURSALES` (`ID_SUCURSAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADOS_PERSONAS1`
    FOREIGN KEY (`PERSONAS_ID_PERSONA`)
    REFERENCES `mydb`.`PERSONAS` (`ID_PERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_EMPLEADOS_SUCURSALES1_idx` ON `mydb`.`EMPLEADOS` (`SUCURSALES_ID_SUCURSAL` ASC) VISIBLE;

CREATE INDEX `fk_EMPLEADOS_PERSONAS1_idx` ON `mydb`.`EMPLEADOS` (`PERSONAS_ID_PERSONA` ASC) VISIBLE;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `CLIENTES`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`CLIENTES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTES` (
  `ID_CLIENTES` INT NOT NULL AUTO_INCREMENT,
  `PERSONAS_ID_PERSONA` INT NOT NULL,
  PRIMARY KEY (`ID_CLIENTES`),
  CONSTRAINT `fk_CLIENTES_PERSONAS1`
    FOREIGN KEY (`PERSONAS_ID_PERSONA`)
    REFERENCES `mydb`.`PERSONAS` (`ID_PERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_CLIENTES_PERSONAS1_idx` ON `mydb`.`CLIENTES` (`PERSONAS_ID_PERSONA` ASC) VISIBLE;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `ALQUILERES`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`ALQUILERES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ALQUILERES` (
  `ID_ALQUILER` INT NOT NULL AUTO_INCREMENT,
  `ID_SUCURSAL_SALIDA` INT NOT NULL,
  `FECHA_SALIDA` DATE NOT NULL,
  `ID_SUCURSAL_LLEGADA` INT NOT NULL,
  `FECHA_LLEGADA_ESPERADA` DATE NOT NULL,
  `FECHA_LLEGADA` DATE NULL,
  `VALOR_SEMANA` INT NOT NULL,
  `VALOR_DIA` INT NOT NULL,
  `PORCENTAJE_DESCUENTO` DECIMAL(3,2) NOT NULL,
  `VALOR_COTIZADO` INT NOT NULL,
  `VALOR_PAGADO` INT NOT NULL,
  `RESUELTO` TINYINT(1) NOT NULL,
  `EMPLEADOS_ID_EMPLEADO` INT NOT NULL,
  `CLIENTES_ID_CLIENTES` INT NOT NULL,
  PRIMARY KEY (`ID_ALQUILER`),
  CONSTRAINT `fk_ALQUILERES_EMPLEADOS1`
    FOREIGN KEY (`EMPLEADOS_ID_EMPLEADO`)
    REFERENCES `mydb`.`EMPLEADOS` (`ID_EMPLEADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALQUILERES_CLIENTES1`
    FOREIGN KEY (`CLIENTES_ID_CLIENTES`)
    REFERENCES `mydb`.`CLIENTES` (`ID_CLIENTES`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ALQUILERES_EMPLEADOS1_idx` ON `mydb`.`ALQUILERES` (`EMPLEADOS_ID_EMPLEADO` ASC) VISIBLE;

CREATE INDEX `fk_ALQUILERES_CLIENTES1_idx` ON `mydb`.`ALQUILERES` (`CLIENTES_ID_CLIENTES` ASC) VISIBLE;

-- -----------------------------------------------------
-- CREACION DE LA TABLA `ALQUILERES_has_VEHICULOS`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `mydb`.`ALQUILERES_has_VEHICULOS` ;

DROP TABLE IF EXISTS `mydb`.`ALQUILERES_has_VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ALQUILERES_has_VEHICULOS` (
  `ALQUILERES_ID_ALQUILER` INT NOT NULL,
  `VEHICULOS_ID_VEHICULO` INT NOT NULL,
  CONSTRAINT `fk_ALQUILERES_has_VEHICULOS_ALQUILERES1`
    FOREIGN KEY (`ALQUILERES_ID_ALQUILER`)
    REFERENCES `mydb`.`ALQUILERES` (`ID_ALQUILER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALQUILERES_has_VEHICULOS_VEHICULOS1`
    FOREIGN KEY (`VEHICULOS_ID_VEHICULO`)
    REFERENCES `mydb`.`VEHICULOS` (`ID_VEHICULO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ALQUILERES_has_VEHICULOS_VEHICULOS1_idx` ON `mydb`.`ALQUILERES_has_VEHICULOS` (`VEHICULOS_ID_VEHICULO` ASC) VISIBLE;

CREATE INDEX `fk_ALQUILERES_has_VEHICULOS_ALQUILERES1_idx` ON `mydb`.`ALQUILERES_has_VEHICULOS` (`ALQUILERES_ID_ALQUILER` ASC) VISIBLE;

-- -----------------------------------------------------
-- DESARROLLO DE TRIGGERS, PROCEDIMIENTOS Y CURSORES
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS ACTUALIZACION_VEHICULOS_ALQUILER; -- ASOCIAR VEHICULO CON ALQUILER
DELIMITER $$
CREATE TRIGGER ACTUALIZACION_VEHICULOS_ALQUILER AFTER INSERT ON ALQUILERES_has_VEHICULOS FOR EACH ROW -- ACTUALIZA EL ESTADO DEL VEHICULO A ALQUILADO Y ADEMAS ACTUALIZA LOS VALORES DEL ALQUILER ASOCIADO QUE SE DEFINEN INICIALMENTE COMO CERO (VALOR_DIA, VALOR_SEMANA, VALOR_COTIZADO)
BEGIN
	SELECT ESTADOS_VEHICULO_ID_ESTADO INTO @ESTADO_VEHICULO_INGRESADO FROM VEHICULOS, ALQUILERES_has_VEHICULOS WHERE ID_VEHICULO = NEW.VEHICULOS_ID_VEHICULO GROUP BY ID_VEHICULO;
	IF @ESTADO_VEHICULO_INGRESADO = 1 THEN
		UPDATE VEHICULOS SET ESTADOS_VEHICULO_ID_ESTADO = 2 WHERE ID_VEHICULO = NEW.VEHICULOS_ID_VEHICULO; -- ACTUALIZO EL ESTADO DEL CARRO
        SELECT VALOR_DIA INTO @VALOR_DIA_VEHICULO FROM VEHICULOS, ALQUILERES_has_VEHICULOS WHERE ID_VEHICULO = NEW.VEHICULOS_ID_VEHICULO GROUP BY ID_VEHICULO; -- VALOR DEL DIA DEL VEHICULO QUE VA A ASOCIAR
        SELECT VALOR_DIA, DATEDIFF(FECHA_LLEGADA_ESPERADA, FECHA_SALIDA), PORCENTAJE_DESCUENTO INTO @VALOR_DIA_ALQUILER, @CANTIDAD_DIAS_ALQUILER, @VALOR_PORCENTAJE
        FROM ALQUILERES, ALQUILERES_has_VEHICULOS WHERE ID_ALQUILER = NEW.ALQUILERES_ID_ALQUILER GROUP BY VALOR_DIA; -- VALOR DEL DIA DEL ALQUILER ANTES DE ASOCIAR EL VEHICULO
        UPDATE ALQUILERES SET VALOR_DIA = @VALOR_DIA_ALQUILER + @VALOR_DIA_VEHICULO, VALOR_SEMANA = (@VALOR_DIA_ALQUILER + @VALOR_DIA_VEHICULO) * 7, VALOR_COTIZADO = ((@VALOR_DIA_ALQUILER + @VALOR_DIA_VEHICULO) * @CANTIDAD_DIAS_ALQUILER) * (1 - @VALOR_PORCENTAJE / 100)
        WHERE ID_ALQUILER = NEW.ALQUILERES_ID_ALQUILER;
    END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS DESCARGUE_VEHICULOS_ALQUILER;
DELIMITER $$
CREATE PROCEDURE DESCARGUE_VEHICULOS_ALQUILER(IN PARAMETRO_ID_ALQUILER INT)
BEGIN
	DECLARE TERMINADO INTEGER DEFAULT 0;
    DECLARE ID_VEHICULO_DESCARGUE INTEGER DEFAULT 0;
    
    DECLARE CURLVEHICULO
		CURSOR FOR
			SELECT VEHICULOS_ID_VEHICULO FROM ALQUILERES_has_VEHICULOS INNER JOIN ALQUILERES ON PARAMETRO_ID_ALQUILER = ALQUILERES_ID_ALQUILER; 
	
    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET TERMINADO = 1;
    
    OPEN CURLVEHICULO;
    
    GET_ID_VEHICULO: LOOP
		FETCH CURLVEHICULO INTO ID_VEHICULO_DESCARGUE;
        IF TERMINADO = 1 THEN
			LEAVE GET_ID_VEHICULO;
		END IF;
        UPDATE VEHICULOS SET ESTADOS_VEHICULO_ID_ESTADO = 1 WHERE ID_VEHICULO = ID_VEHICULO_DESCARGUE;
	END LOOP GET_ID_VEHICULO;
    
    CLOSE CURLVEHICULO;
    
END $$
DELIMITER;

DROP TRIGGER IF EXISTS RESOLUCION_RECARGO_ALQUILER;
DELIMITER $$
CREATE TRIGGER RESOLUCION_RECARGO_ALQUILER BEFORE UPDATE ON ALQUILERES FOR EACH ROW -- ACTUALIZA EL ESTADO DE UN ALQUILER, ES DECIR, SI YA SE RESOLVIO (SI NO TIENE DIAS DE RECARGO Y YA PAGO), ADEMAS APLICA UN RECARGO DEL 8 POR CIENTO EN DADO CASO
BEGIN
	SELECT DATEDIFF(NEW.FECHA_LLEGADA, CURRENT_DATE) INTO @DIAS_RECARGO;
    IF @DIAS_RECARGO <= 0 AND NEW.VALOR_COTIZADO = NEW.VALOR_PAGADO THEN
		SET NEW.RESUELTO = 1;
        CALL DESCARGUE_VEHICULOS_ALQUILER(NEW.ID_ALQUILER);
	ELSEIF @DIAS_RECARGO >= 0 AND OLD.VALOR_COTIZADO <> OLD.VALOR_PAGADO THEN
		SELECT DATEDIFF(NEW.FECHA_LLEGADA, NEW.FECHA_SALIDA) INTO @DIAS_PRESTAMO;
        SET NEW.VALOR_COTIZADO = (NEW.VALOR_DIA * @DIAS_PRESTAMO) + ((NEW.VALOR_DIA * 1.08) * @DIAS_RECARGO);
    END IF;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- DESARROLLO DEL REGISTRO DE CIUDADES, SURCUSALES, TIPOS DE VEHICULOS, ESTADOS DE VEHICULOS, MARCA DE VEHICULOS Y VEHICULOS
-- -----------------------------------------------------

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO CIUDAD)

SET @FIELD_CIUDAD = 'Bucaramanga';
INSERT INTO CIUDADES(CIUDAD)
VALUES(@FIELD_CIUDAD);

SET @FIELD_CIUDAD = 'Piedecuesta';
INSERT INTO CIUDADES(CIUDAD)
VALUES(@FIELD_CIUDAD);
-- SELECT * FROM CIUDADES;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO SUCURSAL)

SET @FIELD_DIRECCION = 'Carrera 35 # 34-02';
SET @FIELD_TELEFONO_FIJO = '6650185';
SET @FIELD_CELULAR = '31045006099';
SET @FIELD_CORREO_ELECTRONICO = 'servicio_cliente_bucaramanga@mashin.com.co';
SET @FIELD_CIUDAD = 1; -- CIUDAD BUCARAMANGA

INSERT INTO SUCURSALES(DIRECCION, TELEFONO_FIJO, CELULAR, CORREO_ELECTRONICO, CIUDADES_ID_CIUDAD)
VALUES(@FIELD_DIRECCION, @FIELD_TELEFONO_FIJO, @FIELD_CELULAR, @FIELD_CORREO_ELECTRONICO, @FIELD_CIUDAD);

SET @FIELD_DIRECCION = 'Calle 49 # 28-50';
SET @FIELD_TELEFONO_FIJO = '6552513';
SET @FIELD_CELULAR = '3140770827';
SET @FIELD_CORREO_ELECTRONICO = 'servicio_cliente_piedecuesta@masshin.com.co';
SET @FIELD_CIUDAD = 2; -- CIUDAD PIEDECUESTA

INSERT INTO SUCURSALES(DIRECCION, TELEFONO_FIJO, CELULAR, CORREO_ELECTRONICO, CIUDADES_ID_CIUDAD)
VALUES(@FIELD_DIRECCION, @FIELD_TELEFONO_FIJO, @FIELD_CELULAR, @FIELD_CORREO_ELECTRONICO, @FIELD_CIUDAD);
-- SELECT * FROM SUCURSALES;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO TIPOS DE VEHICULO)

SET @FIELD_TIPO_VEHICULO = "Deportivo";
INSERT INTO TIPOS_VEHICULO(TIPO)
VALUES(@FIELD_TIPO_VEHICULO);

SET @FIELD_TIPO_VEHICULO = "Sedan";
INSERT INTO TIPOS_VEHICULO(TIPO)
VALUES(@FIELD_TIPO_VEHICULO);

SET @FIELD_TIPO_VEHICULO = "CrossOver";
INSERT INTO TIPOS_VEHICULO(TIPO)
VALUES(@FIELD_TIPO_VEHICULO);
-- SELECT * FROM TIPOS_VEHICULO;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO ESTADOS DE VEHICULO)

SET @FIELD_ESTADO_VEHICULO = "Disponible";
INSERT INTO ESTADOS_VEHICULO(ESTADO)
VALUES(@FIELD_ESTADO_VEHICULO);

SET @FIELD_ESTADO_VEHICULO = "Alquilado";
INSERT INTO ESTADOS_VEHICULO(ESTADO)
VALUES(@FIELD_ESTADO_VEHICULO);
--
SELECT * FROM ESTADOS_VEHICULO;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO MARCAS DE VEHICULO)

SET @FIELD_MARCA_VEHICULO = "Mazda";
INSERT INTO MARCAS_VEHICULO(MARCA)
VALUES(@FIELD_MARCA_VEHICULO);

SET @FIELD_MARCA_VEHICULO = "Chevrolet";
INSERT INTO MARCAS_VEHICULO(MARCA)
VALUES(@FIELD_MARCA_VEHICULO);
-- SELECT * FROM MARCAS_VEHICULO;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO VEHICULO)

SET @FIELD_PLACA = 'PIS-890';
SET @FIELD_REFERENCIA= 'CX-5';
SET @FIELD_MODELO = '2020';
SET @FIELD_PUERTAS = '4';
SET @FIELD_COLOR = 'Rojo';
SET @FIELD_CAPACIDAD = '5';
SET @FIELD_SUNROOF = FALSE;
SET @FIELD_MOTOR = 'Motor a gasolina, 1800 caballos de fuerza';
SET @FIELD_VALOR_DIA = 87638;
SET @FIELD_ID_SUCURSAL = 1;
SET @FIELD_ID_TIPO = 1;
SET @FIELD_ESTADO_VEHICULO = 1;
SET @FIELD_MARCA_VEHICULO = 1;

INSERT INTO VEHICULOS(PLACA, REFERENCIA, MODELO, PUERTAS, COLOR, CAPACIDAD, SUNROOF, MOTOR, VALOR_DIA, SUCURSALES_ID_SUCURSAL, TIPOS_ID_TIPO, ESTADOS_VEHICULO_ID_ESTADO, MARCAS_VEHICULO_ID_MARCA)
VALUES(@FIELD_PLACA, @FIELD_REFERENCIA, @FIELD_MODELO, @FIELD_PUERTAS, @FIELD_COLOR, @FIELD_CAPACIDAD, @FIELD_SUNROOF, @FIELD_MOTOR, @FIELD_VALOR_DIA, @FIELD_ID_SUCURSAL, @FIELD_ID_TIPO, @FIELD_ESTADO_VEHICULO, @FIELD_MARCA_VEHICULO);

SET @FIELD_PLACA = 'IRP-000';
SET @FIELD_REFERENCIA= 'Onix';
SET @FIELD_MODELO = '2018';
SET @FIELD_PUERTAS = '4';
SET @FIELD_COLOR = 'Azul';
SET @FIELD_CAPACIDAD = '5';
SET @FIELD_SUNROOF = FALSE;
SET @FIELD_MOTOR = 'Motor a gasolina, 1800 caballos de fuerza';
SET @FIELD_VALOR_DIA = 57200;
SET @FIELD_ID_SUCURSAL = 2;
SET @FIELD_ID_TIPO = 2;
SET @FIELD_ESTADO_VEHICULO = 1;
SET @FIELD_MARCA_VEHICULO = 2;

INSERT INTO VEHICULOS(PLACA, REFERENCIA, MODELO, PUERTAS, COLOR, CAPACIDAD, SUNROOF, MOTOR, VALOR_DIA, SUCURSALES_ID_SUCURSAL, TIPOS_ID_TIPO, ESTADOS_VEHICULO_ID_ESTADO, MARCAS_VEHICULO_ID_MARCA)
VALUES(@FIELD_PLACA, @FIELD_REFERENCIA, @FIELD_MODELO, @FIELD_PUERTAS, @FIELD_COLOR, @FIELD_CAPACIDAD, @FIELD_SUNROOF, @FIELD_MOTOR, @FIELD_VALOR_DIA, @FIELD_ID_SUCURSAL, @FIELD_ID_TIPO, @FIELD_ESTADO_VEHICULO, @FIELD_MARCA_VEHICULO);
-- SELECT * FROM VEHICULOS;

-- -----------------------------------------------------
-- DESARROLLO DEL REGISTRO DE PERSONAS, EMPLEADOS Y CLIENTES
-- -----------------------------------------------------

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO PERSONAS)

SET @FIELD_CEDULA = '1105784468';
SET @FIELD_NOMBRES = 'Cristian Julian';
SET @FIELD_APELLIDOS = 'Muñoz Buenahora';
SET @FIELD_DIRECCION = 'Calle 5000 # 70-80 Avenida Madrid';
SET @FIELD_CELULAR = '39045686032';
SET @FIELD_CORREO_ELECTRONICO = 'cristian@gmail.com';
SET @FIELD_CONTRASENA = 'estudianteBaseDeDatos2022*/';
SET @FIELD_CIUDAD = 1; -- CIUDAD DE RESIDENCIA

INSERT INTO PERSONAS(CEDULA, NOMBRES, APELLIDOS, DIRECCION, CELULAR, CORREO_ELECTRONICO, CONTRASEÑA, CIUDADES_ID_CIUDAD)
VALUES(@FIELD_CEDULA, @FIELD_NOMBRES, @FIELD_APELLIDOS, @FIELD_DIRECCION, @FIELD_CELULAR,@FIELD_CORREO_ELECTRONICO, @FIELD_CONTRASENA, @FIELD_CIUDAD);

SET @FIELD_CEDULA = '91057400';
SET @FIELD_NOMBRES = 'Jhon Jairo';
SET @FIELD_APELLIDOS = 'Corzo Calderon';
SET @FIELD_DIRECCION = 'Calle 2 # 15-20';
SET @FIELD_CELULAR = '32079680032';
SET @FIELD_CORREO_ELECTRONICO = 'JhonCalderon@gmail.com';
SET @FIELD_CONTRASENA = 'Calderon3060*/';
SET @FIELD_CIUDAD = 2; -- CIUDAD DE RESIDENCIA

INSERT INTO PERSONAS(CEDULA, NOMBRES, APELLIDOS, DIRECCION, CELULAR, CORREO_ELECTRONICO, CONTRASEÑA, CIUDADES_ID_CIUDAD)
VALUES(@FIELD_CEDULA, @FIELD_NOMBRES, @FIELD_APELLIDOS, @FIELD_DIRECCION, @FIELD_CELULAR,@FIELD_CORREO_ELECTRONICO, @FIELD_CONTRASENA, @FIELD_CIUDAD);
-- SELECT * FROM PERSONAS;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO EMPLEADOS)

SET @FIELD_SUCURSAL = 1;
SET @FIELD_PERSONA = 2;

INSERT INTO EMPLEADOS(SUCURSALES_ID_SUCURSAL, PERSONAS_ID_PERSONA)
VALUES(@FIELD_SUCURSAL, @FIELD_PERSONA);
-- SELECT * FROM EMPLEADOS;

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO CLIENTES)

SET @FIELD_PERSONA = 1;

INSERT INTO CLIENTES(PERSONAS_ID_PERSONA)
VALUES(@FIELD_PERSONA);
-- SELECT * FROM EMPLEADOS;

-- -----------------------------------------------------
-- DESARROLLO DEL REGISTRO DEL ALQUILER DE VEHICULOS Y ASOCIACION DE VEHICULOS CON ALQUILER
-- -----------------------------------------------------

-- INFORMACION INGRESADA POR EL USUARIO (REGISTRO ALQUILER)

SET @FIELD_ID_SUCURSAL_SALIDA = 1;
SET @FIELD_FECHA_SALIDA = NOW();
SET @FIELD_ID_SUCURSAL_LLEGADA = 2; -- SE DEFINE INICIALMENTE UNA SEDE PARA LA ENTREGA DEL VEHICULO AL REALIZAR EL ALQUILER PERO ESTA PUEDE SER ACTUALIZADA MAS ADELANTE
SET @FIELD_DIAS_PRESTAMO = 2;
SET @FIELD_FECHA_LLEGADA_ESPERADA = DATE_ADD(CURRENT_DATE, INTERVAL @FIELD_DIAS_PRESTAMO DAY);
SET @FIELD_FECHA_LLEGADA = NULL; -- SE DEFINE COMO NULO INICIALMENTE
SET @FIELD_VALOR_SEMANA = 0; -- SE DEFINE INICIALMENTE COMO 0 DEBIDO A QUE SE CREA EL ALQUILER SIN VEHICULOS ASOCIADOS
SET @FIELD_VALOR_DIA = 0; -- SE DEFINE INICIALMENTE COMO 0 DEBIDO A QUE SE CREA EL ALQUILER SIN VEHICULOS ASOCIADOS
SET @FIELD_PORCENTAJE_DESCUENTO = 0;
SET @FIELD_VALOR_COTIZADO = 0; -- SE DEFINE INICIALMENTE COMO 0 DEBIDO A QUE SE CREA EL ALQUILER SIN VEHICULOS ASOCIADOS
SET @FIELD_VALOR_PAGADO = 0;
SET @FIELD_RESUELTO = FALSE; -- SE DEFINE INICIALMENTE COMO FALSE DEBIDO A QUE SE CREA EL ALQUILER SIN RESOLVERSE, ES DECIR, SIN QUE EL CLIENTE HAYA ENTREGADO Y PAGADO EL ALQUILER
SET @FIELD_ID_EMPLEADO_ENCARGADO = 1;
SET @FIELD_ID_CLIENTE = 1;

INSERT INTO ALQUILERES (ID_SUCURSAL_SALIDA, FECHA_SALIDA, ID_SUCURSAL_LLEGADA, FECHA_LLEGADA_ESPERADA, FECHA_LLEGADA, VALOR_SEMANA, VALOR_DIA, PORCENTAJE_DESCUENTO, VALOR_COTIZADO, VALOR_PAGADO, RESUELTO, EMPLEADOS_ID_EMPLEADO, CLIENTES_ID_CLIENTES)
VALUES (@FIELD_ID_SUCURSAL_SALIDA, @FIELD_FECHA_SALIDA, @FIELD_ID_SUCURSAL_LLEGADA, @FIELD_FECHA_LLEGADA_ESPERADA, @FIELD_FECHA_LLEGADA, @FIELD_VALOR_SEMANA, @FIELD_VALOR_DIA, @FIELD_PORCENTAJE_DESCUENTO, @FIELD_VALOR_COTIZADO, @FIELD_VALOR_PAGADO, @FIELD_RESUELTO, @FIELD_ID_EMPLEADO_ENCARGADO, @FIELD_ID_CLIENTE);

-- SELECT * FROM ALQUILERES;

-- INFORMACION INGRESADA POR EL USUARIO (ASOCIACION DE UN VEHICULO CON UN ALQUILER)

SET @FIELD_ALQUILER = 1;
SET @FIELD_VEHICULO = 1;

INSERT INTO ALQUILERES_has_VEHICULOS (ALQUILERES_ID_ALQUILER, VEHICULOS_ID_VEHICULO)
VALUES (@FIELD_ALQUILER, @FIELD_VEHICULO);

-- SELECT * FROM ALQUILERES_has_VEHICULOS;

-- -----------------------------------------------------
-- DESARROLLO DEL INICIO DE SESION DE EMPLEADOS Y CLIENTES
-- -----------------------------------------------------

-- INICIO DE SESION DE EMPLEADOS

SET @SQLEMPLEADOLOGIN = 'SELECT * FROM PERSONAS, EMPLEADOS WHERE CORREO_ELECTRONICO=? AND CONTRASEÑA=? AND ID_PERSONA = PERSONAS_ID_PERSONA';

-- INFORMACION INGRESADA POR EL EMPLEADO

SET @LOGIN_CORREO_ELECTRONICO = 'JhonCalderon@gmail.com';
SET @LOGIN_PASSWORD = 'Calderon3060*/';

PREPARE LOGIN FROM @SQLEMPLEADOLOGIN;
EXECUTE LOGIN USING @LOGIN_CORREO_ELECTRONICO, @LOGIN_PASSWORD;

-- INICIO DE SESION DE CLIENTES

SET @SQLCLIENTELOGIN = 'SELECT * FROM PERSONAS, CLIENTES WHERE CORREO_ELECTRONICO=? AND CONTRASEÑA=? AND ID_PERSONA = PERSONAS_ID_PERSONA';

-- INFORMACION INGRESADA POR EL CLIENTE

SET @LOGIN_CORREO_ELECTRONICO = 'cristian@gmail.com';
SET @LOGIN_PASSWORD = 'estudianteBaseDeDatos2022*/';

PREPARE LOGIN FROM @SQLCLIENTELOGIN;
EXECUTE LOGIN USING @LOGIN_CORREO_ELECTRONICO, @LOGIN_PASSWORD;

-- -----------------------------------------------------
-- CONSULTA DE DISPONIBILIDAD DE VEHÍCULOS PARA ALQUILER POR TIPO DE VEHÍCULO, RANGO DE PRECIOS DE ALQUILER Y FECHAS DE DISPONIBILIDAD
-- -----------------------------------------------------

-- ALQUILER POR TIPO DE VEHÍCULO

SET @SQL_CONSULTA_VEHICULO_TIPO = 'SELECT * FROM VEHICULOS WHERE ESTADOS_VEHICULO_ID_ESTADO != 2 AND TIPOS_ID_TIPO=?'; -- MUESTRA SOLO VEHICULOS CON ESTADO_ALQUILADO DISTINTO DE 2, ES DECIR, VEHICULOS QUE ESTEN DISPONIBLES PARA SER ALQUILADOS, Y QUE SEAN DEL TIPO DEFINIDO POR EL USUARIO

-- INFORMACION INGRESADA POR EL USUARIO

SET @FIELD_TIPO_VEHICULO_CONSULTA = 2;

PREPARE CONSULTA FROM @SQL_CONSULTA_VEHICULO_TIPO;
EXECUTE CONSULTA USING @FIELD_TIPO_VEHICULO_CONSULTA;

-- RANGO DE PRECIOS DE ALQUILER

SET @SQL_CONSULTA_VEHICULO_PRECIO = 'SELECT * FROM VEHICULOS WHERE ESTADOS_VEHICULO_ID_ESTADO != 2 AND VALOR_DIA>? AND VALOR_DIA<?'; -- MUESTRA SOLO VEHICULOS CON ESTADO_ALQUILADO DISTINTO DE 2, ES DECIR, VEHICULOS QUE ESTEN DISPONIBLES PARA SER ALQUILADOS, Y QUEESTEN EN EL RANGO DE PRECIO DEFINIDO POR EL USUARIO

-- INFORMACION INGRESADA POR EL USUARIO

SET @FIELD_PRECIO_MINIMO_CONSULTA = 53000;
SET @FIELD_PRECIO_MAXIMO_CONSULTA = 200000;

PREPARE CONSULTA FROM @SQL_CONSULTA_VEHICULO_PRECIO;
EXECUTE CONSULTA USING @FIELD_PRECIO_MINIMO_CONSULTA, @FIELD_PRECIO_MAXIMO_CONSULTA;

-- FECHAS DE DISPONIBILIDAD

SET @SQL_CONSULTA_VEHICULO_FECHA = 'SELECT * FROM VEHICULOS WHERE ID_VEHICULO = ANY (SELECT VEHICULOS_ID_VEHICULO FROM ALQUILERES_has_VEHICULOS, ALQUILERES WHERE DATEDIFF(?,ALQUILERES.FECHA_LLEGADA_ESPERADA)>0) OR ESTADOS_VEHICULO_ID_ESTADO = 1;'; -- SELECCIONA LOS VEHICULOS QUE TIENEN UN ESTADO DE 1, ES DECIR, QUE ESTAN DISPONIBLES Y ADEMAS SELECCIONA LOS VEHICULOS QUE PARA ESA FECHA YA ESTARAN DISPONIBLES

SET @FIELD_FECHA_VEHICULO_CONSULTA = DATE_ADD(CURRENT_DATE, INTERVAL 3 DAY); -- LE ESTOY DANDO LA FECHA ACTUAL SUMANDOLE 3 DIAS

PREPARE CONSULTA FROM @SQL_CONSULTA_VEHICULO_FECHA;
EXECUTE CONSULTA USING @FIELD_FECHA_VEHICULO_CONSULTA;

--
SELECT * FROM VEHICULOS;
--
SELECT * FROM ALQUILERES;
--
SELECT * FROM ALQUILERES_has_VEHICULOS;
-- UPDATE ALQUILERES SET VALOR_PAGADO = 175276 WHERE ID_ALQUILER = 1;

-- -----------------------------------------------------
-- CONSULTA HISTORIAL DE ALQUILERES
-- -----------------------------------------------------

SELECT * FROM ALQUILERES WHERE RESUELTO = 1; -- MUESTAR HISTORIAL DE ALQUILERES YA RESUELTOS, CON ARGUMENTO 0 MUESTRA LOS ALQUILERES QUE NO ESTAN RESUELTOS

-- -----------------------------------------------------
-- FUNCIONAMIENTO DEL DESCARGUE DE VEHICULOS
-- -----------------------------------------------------

-- SELECT * FROM ALQUILERES;
-- SELECT * FROM VEHICULOS;
-- UPDATE ALQUILERES SET VALOR_PAGADO = 175276, FECHA_LLEGADA = DATE_ADD(CURRENT_DATE, INTERVAL -2 DAY) WHERE ID_ALQUILER = 1;
-- SELECT * FROM ALQUILERES;
-- SELECT * FROM VEHICULOS;