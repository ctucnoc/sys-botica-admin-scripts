create table crcegu.adm_user(
id serial not null primary key,
username varchar(15) not null unique,
password varchar(200) not null,
fullName varchar(200) not null,
email varchar(90),
state varchar(1) default 1
);

create table crcegu.adm_user_subsidiary(
id serial not null primary key,
idUser int not null,
idSubsidiary int not null,
state varchar(1) default 1
);

alter table crcegu.adm_user_subsidiary
add foreign key(idUser)
references crcegu.adm_user(id);

alter table crcegu.adm_user_subsidiary
add foreign key(idSubsidiary)
references crce.adm_subsidiary(id);

create table crcegu.adm_security_policy(
id serial not null primary key,
minpasswordlength int,
maxpasswordlength int,
maxnumberattempts int,
maxidletime int,
passwordchangefirstlogin varchar(1) default 1
);
COMMENT ON TABLE crcegu.adm_security_policy IS 'tabla de politicas de seguridad';
COMMENT ON COLUMN crcegu.adm_security_policy.id IS 'pk de la tabla';
COMMENT ON COLUMN crcegu.adm_security_policy.minpasswordlength IS 'minimo caracteres password';
COMMENT ON COLUMN crcegu.adm_security_policy.maxpasswordlength IS 'maximo caracteres password';
COMMENT ON COLUMN crcegu.adm_security_policy.maxnumberattempts IS 'nro de intentos';
COMMENT ON COLUMN crcegu.adm_security_policy.maxidletime IS 'nro. maximo de inactividad del sistema';
COMMENT ON COLUMN crcegu.adm_security_policy.passwordchangefirstlogin IS 'cambiar contraseña proximo inicio de session, 1: proximo inicio, 0: no hay cambio en la proxima session';


alter table crcegu.adm_user
add column passwordchangefirstlogin varchar(1);
COMMENT ON COLUMN crcegu.adm_user.passwordchangefirstlogin IS 'cambiar contraseña proximo inicio de session, 1: proximo inicio, 0: no hay cambio en la proxima session';

alter table crcegu.adm_user
add column numberattempts int default 0;
COMMENT ON COLUMN crcegu.adm_user.numberattempts IS 'numero de intentos de acceso al sistema';


alter table crcegu.adm_security_policy
add column codesecuritypolicy varchar(8);


create table crcegu.adm_authority(
id serial not null primary key,
name varchar(15) not null,
description varchar(60),
state varchar(1) default 1
);

COMMENT ON TABLE crcegu.adm_authority IS 'tabla de roles';
COMMENT ON COLUMN crcegu.adm_authority.id IS 'pk de la tabla';
COMMENT ON COLUMN crcegu.adm_authority.name IS 'nombre del rol';
COMMENT ON COLUMN crcegu.adm_authority.description IS 'descripcion del rol creado';
COMMENT ON COLUMN crcegu.adm_authority.state IS 'estado del registro, 1:activo, 0:inactivo';


create table crcegu.adm_user_authority(
id serial not null primary key,
idUser integer not null,
idAuthority integer not null,
state varchar(1) default 1
);

COMMENT ON TABLE crcegu.adm_user_authority IS 'tabla de usuario por roles';
COMMENT ON COLUMN crcegu.adm_user_authority.id IS 'pk de la tabla';
COMMENT ON COLUMN crcegu.adm_user_authority.idUser IS 'fk user';
COMMENT ON COLUMN crcegu.adm_user_authority.idAuthority IS 'fk authority';
COMMENT ON COLUMN crcegu.adm_user_authority.state IS 'estado del registro, 1:activo, 0:inactivo';

alter table crcegu.adm_user_authority
add foreign key(idUser)
references crcegu.adm_user(id);

alter table crcegu.adm_user_authority
add foreign key(idAuthority)
references crcegu.adm_authority(id);


create table crcegu.adm_wharehouse_subsidiary(
id serial not null primary key,
idwharehouse integer not null,
idsubsidiary integer not null,
state varchar(1) default 1
);
COMMENT ON TABLE crcegu.adm_wharehouse_subsidiary IS 'tabla de wharehouse_subsidiary';
COMMENT ON COLUMN crcegu.adm_wharehouse_subsidiary.id IS 'pk de la tabla';
COMMENT ON COLUMN crcegu.adm_wharehouse_subsidiary.idwharehouse IS 'fk tabla wharehouse';
COMMENT ON COLUMN crcegu.adm_wharehouse_subsidiary.idsubsidiary IS 'pk de la tabla';
COMMENT ON COLUMN crcegu.adm_wharehouse_subsidiary.state IS 'fk tabla subsidiary';

alter table crcegu.adm_wharehouse_subsidiary
add foreign key(idwharehouse)
references crce.adm_wharehouse(id);

alter table crcegu.adm_wharehouse_subsidiary
add foreign key(idsubsidiary)
references crce.adm_subsidiary(id);