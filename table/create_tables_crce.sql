create table crce.adm_category(
id serial not null primary key,
name varchar(30) not null,
description varchar(60),
state varchar(1) default 1
);

create table crce.adm_mark(
id serial not null primary key,
name varchar(30),
state varchar(1) default 1
);

create table crce.adm_unit(
id serial not null primary key,
initials varchar(8) not null,
description varchar(30),
state varchar(1) default 1
);

create table crce.adm_product(
id serial not null primary key,
name varchar(90) not null,
summaryName varchar(30) not null,
isexpiratedate varchar(1) not null,
isRefrigeration varchar(1) not null,
isBatch varchar(1) not null,
isGeneric varchar(1) not null,
isKit varchar(1) not null,
state varchar(1) not null,
idCategory integer not null,
idMark integer not null,
idUnit integer not null
);

alter table crce.adm_product
add foreign key(idCategory)
references crce.adm_category(id);

alter table crce.adm_product
add foreign key(idMark)
references crce.adm_mark(id);

alter table crce.adm_product
add foreign key(idUnit)
references crce.adm_unit(id);

create table crce.adm_enterprise(
id serial primary key,
bussinesName varchar(60) not null,
tradeName varchar(60) not null,
ruc varchar(11) not null,
address varchar(90) not null,
cellPhone varchar(11),
email varchar(60),
webPage varchar(150),
state varchar(1) default 1
);

create table crce.adm_subsidiary(
id serial not null primary key,
idEnterprise int not null,
name varchar(60) not null,
address varchar(90) not null,
state varchar(1) default 1
);

alter table crce.adm_subsidiary
add foreign key(idEnterprise)
references crce.adm_enterprise(id);


create table crce.adm_provider(
id serial not null primary key,
bussinesname varchar(90) not null,
tradename varchar(90),
ruc varchar(11),
address varchar(90),
cellphone varchar(90),
email varchar(90),
webpage varchar(150),
representative varchar(90),
state varchar(1) default 1
);

COMMENT ON TABLE crce.adm_provider IS 'tabla de proveedor';
COMMENT ON COLUMN crce.adm_provider.id IS 'pk de la tabla';
COMMENT ON COLUMN crce.adm_provider.bussinesname IS 'nombre comercial';
COMMENT ON COLUMN crce.adm_provider.tradename IS 'razon social';
COMMENT ON COLUMN crce.adm_provider.ruc IS 'ruc 11 digitos';
COMMENT ON COLUMN crce.adm_provider.address IS 'direccion';
COMMENT ON COLUMN crce.adm_provider.cellphone IS 'telefonos';
COMMENT ON COLUMN crce.adm_provider.webpage IS 'pagina web';
COMMENT ON COLUMN crce.adm_provider.representative IS 'representante';
COMMENT ON COLUMN crce.adm_provider.state IS 'estado 1: activo y 0: inactivo';


create table crce.adm_wharehouse(
id serial not null primary key,
name varchar(60) not null unique,
description varchar(120),
typewharehouse varchar(1) not null,
state varchar(1) default 1
);
COMMENT ON TABLE crce.adm_wharehouse IS 'tabla de wharehouse';
COMMENT ON COLUMN crce.adm_wharehouse.id IS 'pk de la tabla';
COMMENT ON COLUMN crce.adm_wharehouse.name IS 'nombre el almacen';
COMMENT ON COLUMN crce.adm_wharehouse.description IS 'descripcion del almacen';
COMMENT ON COLUMN crce.adm_wharehouse.typewharehouse IS 'tipo de almacen 1: almacen de destribucion, 0: sub almacen';
COMMENT ON COLUMN crce.adm_wharehouse.state IS 'stado; 1: activo, 0: inactivo';


create table crce.adm_entry_product(
id serial not null primary key,
identryDocument integer not null,
idprovider integer not null,
idwharehouse integer not null,
state varchar(1) default 1,
usercreated varchar(15),
useralter varchar(15),
datecreated timestamp,
datealter timestamp
);
COMMENT ON TABLE crce.adm_entry_product IS 'tabla de entre_product';
COMMENT ON COLUMN crce.adm_entry_product.id IS 'pk de la tabla';
COMMENT ON COLUMN crce.adm_entry_product.identryDocument IS 'fk de la tabla util_entry_document';
COMMENT ON COLUMN crce.adm_entry_product.idprovider IS 'fk de la tabla proveedor';
COMMENT ON COLUMN crce.adm_entry_product.idwharehouse IS 'fk de la tabla wharehouse';
COMMENT ON COLUMN crce.adm_entry_product.state IS 'estado de la tabla 1: activo, 0:inactivo';
COMMENT ON COLUMN crce.adm_entry_product.usercreated IS 'username de creacion';
COMMENT ON COLUMN crce.adm_entry_product.useralter IS 'username de modificacion';
COMMENT ON COLUMN crce.adm_entry_product.datecreated IS 'fecha y hora de creacion';
COMMENT ON COLUMN crce.adm_entry_product.datealter IS 'fecha y hora de modificacion';

alter table crce.adm_entry_product
add foreign key(identryDocument)
references crceutil.util_entry_document(id);

