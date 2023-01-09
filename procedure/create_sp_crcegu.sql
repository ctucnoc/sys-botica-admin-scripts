create or replace function crcegu.sp_search_word_key_user(
in in_word_key varchar
)returns table(
id integer,
username varchar,
password varchar,
fullname varchar,
email varchar,
state varchar,
passwordchangefirstlogin varchar,
numberattempts integer
)
as
$$
begin
 return query(
 	select 
	 u.*
	 from
	 crcegu.adm_user u
	 where 
	 crce.sp_pre_format_cadena_ref(replace(lower(u.username || u.fullName || u.email),chr(32),''))
	 like crce.sp_pre_format_cadena_ref(replace(lower('%'||in_word_key||'%'),chr(32),''))
 );
end;
$$
language 'plpgsql';


create or replace function crcegu.sp_exists_user_authority(
in in_id_user integer,
in in_id_authority integer,
in in_state varchar
)returns boolean
as
$$
declare
 v_cant integer := 0;
begin
 select count(*) into v_cant
 from crcegu.adm_user_authority ua
 where ua.iduser = in_id_user
 and ua.idauthority = in_id_authority
 and ua.state = in_state;
 if(v_cant > 0) then
 	return true;
 else
 	return false;
 end if;
end;
$$
language 'plpgsql';


create or replace function crcegu.sp_register_user_authority(
in in_iduser integer,
in in_idauthority integer,
in in_state varchar
)returns setof crcegu.adm_user_authority
as
$$
declare 
 v_id integer := 0;
begin
 insert 
 into 
 crcegu.adm_user_authority(iduser,idauthority,state)
 values(in_iduser,in_idauthority,in_state) returning id into v_id;
 return query
 	select * from crcegu.adm_user_authority where id = v_id;
end;
$$
language 'plpgsql';

CREATE OR REPLACE FUNCTION crcegu.sp_minus_authority(
	in_id integer,
	in_state character varying)
    RETURNS TABLE(id integer, name character varying, description character varying, state character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
begin
	return query(
		select 
		au.id,
		au.name,
		au.description,
		au.state 
		from crcegu.adm_authority au 
		where au.state = in_state
		EXCEPT ALL
		select 
		ta.id,
		ta.name,
		ta.description,
		ta.state 
		from crcegu.adm_user_authority ua, crcegu.adm_authority ta
		where ua.idauthority = ta.id and ua.iduser = in_id and ua.state = in_state
	);
end;
$BODY$;

ALTER FUNCTION crcegu.sp_minus_authority(integer, character varying)
    OWNER TO postgres;