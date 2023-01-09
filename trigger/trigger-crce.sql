create or replace function crce.sp_update_dt_entry_product()
returns trigger
as
$$
DECLARE
  vReturn RECORD;
begin
    update crce.adm_dt_entry_product set amount = amount - NEW.amount where id = NEW.iddtentryproduct;
    vReturn:=NEW;
    return  vReturn;
end;
$$
language 'plpgsql';

CREATE TRIGGER tr_insert_dt_transfer
AFTER INSERT
ON crce.adm_dt_transfer
FOR EACH ROW
EXECUTE PROCEDURE crce.sp_update_dt_entry_product();

create or replace function crce.sp_update_dt_transfer()
returns trigger
as
$$
DECLARE
  vReturn RECORD;
begin
    update crce.adm_dt_transfer set amount = amount - NEW.saleamount where id = NEW.iddttransfer;
    vReturn:=NEW;
    return  vReturn;
end;
$$
language 'plpgsql';

CREATE TRIGGER tr_insert_dt_sale
AFTER INSERT
ON crce.adm_dt_sale
FOR EACH ROW
EXECUTE PROCEDURE crce.sp_update_dt_transfer();