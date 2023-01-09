insert into crceutil.util_entry_document(name,description,state) values('GUIA DE REMISION','DOCUMENTO PARA TRASTADO DE BIENES',DEFAULT);
insert into crceutil.util_entry_document(name,description,state) values('NOTA DE REMISION','OTRO DOCUMENTO PARA TRASTADO DE BIENES',DEFAULT);
insert into crceutil.util_entry_document(name,description,state) values('SIN DOCUMENTO','INGRESO SIN DOCUMENTO',DEFAULT);


insert into crceutil.util_type_document(id,description, state) values(1,'DOC. NACIONAL DE IDENTIDAD',DEFAULT);
insert into crceutil.util_type_document(id,description, state) values(4,'CARNET DE EXTRANJERIA',DEFAULT);
insert into crceutil.util_type_document(id,description, state) values(6,'REG. UNICO DE CONTRIBUYENTES',DEFAULT);
insert into crceutil.util_type_document(id,description, state) values(7,'PASAPORTE',DEFAULT);

insert into crceutil.util_proof_payment(description, cod, state) values('FACTURA','01',default);
insert into crceutil.util_proof_payment(description, cod, state) values('BOLETA DE VENTA','03',default);
insert into crceutil.util_proof_payment(description, cod, state) values('NOTA DE CREDITO','07',default);
insert into crceutil.util_proof_payment(description, cod, state) values('NOTA DE DEBITO','08',default);
insert into crceutil.util_proof_payment(description, cod, state) values('TICKET DE MAQUINA REGISTRADORA','12',default);

insert into crce.adm_customer(id, numberdocument, firstname, lastname, bussinesname, email, direction, state, idtypedocument)
values(1,'1','PUBLICO EN GENERAL','','','','',DEFAULT,1);