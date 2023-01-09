alter table crce.adm_product
add ismedicine varchar(1);
COMMENT ON COLUMN crce.adm_product.ismedicine IS '1 : medicamento y o: no es medicamento';

alter table crce.adm_product
add barcode varchar(100);
COMMENT ON COLUMN crce.adm_product.barcode IS 'codigo de barra del producto';

alter table crce.adm_product
add iscontrolled varchar(1);
COMMENT ON COLUMN crce.adm_product.iscontrolled IS '1: producto controlado y 0: no es un producto controlado';

alter table crce.adm_dt_transfer
add column saleprice double precision;
COMMENT ON COLUMN crce.adm_dt_transfer.saleprice IS 'precio de venta al consumidor final';
