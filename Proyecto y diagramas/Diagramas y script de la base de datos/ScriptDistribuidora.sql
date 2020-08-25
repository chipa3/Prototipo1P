
USE DISTRIBUIDORA;

CREATE TABLE TIPOPRODUCTO
(
idTipoProducto int(4) not null,
Tipo varchar(45),
Descripcion varchar(100),
Estatus tinyint
);
alter table TIPOPRODUCTO add primary key(idTipoProducto);

CREATE TABLE PRODUCTO
(
idProducto int(4) not null,
Descripcion varchar(100),
idTipoProducto int(4),
Cantidad double(5,2),
PrecioUnitario double(5,2),
Estatus tinyint
);

alter table PRODUCTO add primary key(idProducto);
alter table PRODUCTO add constraint fk_tipo foreign key (idTipoProducto) REFERENCES TIPOPRODUCTO(idTipoProducto);

CREATE TABLE PROVEEDOR
(
idProveedor int(4) not null,
Nombre  varchar(40),
Apellido varchar(40),
Estatus tinyint
);

alter table PROVEEDOR add primary key(idProveedor);

CREATE TABLE TELEFONOP
(
idTelefonoP int(4) not null,
idProveedor int(4),
telefono int(9),
Estatus tinyint
);

alter table TELEFONOP add primary key(idTelefonoP);
alter table TELEFONOP add constraint fk_telefonoP foreign key (idProveedor) REFERENCES PROVEEDOR(idProveedor);

CREATE TABLE CLIENTE
(
idCliente int(4) not null,
Nombre  varchar(40),
Apellido varchar(40),
Estatus tinyint
);

alter table CLIENTE add primary key(idCliente);

CREATE TABLE TELEFONOC
(
idTelefonoC int(4) not null,
idCliente int(4),
telefono int(9),
Estatus tinyint
);

alter table TELEFONOC add primary key(idTelefonoC);
alter table TELEFONOC add constraint fk_telefonoC foreign key (idCliente) REFERENCES CLIENTE(idCliente);

CREATE TABLE TIPOEMPLEADO
(
idTipoEmpleado int(4) not null,
Tipo  varchar(40),
Descripcion varchar(40),
Estatus tinyint
);

alter table TIPOEMPLEADO add primary key(idTipoEmpleado);

CREATE TABLE EMPLEADO
(
idEmpleado int(4) not null,
Nombre  varchar(40),
Apellido varchar(40),
idTipoEmpleado int(4),
Estatus tinyint
);

alter table EMPLEADO add primary key(idEmpleado);
alter table EMPLEADO add constraint fk_tipoEmpelado foreign key (idTipoEmpleado) REFERENCES TIPOEMPLEADO(idTipoEmpleado);


CREATE TABLE TELEFONOE
(
idTelefonoE int(4) not null,
idEmpleado int(4),
telefono int(9),
Estatus tinyint
);

alter table TELEFONOE add primary key(idTelefonoE);
alter table TELEFONOE add constraint fk_telefonoE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);

CREATE TABLE TIPOCOMISION
(
idTipoComision int(4) not null,
Tipo varchar(40),
Descripcion varchar(40),
Estatus tinyint
);

alter table TIPOCOMISION add primary key(idTipoComision);

CREATE TABLE COMISION
(
idComision int(4) not null,
idEmpleado int(4),
idTipoComision int(4),
Cantidad Double(5,2),
Estatus tinyint
);

alter table COMISION add primary key(idComision);
alter table COMISION add constraint fk_comisionE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);

CREATE TABLE COTIZACIONENCABEZADO
(
idCotizacionEncabezado int(4) not null,
idEmpleado int(4),
idCliente int(4),
Fecha date,
diasVigentes int(3),
total double(5,2),
Estatus tinyint
);

alter table COTIZACIONENCABEZADO add primary key(idCotizacionEncabezado);
alter table COTIZACIONENCABEZADO add constraint fk_cotizacionE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
alter table COTIZACIONENCABEZADO add constraint fk_cotizacionC foreign key (idCliente) REFERENCES CLIENTE(idCliente);

CREATE TABLE COTIZACIONDETALLE
(
idCotizacionEncabezado int(4),
idProducto int(4),
Cantidad int(4),
Estatus tinyint
);

alter table COTIZACIONDETALLE add constraint fk_cotizacionDetalle foreign key (idCotizacionEncabezado) REFERENCES COTIZACIONENCABEZADO(idCotizacionEncabezado);
alter table COTIZACIONDETALLE add constraint fk_cotizacionProducto foreign key (idProducto) REFERENCES PRODUCTO(idProducto);

CREATE TABLE FACTURAENCABEZADO
(
idFacturaEncabezado int(4) not null,
idEmpleado int(4),
idCliente int(4),
Fecha date,
total double(5,2),
Estatus tinyint
);

