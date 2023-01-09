create or replace view crce.v_dashboard
as
    select
    cast(md5(random()::text || clock_timestamp()::text)::uuid as varchar) as id,
    crce.sp_get_quantity_product() as quantity_product,
    crce.sp_get_quantity_provider() as quantity_provider,
    crce.sp_get_quantity_mark() as quantity_mark,
    crce.sp_get_quantity_category() as quantity_category,
    crce.sp_get_quantity_unit() as quantity_unit,
    crce.sp_get_quantity_customer() as quantity_customer;


CREATE OR REPLACE VIEW crce.v_sale_date
 AS
 SELECT md5(random()::text || clock_timestamp()::text)::uuid::character varying AS id,
    sa.datecreated::date AS date,
    round(sum(ds.saleamount::double precision * ds.saleprice)::numeric, 2) AS total_price
   FROM crce.adm_sale sa,
    crce.adm_dt_sale ds
  WHERE sa.id = ds.idsale AND sa.state::text = '1'::text AND ds.state::text = '1'::text
  GROUP BY (sa.datecreated::date)
  ORDER BY (sa.datecreated::date)
 LIMIT 7;

ALTER TABLE crce.v_sale_date
    OWNER TO admin;