alter table crce.adm_entry_product
add foreign key(idprovider)
references crce.adm_provider(id);

alter table crce.adm_entry_product
add foreign key(idwharehouse)
references crce.adm_wharehouse(id);


create table crce.adm_dt_entry_product(
id serial not null primary key,
idproduct integer not null,
identryproduct integer not null,
purchaseprecio double precision,
amount integer,
expiratedate timestamp,
lotnumber varchar(30),
state varchar(1) default 1,
usercreated varchar(15),
useralter varchar(15),
datecreated timestamp,
datealter timestamp
);
COMMENT ON TABLE crce.adm_dt_entry_product IS 'tabla de dt_entre_product';
COMMENT ON COLUMN crce.adm_dt_entry_product.id IS 'pk de la tabla';
COMMENT ON COLUMN crce.adm_dt_entry_product.idproduct IS 'fk de la tabla producto';
COMMENT ON COLUMN crce.adm_dt_entry_product.identryproduct IS 'fk de la tabla entry product';
COMMENT ON COLUMN crce.adm_dt_entry_product.purchaseprecio IS 'precio de compra';
COMMENT ON COLUMN crce.adm_dt_entry_product.amount IS 'cantidad de ingreso';
COMMENT ON COLUMN crce.adm_dt_entry_product.expiratedate IS 'fecha de vencimiento';
COMMENT ON COLUMN crce.adm_dt_entry_product.lotnumber IS 'numero de lote';
COMMENT ON COLUMN crce.adm_dt_entry_product.state IS 'estado de la tabla 1: activo, 0:inactivo';
COMMENT ON COLUMN crce.adm_dt_entry_product.usercreated IS 'username de creacion';
COMMENT ON COLUMN crce.adm_dt_entry_product.useralter IS 'username de modificacion';
COMMENT ON COLUMN crce.adm_dt_entry_product.datecreated IS 'fecha y hora de creacion';
COMMENT ON COLUMN crce.adm_dt_entry_product.datealter IS 'fecha y hora de modificacion';

alter table crce.adm_dt_entry_product
add foreign key(idproduct)
references crce.adm_product(id);

alter table crce.adm_dt_entry_product
add foreign key(identryproduct)
references crce.adm_entry_product(id);

create table crce.adm_transfer(
    id serial not null primary key,
    idwharehouseorigin int not null,
    idwharehousedestination int not null,
    idsubsidiary int not null,
    usercreated varchar(15),
    useralter varchar(15),
    datecreated timestamp,
    datealter timestamp,
    state varchar(1) default 1
);
COMMENT ON TABLE crce.adm_transfer IS 'tabla de adm_transfer almacena los productos transferidos';
COMMENT ON COLUMN crce.adm_transfer.id IS 'pk de la tabla adm_transfer';
COMMENT ON COLUMN crce.adm_transfer.idwharehouseorigin IS 'id del almacen origin';
COMMENT ON COLUMN crce.adm_transfer.idwharehousedestination IS 'fk del almacen destino';
COMMENT ON COLUMN crce.adm_transfer.idsubsidiary IS 'id de la subsidiria';
COMMENT ON COLUMN crce.adm_transfer.usercreated IS 'usuario de la creacion';
COMMENT ON COLUMN crce.adm_transfer.useralter IS 'usuario que modifico';
COMMENT ON COLUMN crce.adm_transfer.datecreated IS 'fecha de creacion';
COMMENT ON COLUMN crce.adm_transfer.datealter IS 'fecha de modificacion';
COMMENT ON COLUMN crce.adm_transfer.state IS 'estado de la tabla 1: activo y 0: inactivo';

alter table crce.adm_transfer
add foreign key(idwharehousedestination)
references crce.adm_wharehouse(id);

create table crce.adm_dt_transfer(
    id serial not null primary key,
    idtransfer int not null,
    iddtentryproduct int not null,
    amount int not null,
    usercreated varchar(15),
    useralter varchar(15),
    datecreated timestamp,
    datealter timestamp,
    state varchar(1) default 1
);
COMMENT ON TABLE crce.adm_dt_transfer IS 'tabla de adm_dt_transfer';
COMMENT ON COLUMN crce.adm_dt_transfer.id IS 'pk de la tabla adm_dt_transfer';
COMMENT ON COLUMN crce.adm_dt_transfer.idtransfer IS 'fk de la tabla adm_dt_transfer';
COMMENT ON COLUMN crce.adm_dt_transfer.iddtentryproduct IS 'fk del detalle entre product';
COMMENT ON COLUMN crce.adm_dt_transfer.amount IS 'cantidad ingresada';
COMMENT ON COLUMN crce.adm_dt_transfer.usercreated IS 'usuario de la creacion';
COMMENT ON COLUMN crce.adm_dt_transfer.useralter IS 'usuario que modifico';
COMMENT ON COLUMN crce.adm_dt_transfer.datecreated IS 'fecha de creacion';
COMMENT ON COLUMN crce.adm_dt_transfer.datealter IS 'fecha de modificacion';
COMMENT ON COLUMN crce.adm_dt_transfer.state IS 'estado de la tabla 1: activo y 0: inactivo';