alter table FACTURAENCABEZADO add primary key(idFacturaEncabezado);
alter table FACTURAENCABEZADO add constraint fk_facturaEncabezadoE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
alter table FACTURAENCABEZADO add constraint fk_facturaEncabezadoC foreign key (idCliente) REFERENCES CLIENTE(idCliente);

CREATE TABLE FACTURADETALLE
(
idFacturaEncabezado int(4) ,
idProducto int(4),
Cantidad int(4),
Estatus tinyint
);

alter table FACTURADETALLE add constraint fk_facturaEncabezadoDetalleE foreign key (idFacturaEncabezado) REFERENCES FACTURAENCABEZADO(idFacturaEncabezado);
alter table FACTURADETALLE add constraint fk_facturaEncabezadoDetalleC foreign key (idProducto) REFERENCES PRODUCTO(idProducto);

CREATE TABLE FACTURAENCABEZADOCREDITO
(
idFacturaEncabezadoCredito int(4) not null,
idEmpleado int(4),
idCliente int(4),
Fecha date,
Plazo int(3),
total double(5,2),
Estatus tinyint
);

alter table FACTURAENCABEZADOCREDITO add primary key(idFacturaEncabezadoCredito);
alter table FACTURAENCABEZADOCREDITO add constraint fk_facturaEncabezadoCreditoE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
alter table FACTURAENCABEZADOCREDITO add constraint fk_facturaEncabezadoCreditoC foreign key (idCliente) REFERENCES CLIENTE(idCliente);


CREATE TABLE FACTURADETALLECREDITO
(
idFacturaEncabezadoCredito int(4) ,
idProducto int(4),
Cantidad int(4),
Estatus tinyint
);

alter table FACTURADETALLECREDITO add constraint fk_facturaEncabezadoCreditoDetalleE foreign key (idFacturaEncabezadoCredito) REFERENCES FACTURAENCABEZADOCREDITO(idFacturaEncabezadoCredito);
alter table FACTURADETALLECREDITO add constraint fk_facturaEncabezadoCreditoDetalleC foreign key (idProducto) REFERENCES PRODUCTO(idProducto);

CREATE TABLE COMPRASENZABEZADO
(
idComprasEncabezado int(4) not null,
idEmpleado int(4),
idProveedor int(4),
Fecha date,
total double(5,2),
Estatus tinyint
);

alter table COMPRASENZABEZADO add primary key(idComprasEncabezado);
alter table COMPRASENZABEZADO add constraint fk_comprasE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
alter table COMPRASENZABEZADO add constraint fk_comprasC foreign key (idProveedor) REFERENCES PROVEEDOR(idProveedor);

CREATE TABLE COMPRASDETALLE
(
idComprasEncabezado int(4) ,
idProducto int(4),
Cantidad int(4),
Estatus tinyint
);

alter table COMPRASDETALLE add constraint fk_comprasEMP foreign key (idComprasEncabezado) REFERENCES COMPRASENZABEZADO(idComprasEncabezado);
alter table COMPRASDETALLE add constraint fk_comprasP foreign key (idProducto) REFERENCES PRODUCTO(idProducto);

CREATE TABLE COBROS
(
idCobro int(4) not null,
idEmpleado int(4),
idFacturaEncabezadoCredito int(4),
Fecha date,
total double(5,2),
Estatus tinyint
);

alter table COBROS add primary key(idCobro);
alter table COBROS add constraint fk_cobrosE foreign key (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
alter table COBROS add constraint fk_cobrosF foreign key (idFacturaEncabezadoCredito) REFERENCES FACTURAENCABEZADOCREDITO(idFacturaEncabezadoCredito);


INSERT INTO `tipoproducto` (`idTipoProducto`, `Tipo`, `Descripcion`, `Estatus`) VALUES ('1', 'abono', 'abono', '1')
INSERT INTO `tipoproducto` (`idTipoProducto`, `Tipo`, `Descripcion`, `Estatus`) VALUES ('2', 'Juguetes', 'Juguetes para los animales', '1')
INSERT INTO `tipoproducto` (`idTipoProducto`, `Tipo`, `Descripcion`, `Estatus`) VALUES ('3', 'Comida', 'Comida para los animales', '1')

INSERT INTO `producto` (`idProducto`, `Descripcion`, `idTipoProducto`, `Cantidad`, `PrecioUnitario`, `Estatus`) VALUES ('1', 'Abono', '1', '10', '0.5', '1'), ('2', 'Pelota', '2', '10', '5', '1');

INSERT INTO `cliente` (`idCliente`, `Nombre`, `Apellido`, `Estatus`) VALUES ('1', 'Bryan', 'Aguirre', '1'), ('2', 'Carlos', 'Laib', '1');