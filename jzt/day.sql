/* @date1, @date2 must be changed before running */

create temporary table if not exists tmp_day (
       tradingday int not null,
       instrumentid text not null,
       open DOUBLE,
       high DOUBLE,
       low DOUBLE,
       close DOUBLE,
       settlementprice DOUBLE ,
       volume INT ,
       openint INT ,
       amount DOUBLE,
       presettlementprice DOUBLE,
       precloseprice DOUBLE,
       primary key (tradingday,instrumentid)
);

insert into tmp_day (
tradingday,instrumentid,high,		low,	volume,		amount )
select 
tradingday,instrumentid,max(high),min(low),sum(volume),sum(amount)
from oneminute where tradingday >= @date1 and tradingday <= @date2 
group by tradingday,instrumentid;

-- CREATE INDEX day_symbol on oneminute (tradingday, instrumentid);
create temporary table idx (
       tradingday int not null,
       updatetime text not null,
       instrumentid text not null, 
       id integer primary key autoincrement);
       
insert into idx (tradingday,instrumentid,updatetime)
select tradingday,instrumentid,updatetime from oneminute 
where tradingday >= @date1 and tradingday <= @date2 
group by tradingday,instrumentid,updatetime ;

create temporary table tmp (
       tradingday int,
       instrumentid text, 
       min int,
       max int, 
       primary key (tradingday,instrumentid));

insert into tmp (
tradingday,instrumentid,min,max)
select 
tradingday,instrumentid,min(id),max(id)
from idx group by tradingday,instrumentid;

-- //** FOR YOUR CONSIDERATION~~

update or ignore tmp_day 
set open = (
select o.open
from 
oneminute o join idx i on o.tradingday=i.tradingday and o.instrumentid=i.instrumentid 
join tmp t on i.tradingday=t.tradingday and i.instrumentid=t.instrumentid and i.id=t.min 
where 
tmp_day.tradingday=o.tradingday and tmp_day.instrumentid=o.instrumentid 
);

insert or replace into tmp_day 
(tradingday,instrumentid,      open,	high,	low,close,	volume,  openint,amount )
select 
d.tradingday,d.instrumentid,d.open,d.high,d.low,o.close,d.volume,o.openint,d.amount 
from 
tmp_day d, oneminute o, idx i, tmp t  
where
d.tradingday=o.tradingday and d.instrumentid=o.instrumentid and o.tradingday=i.tradingday and o.instrumentid=i.instrumentid 
and i.tradingday=t.tradingday and i.instrumentid=t.instrumentid and i.id=t.max 
group by o.tradingday,o.instrumentid;

select tradingday,count(*) from tmp_day group by tradingday;
insert into day
select * from tmp_day;

select "day after insertion:";
select tradingday, count(*) from day group by tradingday;

