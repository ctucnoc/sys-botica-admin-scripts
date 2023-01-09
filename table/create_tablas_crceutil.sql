create table crceutil.util_entry_document(
    id serial not null primary key,
    name varchar(60) not null,
    description varchar(120),
    state varchar(1) default 1
);
comment on table crceutil.util_entry_document is 'tabla donde se almacenan todo los documentos de ingreso';
comment on column crceutil.util_entry_document.id is 'pk de la tabla';
comment on column crceutil.util_entry_document.name is 'nombre del documento de ingreso';
comment on column crceutil.util_entry_document.description is 'descripcion del documento';
comment on column crceutil.util_entry_document.state is 'estado del registro 1: activo y o: eliminado';

create table crceutil.util_type_document(
    id serial not null primary key,
    description varchar(30) not null,
    state varchar(1) default 1 not null
);

comment on table crceutil.util_type_document is 'tabla donde se almacenan todo los tipos de documentos de los clientes';
comment on column crceutil.util_type_document.id is 'pk de la tabla';
comment on column crceutil.util_type_document.description is 'descripcion del tipo de documento';
comment on column crceutil.util_type_document.state is 'estado 1: activo, 0:inactivo';


----------------------------
-- UTIL_PROOF_PAYMENT table
----------------------------
create table crceutil.util_proof_payment(
    id serial not null primary key,
    description varchar(60) not null,
    cod varchar(3),
    state varchar(1) default '1'
);
comment on table crceutil.util_proof_payment is 'tabla donde se almacenan todo los tipos de comprobantes de pago';
comment on column crceutil.util_proof_payment.id is 'pk de la tabla';
comment on column crceutil.util_proof_payment.description is 'descripcion del comprobante';
comment on column crceutil.util_proof_payment.cod is 'codigo comprobante sunat';
comment on column crceutil.util_proof_payment.state is 'estado 1: activo y o: inactivo';

----------------------------
-- UTIL_HTML_TEMPLATE table
----------------------------
create table crceutil.util_html_template(
id serial not null primary key,
code varchar(40) not null unique,
content text not null,
state varchar(1) default 1,
datecreated timestamp default now()
);

comment on table crceutil.util_html_template is 'tabla donde se almacenan todo los templates';
comment on column crceutil.util_html_template.id is 'pk de la tabla';
comment on column crceutil.util_html_template.code is 'codigo de identificacion del hmtl';
comment on column crceutil.util_html_template.content is 'contenido del html';
comment on column crceutil.util_html_template.state is 'estado 0: inactivo y 1: activo';
comment on column crceutil.util_html_template.datecreated is 'fecha de creacion del registro';