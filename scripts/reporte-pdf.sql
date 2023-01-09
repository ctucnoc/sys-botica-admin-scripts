select
tp.name as product,
tc.name as category,
tm.name as mark,
tu.initials as unit,
dt.amount,
cast(to_char(de.expiratedate,'DD/MM/YYYY') as varchar) as expiratedate,
twa.name as wharehouse,
tsu.name as subsidiary
from
crce.adm_transfer tf,
crce.adm_dt_transfer dt,
crce.adm_dt_entry_product de,
crce.adm_product tp,
crce.adm_category tc, 
crce.adm_mark tm, 
crce.adm_unit tu,
crce.adm_subsidiary tsu,
crce.adm_wharehouse twa
where 
tf.id = dt.idtransfer and
dt.iddtentryproduct = de.id and
de.idproduct = tp.id and
tp.idcategory = tc.id and
tp.idmark = tm.id and
tp.idunit = tu.id and
tf.idsubsidiary = tsu.id and
tf.idwharehousedestination = twa.id and
tf.state = '1' and
dt.state = '1' and
de.state = '1' and
twa.id = 4 and
dt.amount > 0
order by 1,2,3,4,5,6;