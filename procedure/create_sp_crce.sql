create function crce.sp_pre_format_cadena_ref(ref_msg text) returns text
as
$$
declare 
 r_a text;
 r_e text;
 r_i text;
 r_o text; 
 r_u text;
begin
 r_a:=replace(lower(ref_msg),chr(225),chr(97));
 r_e:=replace(lower(r_a),chr(233),chr(101));
 r_i:=replace(lower(r_e),chr(237),chr(105));
 r_o:=replace(lower(r_i),chr(243),chr(111));
 r_u:=replace(lower(r_o),chr(250),chr(117));
 return r_u;
end;
$$
language 'plpgsql';


create function crce.sp_search_word_key_product(in_key_word character varying, in_state character varying)
    returns TABLE(
        id integer,
        name character varying,
        summaryname character varying,
        isexpiratedate character varying,
        isrefrigeration character varying,
        isbatch character varying,
        isgeneric character varying,
        iskit character varying,
        state character varying,
        idcategory integer,
        idmark integer,
        idunit integer,
        ismedicine character varying,
        barcode character varying,
        iscontrolled character varying)
as
$$
begin
 	return query(
		select p.*
		from crce.adm_product p, crce.adm_category c, crce.adm_mark m, crce.adm_unit u
		where p.idcategory = c.id and p.idmark = m.id and p.idunit = u.id and p.state = in_state
		and crce.sp_pre_format_cadena_ref(replace(lower(p.name || p.summaryname || c.name || c.description || m.name || u.initials || u.description || p.barcode),chr(32),''))
		like crce.sp_pre_format_cadena_ref(replace(lower('%'||in_key_word||'%'),chr(32),''))
	);
end;
$$
language 'plpgsql';


create or replace function crce.sp_search_word_key_provider(
in in_word_key varchar,
in in_state varchar
)returns table(
id integer,
bussinesname varchar,
tradename varchar,
ruc varchar,
address varchar,
cellphone varchar,
email varchar,
webpage varchar,
representative varchar,
state varchar
)
as
$$
begin
 return query(
 	select 
	 p.*
	 from
	 crce.adm_provider p
	 where 
	 p.state = in_state
	 and crce.sp_pre_format_cadena_ref(replace(lower(p.bussinesname || p.tradename || p.ruc || p.email || p.webpage || p.representative),chr(32),''))
	 like crce.sp_pre_format_cadena_ref(replace(lower('%'||in_word_key||'%'),chr(32),''))
 );
end;
$$
language 'plpgsql';

create or replace function crce.sp_search_word_key_dt_entry_product(
in in_idwharehouse integer,
in in_word_key varchar,
in in_state varchar
)returns table(
 id integer,
 idproduct integer,
 identryproduct integer,
 purchaseprecio double precision,
 amount integer,
 expiratedate timestamp,
 lotnumber varchar,
 state varchar,
 usercreated varchar,
 useralter varchar,
 datecreated timestamp,
 datealter timestamp
)
as
$$
begin
    return query(
        select de.*
        from crce.adm_entry_product ep, crce.adm_dt_entry_product de, crce.adm_product p,crce.adm_category c, crce.adm_mark m, crce.adm_unit u
        where ep.id = de.identryproduct and p.id = de.idproduct and p.idcategory = c.id and p.idmark = m.id and p.idunit = u.id
        and ep.state= in_state and de.state= in_state and ep.idwharehouse= in_idwharehouse and de.amount > 0
        and crce.sp_pre_format_cadena_ref(replace(lower(p.name || p.summaryname || c.name || c.description || m.name || u.initials || u.description || p.barcode),chr(32),''))
        like crce.sp_pre_format_cadena_ref(replace(lower('%'||in_word_key||'%'),chr(32),''))
        order by p.name,de.expiratedate asc
    );
end
$$
language 'plpgsql';

create or replace function crce.sp_register_dt_transfer(
in in_id integer,
in in_idtransfer integer,
in in_iddtentryproduct integer,
in in_amount integer,
in in_user varchar,
in in_date timestamp
)returns setof crce.adm_dt_transfer
as
$$
declare
    v_id integer :=0;
