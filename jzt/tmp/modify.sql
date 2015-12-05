-- // rebuild table contracts
-- insert or ignore into contracts (instrumentid,sector,manual_flag,update_time)
-- select distinct instrumentid,substr(instrumentid,1,length(instrumentid)-2),0,"2015-10-10 13:38:07" from oneminute;

-- // add column cnt_min to table sectors 
create temporary table tmp_1 (instrumentid TEXT NOT NULL, tradingday int not null, cnt int, primary key (instrumentid, tradingday));
insert into tmp_1 (instrumentid,tradingday,cnt) 
select instrumentid,tradingday,count(*)  from oneminute group by instrumentid,tradingday ;
alter table sectors add column cnt_min INT; 
insert or replace into sectors 
(sector,   exchange,  manual_flag, update_time,  mintick,  multiplier,  cnt_min) 
select 
s.sector,s.exchange,s.manual_flag,s.update_time,s.mintick,s.multiplier,max(cnt) 
from tmp_1 t,sectors s 
where substr(t.instrumentid,1,length(t.instrumentid)-2) == s.sector 
group by s.sector; 

-- update sectors set cnt_min = 560 
-- where sector = "AU"

-- select * from sectors order by cnt_min DESC ;
-- select * from sectors 
-- where cnt_min is NULL 
-- order by cnt_min DESC ;

-- update sectors 
-- set cnt_min = 229 
-- where cnt_min is NULL 
-- where cnt_min <=230 
-- where instrumentid = 'RU'
