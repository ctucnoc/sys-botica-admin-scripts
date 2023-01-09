insert into crcegu.adm_security_policy(minpasswordlength,maxpasswordlength,maxnumberattempts,maxidletime,passwordchangefirstlogin) 
values(8,15,3,1000,default);


INSERT INTO crcegu.adm_authority(name, description, state) 
VALUES ('ROLE_ADMIN', 'CON ESTE ROL EL USUARIO TENDRA TODO LOS PRIVILEGIOS', default);

INSERT INTO crcegu.adm_user(username,password,fullname,email,state,passwordchangefirstlogin,numberattempts)
values('CRCEDBA','$2a$10$n1U5X25aPXRSMPCbHJqCL.f6n4XUC/P2V8oNmgDg1Ux/GCG3EUcvW','CRCEDBA','sesyfarma.botica@gmail.com',default,1,0);

insert into crcegu.adm_user_authority(iduser,idauthority,state) values(1,1,'1');

insert into crcegu.adm_user_subsidiary(iduser,idsubsidiary,state) values(1,1,default);