begin
    if in_id > 0 then
        insert into crce.adm_dt_transfer(idtransfer, iddtentryproduct, amount, usercreated, datecreated, state)
        values(in_idtransfer,in_iddtentryproduct,in_amount,in_user,in_date,default) returning id into v_id;
    else
        update crce.adm_dt_transfer
        set idtransfer = in_idtransfer and iddtentryproduct = in_iddtentryproduct and in_amount = amount and useralter = in_user and datealter = in_date
        where id = in_id;
        v_id := in_id;
    end if;
    update crce.adm_dt_transfer set amount = amount - in_amount where id = in_iddtentryproduct;
    return query
        select * from crce.adm_dt_transfer where id = v_id;
end;
$$
language 'plpgsql';


create function crce.sp_search_word_key_custommer(
in_word_key varchar,
in_state varchar)
    returns TABLE(
        id integer,
        numberdocument varchar,
        firstname varchar,
        lastname varchar,
        bussinesname varchar,
        email varchar,
        direction varchar,
        state varchar,
        idtypedocument integer
    )
as
$$
begin
    return query(
        select c.*
        from crce.adm_customer c, crceutil.util_type_document t
        where c.idtypedocument = t.id and c.state = in_state and t.state = in_state
        and crce.sp_pre_format_cadena_ref(replace(lower(c.numberdocument || c.firstname || c.lastname || c.bussinesname || c.email || c.direction || t.description),chr(32),''))
        like crce.sp_pre_format_cadena_ref(replace(lower('%'||in_word_key||'%'),chr(32),''))
        order by 2 asc
    );
end;
$$
language 'plpgsql';

create or replace function crce.sp_search_word_key_product_transfer(
in in_idsubsidiary integer,
in in_word_key varchar,
in in_state varchar
)returns table(
    id integer,
    idtransfer integer,
    iddtentryproduct integer,
    amount integer,
    usercreated varchar,
    useralter varchar,
    datecreated timestamp,
    datealter timestamp,
    state varchar,
    saleprice double precision
)
as
$$
begin
    return query(
        select dt.*
        from crce.adm_dt_transfer dt,crce.adm_transfer t,
        crce.adm_dt_entry_product de, crce.adm_product p,
        crce.adm_category c,crce.adm_mark m, crce.adm_unit u
        where t.id = dt.idtransfer and dt.iddtentryproduct = de.id and
        de.idproduct = p.id and p.idcategory = c.id and p.idmark = m.id
        and p.idunit = u.id and dt.amount > 0
        and dt.state = in_state and t.idsubsidiary = in_idsubsidiary
        and crce.sp_pre_format_cadena_ref(replace(lower(p.name || p.summaryname || c.name || c.description || m.name || u.initials || u.description || p.barcode),chr(32),''))
        like crce.sp_pre_format_cadena_ref(replace(lower('%'||in_word_key||'%'),chr(32),''))
        order by p.name,de.expiratedate asc
    );
end;
$$
language 'plpgsql';

create or replace function crce.sp_search_sale_parameter(
in in_idcustomer integer,
in in_idproofpayment integer,
in in_dateFrom varchar,
in in_dataTo varchar,
in in_state varchar
) returns table(
    id integer,
    idcustomer integer,
    idproofpayment integer,
    usercreated varchar,
    useralter varchar,
    datecreated timestamp,
    datealter timestamp,
    state varchar
)
as
$$
begin
    return query(
        select sa.*
        from crce.adm_sale sa
        where
        (nullif(in_state,'') is null or sa.state = in_state) and
        (nullif(cast(case when in_idcustomer = 0 then null when in_idcustomer > 0 then in_idcustomer end as varchar),'') is null or sa.idcustomer = in_idcustomer) and
        (nullif(cast(case when in_idproofpayment = 0 then null when in_idproofpayment > 0 then in_idproofpayment end as varchar),'') is null or sa.idproofpayment = in_idproofpayment) and
        ((nullif(in_dateFrom,'') is null) or (nullif(in_dataTo,'') is null) or cast(cast(sa.datecreated as date) as varchar) between in_dateFrom and in_dataTo)
        order by sa.datecreated desc
    );
end;
$$
language 'plpgsql';

create or replace function crce.sp_total_sale_price(
in in_idsale integer
)returns double precision
as
$$
declare
    v_total double precision := 0.0;
begin
    select round(sum(ds.saleprice*ds.saleamount)::numeric,2) into v_total from crce.adm_dt_sale ds
    where ds.idsale = in_idsale and ds.state = '1';
    return v_total;
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_quantity_category()
returns integer
as
$$
declare
    v_quantity_category integer:= 0;
