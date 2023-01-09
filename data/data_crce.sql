INSERT INTO crce.adm_enterprise(bussinesname, tradename, ruc, address, cellphone, email, webpage)
VALUES ('DIGITAL CORP PERU SAC', 'DIGITAL CORP', '', 'AYACUCHO - HUAMANGA - A.C.D - JR. ARENAÑES 123', '954395553', 'DIGITALCORP@GMAIL.COM','DIGITALCORP.COM.PE');

INSERT INTO crce.adm_subsidiary(identerprise, name, address)
VALUES (1, 'TIENDA ARENALES', 'JR. ARENALES 123 - ANDRES A.C.D');

INSERT INTO crce.adm_subsidiary(identerprise, name, address)
VALUES (1,'TIENDA ARENALES', 'JR. ARENALES 321 - ANDRES A.C.D');

insert into crce.adm_customer(numberdocument, firstname, lastname, bussinesname, email, direction, state, idtypedocument)
values('48029513','Celia','Yucra Velasquez','','sesyyv@gmail.com','asoc. la victoria mzñ lt13',default,1);
insert into crce.adm_customer(numberdocument, firstname, lastname, bussinesname, email, direction, state, idtypedocument)
values('20603040253','','','Digital Corp Perú S.A.C','ctc.tucno@gmail.com','asoc. la victoria mzñ lt13',default,6);

