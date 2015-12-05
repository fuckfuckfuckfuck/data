create temporary table if not exists oneminute_0 (
       `tradingday` INT NOT NULL,
  `updatetime` TEXT NOT NULL,
  `instrumentid` TEXT NOT NULL,
  `open` double ,
  `high` double ,
  `low` double ,
  `close` double ,
  `volume` int ,
  `amount` int ,
  `openint` int ,
  `sgnvol` int,
  PRIMARY KEY (`instrumentid`,`tradingday`,`updatetime`)
);

delete from oneminute_0;

create temporary table if not exists tmp_mm (
       `tradingday` INT NOT NULL,
       `updatetime` TEXT NOT NULL,
       `instrumentid` TEXT NOT NULL,
       `max` INT,
       `min` INT,
       PRIMARY KEY (`instrumentid`,`tradingday`,`updatetime`)
);

delete from tmp_mm;

insert into tmp_mm (
tradingday,updatetime,									instrumentid,max,	min)
select 
tradingday,substr(updatetime,1,length(updatetime)-3) dt,instrumentid,max(id),min(id)
from ticks group by tradingday,dt,instrumentid;

insert or replace into oneminute_0 (
tradingday,updatetime,					instrumentid,high,	    low,	 volume,	 amount,    sgnvol )
select 
tradingday,substr(updatetime,1,length(updatetime)-3) dt,instrumentid,max(lastprice),min(lastprice),sum(volume),sum(amount),sum(case isbuy when 0 then -1*volume else volume end)
from ticks group by tradingday,dt,instrumentid;

-- update or ignore oneminute_0
-- set open = (
-- select lastprice from ticks t join tmp_mm m  
-- on t.tradingday=m.tradingday and t.instrumentid=m.instrumentid and 
-- substr(t.updatetime,1,length(t.updatetime)-3) == m.updatetime and t.id == m.min 
-- where 
-- oneminute_0.tradingday == t.tradingday and oneminute_0.instrumentid == t.instrumentid 
-- and oneminute_0.updatetime == m.updatetime ); 

insert or replace into oneminute_0 (
tradingday,  updatetime,instrumentid,	open,	high,	low, volume,amount, sgnvol )
select
o.tradingday,o.updatetime,o.instrumentid,lastprice,o.high,o.low,o.volume,o.amount,o.sgnvol 
from oneminute_0 o, ticks t , tmp_mm m 
where 
o.tradingday == m.tradingday and o.updatetime == m.updatetime and o.instrumentid == m.instrumentid and 
t.tradingday == m.tradingday and substr(t.updatetime,1,length(t.updatetime)-3) == m.updatetime and 
t.instrumentid == m.instrumentid and t.id == m.min 
group by m.tradingday,m.updatetime,m.instrumentid;

insert or replace into oneminute_0 (
tradingday,updatetime,    instrumentid,open,	high,	low,	close,	volume,amount,	openint, sgnvol )
select
o.tradingday,o.updatetime,o.instrumentid,o.open,o.high,o.low,lastprice,o.volume,o.amount,t.openint,o.sgnvol 
from oneminute_0 o, ticks t , tmp_mm m 
where 
o.tradingday == m.tradingday and o.updatetime == m.updatetime and o.instrumentid == m.instrumentid and 
t.tradingday == m.tradingday and substr(t.updatetime,1,length(t.updatetime)-3) == m.updatetime and 
t.instrumentid == m.instrumentid and t.id == m.max 
group by m.tradingday,m.updatetime,m.instrumentid;

insert into oneminute
select * from oneminute_0;

-- delete from  oneminute_0;

-- update or ignore oneminute_0
-- set close = (
-- select lastprice from ticks t join tmp_mm m  
-- on t.tradingday=m.tradingday and t.instrumentid=m.instrumentid and 
-- substr(t.updatetime,1,length(t.updatetime)-3) == m.updatetime and t.id == m.max 
-- where 
-- oneminute_0.tradingday == t.tradingday and oneminute_0.instrumentid == t.instrumentid 
-- and oneminute_0.updatetime == m.updatetime );

-- update or ignore oneminute_0
-- set openint = (
-- select openint from ticks t join tmp_mm m  
-- on t.tradingday=m.tradingday and t.instrumentid=m.instrumentid and 
-- substr(t.updatetime,1,length(t.updatetime)-3) == m.updatetime and t.id == m.max  
-- where 
-- oneminute_0.tradingday == t.tradingday and oneminute_0.instrumentid == t.instrumentid 
-- and oneminute_0.updatetime == m.updatetime );

-- select sum(volume),sum(amount),sum(case isbuy when 0 then -1*volume else volume end)
-- from ticks group by tradingday,substr(updatetime,1,length(updatetime)-2) ,instrumentid limit 20 

-- summary
select "oneminute_0:";
select tradingday,count(*) from oneminute_0 group by tradingday;
select "oneminute afer insertion:";
select tradingday,count(*) from oneminute group by tradingday order by tradingday DESC limit 5;