begin
    select count(*) into v_quantity_category from crce.adm_category c where c.state = '1';
    return v_quantity_category;
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_quantity_mark()
returns integer
as
$$
declare
    v_quantity_mark integer:= 0;
begin
    select count(*) into v_quantity_mark from crce.adm_mark m where m.state = '1';
    return v_quantity_mark;
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_quantity_provider()
returns integer
as
$$
declare
    v_quantity_provider integer:= 0;
begin
    select count(*) into v_quantity_provider from crce.adm_provider p where p.state = '1';
    return v_quantity_provider;
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_quantity_product()
returns integer
as
$$
declare
    v_quantity_product integer:= 0;
begin
    select count(*) into v_quantity_product from crce.adm_product p where p.state = '1';
    return v_quantity_product;
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_quantity_unit()
returns integer
as
$$
declare
    v_quantity_unit integer:= 0;
begin
    select count(*) into v_quantity_unit from crce.adm_unit u where u.state = '1';
    return v_quantity_unit;
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_quantity_customer()
returns integer
as
$$
declare
    v_quantity_customer integer:= 0;
begin
    select count(*) into v_quantity_customer from crce.adm_customer c where c.state = '1';
    return v_quantity_customer;
end;
$$
language 'plpgsql';

create or replace function crce.sp_total_sale(
in in_dateFrom varchar,
in in_dateTo varchar
)returns double precision
as
$$
declare
v_total double precision:= 0.0;
begin
    select
    round(sum(ds.saleamount*ds.saleprice)::numeric,2) into v_total
    from
    crce.adm_sale sa,
    crce.adm_dt_sale ds
    where
    sa.id = ds.idsale and
    sa.state = '1' and
    ds.state = '1' and
    cast(cast(sa.datecreated as date) as varchar) between in_dateFrom and in_dateTo;
    return v_total;
end
$$
language 'plpgsql';

create or replace function crce.sp_get_daily_sale(
in in_date_init varchar,
in in_state varchar,
in in_idsubsidiary integer
)returns table(
	p_fullname varchar,
	p_quantity integer
)
as
$$
begin
	return query(
		select 
		tu.fullname,
		cast(count(tsa.id) as integer) as quantity
		from 
		crcegu.adm_user_subsidiary tus, 
		crcegu.adm_user tu,
		crce.adm_subsidiary tsb,
		crce.adm_sale tsa
		where tus.iduser = tu.id 
		and tsb.id = in_idsubsidiary
		and tsb.state = in_state
		and tsa.state = in_state
		and tu.state = in_state
		and tus.state = in_state
		and tsa.usercreated = tu.username
		and cast(cast(tsa.datecreated as date) as varchar) = cast(cast(in_date_init as date) as varchar) 
		group by 1
		order by 1
	);
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_month_sale(
in in_month integer,
in in_state varchar,
in in_idsubsidiary integer
)returns table(
	p_fullname varchar,
	p_quantity integer
)
as
$$
begin
	return query(
		select 
		tu.fullname,
		cast(count(tsa.id) as integer) as quantity
		from 
		crcegu.adm_user_subsidiary tus, 
		crcegu.adm_user tu,
		crce.adm_subsidiary tsb,
		crce.adm_sale tsa
		where tus.iduser = tu.id 
		and tsb.id = in_idsubsidiary
		and tsb.state = in_state
		and tsa.state = in_state
		and tu.state = in_state
		and tus.state = in_state
		and tsa.usercreated = tu.username
		and cast(extract(month from tsa.datecreated) as integer) = in_month 
		group by 1
		order by 1
	);
end;
$$
language 'plpgsql';

create or replace function crce.sp_get_month_sale(
in in_month integer,
in in_state varchar,
in in_idsubsidiary integer
)returns table(
	p_fullname varchar,
	p_quantity integer
)
as
$$
begin
	return query(
		select 
		tu.fullname,
		cast(count(tsa.id) as integer) as quantity
		from 
		crcegu.adm_user_subsidiary tus, 
		crcegu.adm_user tu,
		crce.adm_subsidiary tsb,
		crce.adm_sale tsa
		where tus.iduser = tu.id 
		and tsb.id = in_idsubsidiary
		and tsb.state = in_state
		and tsa.state = in_state
		and tu.state = in_state
		and tus.state = in_state
		and tsa.usercreated = tu.username
		and cast(extract(month from tsa.datecreated) as integer) = in_month 
		group by 1
		order by 1
	);
end;
$$
language 'plpgsql';