alter table crce.adm_dt_transfer
add foreign key(idtransfer)
references crce.adm_transfer(id);

alter table crce.adm_dt_transfer
add foreign key(iddtentryproduct)
references crce.adm_dt_entry_product(id);


create table crce.adm_customer(
    id serial not null primary key,
    numberdocument varchar(15) not null,
    firstname varchar(30),
    lastname varchar(60),
    bussinesname varchar(90),
    email varchar(90),
    direction varchar(150),
    state varchar(1) default 1,
    idtypedocument integer not null
);

comment on table crce.adm_customer is 'tabla donde se almacenan todo los clientes';
comment on column crce.adm_customer.id is 'pk de la tabnumero de documento';
comment on column crce.adm_customer.firstname is 'nombre del cliente';
comment on column crce.adm_customer.lastname is 'apellido completo';
comment on column crce.adm_customer.bussinesname is 'nombre del negocio';
comment on column crce.adm_customer.email is 'email';
comment on column crce.adm_customer.direction is 'direccion';
comment on column crce.adm_customer.state is 'estado 1: activo, 0:inactivo';
comment on column crce.adm_customer.idtypedocument is 'fk de la tabla tipo de cliente';

alter table crce.adm_customer
add foreign key(idtypedocument)
references crceutil.util_type_document(id);

create table crce.adm_sale(
    id serial not null primary key,
    idcustomer integer not null,
    idproofpayment integer not null,
    usercreated varchar(15),
    useralter varchar(15),
    datecreated timestamp,
    datealter timestamp,
    state varchar(1) default '1'
);
comment on table crce.adm_sale is 'tabla donde se almacenan todo las ventas diarias';
comment on column crce.adm_sale.id is 'pk de la tabla';
comment on column crce.adm_sale.idcustomer is 'fk de la tabla cliente';
comment on column crce.adm_sale.idproofpayment is 'fk de la tabla comprobante';
comment on column crce.adm_sale.usercreated is 'usuario de creacion';
comment on column crce.adm_sale.useralter is 'usuario de alteracion';
comment on column crce.adm_sale.datecreated is 'fecha de creacion';
comment on column crce.adm_sale.datealter is 'fecha de alteracion';
comment on column crce.adm_sale.state is 'estado de la venta 1: activo y 0: eliminado';

alter table crce.adm_sale
add foreign key(idcustomer)
references crce.adm_customer(id);

alter table crce.adm_sale
add foreign key(idproofpayment)
references crceutil.util_proof_payment(id);

create table crce.adm_dt_sale(
    id serial not null primary key,
    idsale integer not null,
    iddttransfer integer not null,
    saleamount integer not null,
    saleprice double precision,
    usercreated varchar(15),
    useralter varchar(15),
    datecreated timestamp,
    datealter timestamp,
    state varchar(1) default '1'
);

comment on table crce.adm_dt_sale is 'tabla donde se almacenan el detalle de una venta';
comment on column crce.adm_dt_sale.id is 'pk de la tabla';
comment on column crce.adm_dt_sale.idsale is 'fk de la tabla venta';
comment on column crce.adm_dt_sale.iddttransfer is 'fk de la tabla detalle transferencia';
comment on column crce.adm_dt_sale.saleamount is 'cantidad de venta';
comment on column crce.adm_dt_sale.saleprice is 'precio de venta';
comment on column crce.adm_dt_sale.usercreated is 'usuario de creacion';
comment on column crce.adm_dt_sale.useralter is 'usuario de alteracion';
comment on column crce.adm_dt_sale.datecreated is 'fecha de creacion';
comment on column crce.adm_dt_sale.datealter is 'fecha de alteracion';
comment on column crce.adm_dt_sale.state is 'estado del detalle venta 1: activo y 0: eliminado';

alter table crce.adm_dt_sale
add foreign key(idsale)
references crce.adm_sale(id);

alter table crce.adm_dt_sale
add foreign key(iddttransfer)
references crce.adm_dt_transfer(id);

create table crce.adm_product_img(
id serial not null primary key,
id_api text not null unique,
name varchar(200) not null,
type varchar(30) not null,
url text not null,
state varchar(1) default 1,
idProduct integer not null
);
COMMENT ON TABLE crce.adm_product_img IS 'tabla de las imagenes de los productos';
COMMENT ON COLUMN crce.adm_product_img.id IS 'pk de la tabla';
COMMENT ON COLUMN crce.adm_product_img.id_api IS 'id de la imagen del api';
COMMENT ON COLUMN crce.adm_product_img.name IS 'nombre de la imagen';
COMMENT ON COLUMN crce.adm_product_img.type IS 'tipo de la imagen';
COMMENT ON COLUMN crce.adm_product_img.url IS 'url del api';
COMMENT ON COLUMN crce.adm_product_img.state IS 'estado del registro 0: eliminado y 1: habilitado';
COMMENT ON COLUMN crce.adm_product_img.idProduct IS 'ifk tabla producto';

alter table crce.adm_product_img
add foreign key(idProduct)
references crce.adm_product(id);