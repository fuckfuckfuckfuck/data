INSERT INTO ctp  (id,thread, loglevel, TradingDay, InstrumentID, LastPrice, PreSettlementPrice , PreClosePrice, PreOpenInterest, OpenPrice, HighestPrice, LowestPrice, Volume, Turnover, OpenInterest, ClosePrice, SettlementPrice, UpperLimitPrice, LowerLimitPrice, UpdateTime, UpdateMillisec, BidPrice1, BidVolume1, AskPrice1, AskVolume1, AveragePrice, seq_num) VALUES (18246655,139707331954432,'DEBUG',20140627,'au1408',  263.25, 264.05, 263.8, 212, 262.45, 263.25, 262.45, 16, 4.2072e+06, 220, 1.79769e+308,1.79769e+308, 277.25, 250, 250.8, '02:00:15', 0, 262.75, 2, 263.3, 1, 262950, 255957)
select left(updatetime,5) as dt, count(*) from tmp where (left(updatetime,5) > "02:30" and left(updatetime,5) < "07:33") group by dt;
select * from tmp where (left(updatetime,5) > "02:30" and left(updatetime,5) < "07:33") group by left(updatetime,5); 
select * from tmp where (left(updatetime,5) == "07:09")
select * from tmp where loglevel != "DEBUG"

select count(*) from ctp where tradingday = 20140710 and (updatetime <= "02:30:00" or (updatetime >= "09:00:00" and updatetime <="15:15:00") or updatetime > "20:59:00")
select left(updatetime,4) as t count(*) from ctp group by t
 
select instrumentid,lastprice,openprice,volume,turnover,openinterest,closeprice,settlementprice,updatetime + INTERVAL updatemillisec*1000 MICROSECOND as dt,bidprice1,bidvolume1,askprice1,askvolume1 from ctp where tradingday=20140721 limit 10   

select instrumentid,count(*) from ctp where tradingday=20140721 group by instrumentid ## cmp al1410 zn1410

// 
select count(*) from tmp where instrumentid='al1410' 
select count(*) from tmp where instrumentid='zn1410' 

每一天的18点至19点之间，会把当日全部合约的当日收盘价传一遍，当然，日期则是下一个交易日的，即9点开盘时的日期。

2014-09-25
## create index idx0 on t20140924 (tradingday)
create index idx1 on t20140924 (instrumentid)
create index idx2 on t20140924 (updatetime,updatemillisec)
## indexation
SELECT LEFT(updatetime,4) t,count(*) FROM t20140924 GROUP BY t ORDER BY t ASC

SET @TIME = "07:1";
SET @TBL = t20140924;
## 1st log
SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924 
WHERE left(updatetime,4)=@TIME ORDER BY instrumentid ASC  
 
## 2nd price,vol,oint
SELECT updatetime,instrumentid,lastprice,volume,openinterest FROM t20140924 
WHERE left(updatetime,5)=@TIME ORDER BY instrumentid ASC 

## 3rd priceS
SELECT updatetime,instrumentid,lastprice,openprice,highestprice,LowestPrice,upperlimitprice,lowerlimitprice,AveragePrice FROM t20140924 
WHERE left(updatetime,4)=@TIME ORDER BY instrumentid ASC

## 4th pq books
SELECT updatetime,updatemillisec,instrumentid,lastprice,volume,openinterest,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice FROM t20140924 
WHERE left(updatetime,4)=@TIME ORDER BY@TBLntid ASC

SELECT updatetime,updatemillisec,instrumentid,lastprice,volume,BidPrice1,BidVolume1,AskPrice1,AskVolume1 FROM t20140924 
WHERE instrumentid = "TA504" ORDER BY seq_num limit 100 


## rmk on t20140924:
15:3 exist 15 records. Triple for IF1410,IF1412,IF1503,TF1412,TF1503.
02:3 exist 50 records. All AG,AU.
07:1 exist 5 records. All IF,TF.
07:3 exist 371 records. Seems to be all mkts, some repeations.
08:5 exist 135 records. All mkts. 
11:3 exist 135 records.
18:3 exist 279 records. 
19:0 exist 87 records.
19:1 exist 217 records.
20:5 exist 76 records.
14:59. Some CZCE have settlementprice and closeprice.

## stlmnt prc time:
IF TF 15:30
DCE 15:00:32
SHFE 15:00:00
CZCE 14:59:30


select * from (select instrumentid,min(updatetime) as t,max(volume) as v,min(settlementprice) as ps from t20140924 where updatetime <= "15:50" and settlementprice < 1.0e308 group by instrumentid ) as t where t.v >0 order by t.t DESC

select * from (select instrumentid,min(updatetime) as t,max(volume) as v,min(closeprice) as ps from t20140924 where updatetime <= "15:50" and closeprice < 1.0e308 group by instrumentid ) as t where t.v >0 order by t.t DESC

select updatetime,instrumentid,settlementprice,closeprice FROM t20140924 where closeprice <= 1.0e308 and settlementprice <= 1.0e308 group by instrumentid order by NULL 

## redundant records
SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924 a where (a.instrumentid,a.updatetime,a.updatemillisec) in (select instrumentid,updatetime,updatemillisec from t20140924 group by instrumentid,updatetime,updatemillisec having count(*)>1)

## only CEFFEX SHFE have non zero updatemillisec.

mysql中如何计算日期之差:
select unix_timestamp(date)-unix_timestamp(end) as '两者相差的秒数' from '表名'；
#select left(updatetime,5) as t,count(*) from ctp where tradingday =20140818 group by t order by t;
 
-- select * from ctp where tradingday =20140818;
-- SET @TBL = t20140924;
-- select * from t20140924 limit 1;
-- SELECT LEFT(updatetime,4) t,count(*) FROM t20140924 GROUP BY t ORDER BY t ASC;
-- create index idx1 on t20140924 (instrumentid);
-- SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924 
-- SELECT updatetime,instrumentid,lastprice,openprice,highestprice,LowestPrice,upperlimitprice,lowerlimitprice,AveragePrice FROM t20140924
-- SELECT updatetime,updatemillisec,instrumentid,lastprice,volume,openinterest,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice FROM t20140924 
-- SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924 a where (a.instrumentid,a.updatetime,a.updatemillisec) in (select instrumentid,updatetime,updatemillisec from t20140924 group by instrumentid,updatetime,updatemillisec having count(*)>1)
-- select id,updatetime,UpdateMillisec from t20140924 where instrumentid="CF411" and updatemillisec = 0 
-- select distinct instrumentid from t20140924 where updatemillisec != 0 
-- select distinct instrumentid from t20140924 
-- select distinct InstrumentID from t20140924 where left(instrumentid,2)="IF"
create temporary table tmp (InstrumentID VARCHAR(31) NOT NULL, );
select count(*) from t20140924 where left(instrumentid,2)="IF" group by instrumentid,

2014-10-27
INSERT INTO `sample` VALUES ('2014-09-22','cu1505',46800,48060,48000,3948,48000,48020,46790,1008,237694000,4482,1.79769e308,1.79769e308,50460,45650,'14:57:27',500,46760,2,46790,3,235807,1768184)
INSERT INTO `sample` VALUES ('2014-09-22','IF1410',2383.4,2439.6,2441.4,133563,2438.2,2438.6,2375.6,777093,559643000000,143895,1.79769e308,1.79769e308,2683.4,2195.8,'14:58:15',600,2383.2,16,2383.4,88,720174,1773488)

select * from v1404_Day  limit 5;
select * from zn8888_Min where vol != 0  limit 5;
select distinct ticker from tcontracts order by ticker ASC;
SELECT (contract || "_" || minday FROM tcontracts) as t WHERE ticker == 'IF' and minday == 'Min' order by deliver ASC

-------------------------------------------------------------------------------------------------------
SELECT LEFT(updatetime,4) t,count(*) FROM mktinfo GROUP BY t ORDER BY t ASC
select left(updatetime,5) as dt, count(*) from tmp where (left(updatetime,5) > "02:30" and left(updatetime,5) < "07:33") group by dt;
select * from tmp where (left(updatetime,5) > "02:30" and left(updatetime,5) < "07:33") group by left(updatetime,5); 

SELECT DISTINCT tradingday FROM mktinfo;
SELECT tradingday,count(*) FROM mktinfo GROUP BY tradingday;
SELECT * FROM mktinfo where tradingday = 20150126;
SELECT DISTINCT SUBSTR(updatetime,1,5) t FROM mktinfo where tradingday = 20150126

ATTACH DATABASE 'if.db' AS 'if';

updatetime>='09:00:00' and updatetime <='15:15:00' 

insert into if.mktinfo select * from main.mktinfo where updatetime>='09:00:00' and updatetime <='15:15:00' and substr(instrumentid,1,2) = 'IF' and lastprice<upperlimitprice

ATTACH DATABASE 'ctp_20150202.db' as 'db02';
       
select t1.updatetime,t1.lastprice,t2.lastprice, (t1.lastprice - t2.lastprice),t1.volume,t2.volume from mktinfo as t1 join mktinfo as t2 on (t1.updatetime=t2.updatetime and t1.updatemillisec=t2.updatemillisec and t1.tradingday=20150205 and t1.instrumentid='IF1502' and t2.tradingday = 20150205 and t2.instrumentid='IF1503' ) order by t1.updatetime ASC;
       
//select count(*) from mktinfo where (lastprice >=upperlimitprice or lastprice <=lowerlimitprice)

D:\bin\virtualenv_py27\Scripts\activate

// MySQL tmp@mktinfo
CREATE TABLE `tmp` (
  `id` int(11) NOT NULL,
  `thread` bigint(20) NOT NULL,
  `loglevel` varchar(5) NOT NULL,
  `TradingDay` date NOT NULL,
  `InstrumentID` varchar(31) NOT NULL,
  `LastPrice` double NOT NULL,
  `PreSettlementPrice` double DEFAULT NULL,
  `PreClosePrice` double DEFAULT NULL,
  `PreOpenInterest` int(11) DEFAULT NULL,
  `OpenPrice` double DEFAULT NULL,
  `HighestPrice` double DEFAULT NULL,
  `LowestPrice` double DEFAULT NULL,
  `Volume` int(11) DEFAULT NULL,
  `Turnover` double DEFAULT NULL,
  `OpenInterest` int(11) DEFAULT NULL,
  `ClosePrice` double DEFAULT NULL,
  `SettlementPrice` double DEFAULT NULL,
  `UpperLimitPrice` double DEFAULT NULL,
  `LowerLimitPrice` double DEFAULT NULL,
  `UpdateTime` time DEFAULT NULL,
  `UpdateMillisec` int(11) DEFAULT NULL,
  `BidPrice1` double DEFAULT NULL,
  `BidVolume1` int(11) DEFAULT NULL,
  `AskPrice1` double DEFAULT NULL,
  `AskVolume1` int(11) DEFAULT NULL,
  `AveragePrice` double DEFAULT NULL,
  `seq_num` int(11) NOT NULL,
  KEY `idx0` (`InstrumentID`,`UpdateTime`,`UpdateMillisec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |

//////////////////////////////////////////////////20150206
(id,thread ,TradingDay,InstrumentID,LastPrice,PreSettlementPrice,PreClosePrice,PreOpenInterest,OpenPrice,HighestPrice,LowestPrice,Volume,Turnover,OpenInterest,ClosePrice,SettlementPrice,UpperLimitPrice,LowerLimitPrice,UpdateTime,UpdateMillisec,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice,seq_num)
seq_num, TradingDay, InstrumentID, UpdateTime, UpdateMillisec
id, thread
instrumentid
tradingday,UpdateTime,UpdateMillisec

PreSettlementPrice ,PreClosePrice ,PreOpenInterest 
ClosePrice,SettlementPrice

OpenPrice,HighestPrice,LowestPrice,LastPrice
Volume ,Turnover ,OpenInterest 
UpperLimitPrice,LowerLimitPrice

BidPrice1 ,BidVolume1 ,AskPrice1 ,AskVolume1 ,AveragePrice 
seq_num

select UpdateTime
// time
select count(*) from mktinfo where updatetime>"11:30:00" and updatetime<"13:00:00"
select instrumentid,UpdateTime,UpdateMillisec,Volume,seq_num from mktinfo where updatetime>"11:30:00" and updatetime<"13:00:00" order by seq_num ASC
//select updatetime || updatemillisec from mktinfo limit 1;
//select count(*) from mktinfo t1 join mktinfo t2 on t1.updatetime=t2.updatetime and t1.updatemillisec=t2.updatemillisec and t1.tradingday=t2.tradingday and t1.instrumentid=t2.instrumentid and t1.seq_num<t2.seq_num and ((t1.updatetime || t1.updatemillisec) 
//t1.seq_num=t2.seq_num and ( 

insert into temp.tmp(id,thread ,TradingDay,InstrumentID,LastPrice,PreSettlementPrice,PreClosePrice,PreOpenInterest,OpenPrice,HighestPrice,LowestPrice,Volume,Turnover,OpenInterest,ClosePrice,SettlementPrice,UpperLimitPrice,LowerLimitPrice,UpdateTime,UpdateMillisec,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice,seq_num) select * from mktinfo order by updatetime || updatemillisec ASC
select count(*) from mktinfo t1 join (slect * from mktinfo orderby seq_num ASC) t2 on 
((t1.updatetime || t1.updatemillisec) > (t2.updatetime || t2.updatemillisec))

// PRICEMAX=1000000
// select count(*) from mktinfo where upperlimitprice > 1000000 or upperlimitprice <= 0 or lowerlimitprice > 1000000 or lowerlimitprice <=0 
// valid price 
select count(*) from mktinfo where upperlimitprice > 1000000 or upperlimitprice < lowerlimitprice or lowerlimitprice <=0 
select count(*) from mktinfo where OpenPrice > upperlimitprice or HighestPrice > upperlimitprice or LowestPrice > upperlimitprice or LastPrice > upperlimitprice or BidPrice1 > upperlimitprice or AskPrice1  > upperlimitprice 
select count(*) from mktinfo where OpenPrice < lowerlimitprice or HighestPrice < lowerlimitprice or LowestPrice < lowerlimitprice or LastPrice < lowerlimitprice or BidPrice1 < lowerlimitprice or AskPrice1  < lowerlimitprice 
select count(*) from mktinfo where presettlementprice < 0 or presettlementprice > 1000000 or precloseprice < 0 or precloseprice > 1000000
// AveragePrice excluded
// VOLMAX=1000000000, real data can exceed 1000000, less 2m
// INCREASING VOLUME?>??????????
select count(*) from mktinfo where Volume<0 or Volume>1000000000 or BidVolume1<0 or BidVolume1>1000000000 or AskVolume1<0 or AskVolume1>1000000000
// turnovermax = 2000000000000 ,less 160 billion
select count(*) from mktinfo where Turnover<0 or Turnover>2000000000000 
// openinterest 1000000 
select count(*) from mktinfo where OpenInterest<0 or OpenInterest>10000000
select count(*) from mktinfo where preopeninterest < 0 or preopeninterest > 10000000

// time validation
(
substr(updatetime,1,5) <= "02:30" or 
(substr(updatetime,1,5) >= "09:00" and substr(updatetime,1,5) <= "15:15") or 
substr(updatetime,1,5) >= "21:00" 
)


//20150210
select count(*) from mktinfo t1 join mktinfo t2 on t1.seq_num=t2.seq_num 
select  

select t1.updatetime, t1.UpdateMillisec,t1.LastPrice, t1.Volume ,t1.Turnover ,t1.OpenInterest,t2.LastPrice, t2.Volume ,t2.Turnover ,t2.OpenInterest from mktinfo t1 join mktinfo t2 on t1.updatetime=t2.updatetime and t1.UpdateMillisec=t2.UpdateMillisec and t1.tradingday=t2.tradingday and t1.tradingday=20150205 and t1.instrumentid="IF1502" and t2.instrumentid="IF1503" order by t1.seq_num ASC

select count(*) from mktinfo t1 join mktinfo t2 on t1.updatetime=t2.updatetime and t1.UpdateMillisec=t2.UpdateMillisec and t1.tradingday=t2.tradingday and t1.tradingday=20150205 and t1.instrumentid="IF1502" and t2.instrumentid="IF1503" 
select t1.updatetime, t1.UpdateMillisec,t1.LastPrice, t1.Volume ,t1.Turnover ,t1.OpenInterest,t2.LastPrice, t2.Volume ,t2.Turnover ,t2.OpenInterest from mktinfo t1 join mktinfo t2 on t1.updatetime=t2.updatetime and t1.UpdateMillisec=t2.UpdateMillisec and t1.tradingday=t2.tradingday and t1.tradingday=20150205 and t1.instrumentid="IF1502" and t2.instrumentid="IF1503" order by t1.seq_num ASC limit 5

// 20150409
20150409
// valid
select count(*) from mktinfo where 
(upperlimitprice >= 100000.0 or volume >= 1000000000 or 
openinterest >= 1000000000 or lastprice > upperlimitprice  )
and 
(substr(updatetime,1,5) <= "02:30" or 
substr(updatetime,1,5) >= "09:00" and substr(updatetime,1,5) <= "15:15" or 
substr(updatetime,1,5) >= "21:00" )

select * from mktinfo where instrumentid="IF1504" order by updatetime,updatemillisec limit 10 

ALTER IGNORE TABLE mktinfo ADD COLUMN preVolume int(11) DEFAULT NULL

create temp table tmp (
       idx INTEGER  PRIMARY KEY AUTOINCREMENT ,
    id INT NOT NULL
    ,thread INT NOT NULL
    ,TradingDay INT NOT NULL
    ,InstrumentID TEXT NOT NULL
    ,LastPrice DOUBLE NOT NULL
    ,PreSettlementPrice DOUBLE
    ,PreClosePrice DOUBLE
    ,PreOpenInterest INT
    ,OpenPrice DOUBLE
    ,HighestPrice DOUBLE
    ,LowestPrice DOUBLE
    ,Volume INT
    ,LastVolume INT
    ,Turnover DOUBLE
    ,OpenInterest INT
    ,ClosePrice DOUBLE
    ,SettlementPrice DOUBLE
    ,UpperLimitPrice DOUBLE
    ,LowerLimitPrice DOUBLE
    ,UpdateTime TEXT
    ,UpdateMillisec INT
    ,BidPrice1 DOUBLE
    ,BidVolume1 INT
    ,AskPrice1 DOUBLE
    ,AskVolume1 INT
    ,AveragePrice DOUBLE
    ,seq_num INT NOT NULL )
    
INSERT INTO tmp 
(    id 
    ,thread
    ,TradingDay 
    ,InstrumentID 
    ,LastPrice 
    ,PreSettlementPrice 
    ,PreClosePrice 
    ,PreOpenInterest 
    ,OpenPrice 
    ,HighestPrice 
    ,LowestPrice 
    ,Volume 
    ,Turnover 
    ,OpenInterest 
    ,ClosePrice 
    ,SettlementPrice 
    ,UpperLimitPrice 
    ,LowerLimitPrice 
    ,UpdateTime 
    ,UpdateMillisec 
    ,BidPrice1 
    ,BidVolume1 
    ,AskPrice1 
    ,AskVolume1 
    ,AveragePrice 
    ,seq_num )
select  id 
    ,thread
    ,TradingDay 
    ,InstrumentID 
    ,LastPrice 
    ,PreSettlementPrice 
    ,PreClosePrice 
    ,PreOpenInterest 
    ,OpenPrice 
    ,HighestPrice 
    ,LowestPrice 
    ,Volume 
    ,Turnover 
    ,OpenInterest 
    ,ClosePrice 
    ,SettlementPrice 
    ,UpperLimitPrice 
    ,LowerLimitPrice 
    ,UpdateTime 
    ,UpdateMillisec 
    ,BidPrice1 
    ,BidVolume1 
    ,AskPrice1 
    ,AskVolume1 
    ,AveragePrice 
    ,seq_num 
 from mktinfo 
 // order by updatetime,updatemillisec,instrumentid 

create temp table rank (
id integer primary key autoincrement,
idx int)

update tmp 
set lastvolume = (
select t2.volume from tmp t2 
where tmp.tradingday = t2.tradingday and tmp.instrumentid = t2.instrumentid 
and (t2.updatetime < tmp.updatetime or 
(t2.updatetime = tmp.updatetime and t2.updatemillisec < tmp.updatemillisec))
order by t2.updatetime, t2.updatemillisec
limit 1)

update tmp 
set lastvolume = (
select max(t2.volume) from tmp t2 
where tmp.instrumentid = t2.instrumentid and tmp.tradingday = t2.tradingday and t2.idx < tmp.idx)

// 20150410

MAX_PRICE = 100000
MAX_VOLUME = 1000000000
select count(*) from ctp where lastprice >= MAX_PRICE or volume >= MAX_VOLUME or openinterest >= MAX_VOLUME	
select updatetime,updatemillisec,instrumentid,lastprice,volume,bidprice1,bidvolume1,askprice1,askpricevolume1 
from ctp where tradingday=20140711 and instrumentid="IF1409" order by updatetime,updatemillisec 

// OHLCVI      
// what about volume->trade??????!!!!!!
ALTER IGNORE TABLE ctp ADD COLUMN preVolume int(11) DEFAULT NULL
UPDATE ctp t1
SET t1.preVolume = (
select max(volume) from ctp where t1.tradingday = tradingday and t1.instrumentid = instrumentid and seq_num < t1.seq_num
)

// sqlite + python
alter table mktinfo 
add column prevolume int

CREATE TEMP TABLE if not exists mktinfofake (
       seq_num INT NOT NULL,
       TradingDay INT NOT NULL,
       instrumentid TEXT NOT NULL,
       updatetime TEXT,
       updatemillisec INT,
       volume INT
)
insert into mktinfofake 
select
seq_num,	tradingday,	instrumentid,updatetime,updatemillisec,volume 
from mktinfo

UPDATE mktinfo 
SET preVolume = (
select max(volume)
from mktinfofake 
where mktinfo.tradingday = tradingday and 
mktinfo.instrumentid = instrumentid and 
seq_num < mktinfo.seq_num
)

update oneminute,
(select 
tradingday, instrumentid,
substr(updatetime,1,5) dt,
SUBSTRING_INDEX(GROUP_CONCAT(CAST(lastprice as CHAR) ORDER BY seq_num),',',1) as open,
SUBSTRING_INDEX(GROUP_CONCAT(CAST(lastprice as CHAR) ORDER BY seq_num DESC),',',1) as close, 
SUBSTRING_INDEX(GROUP_CONCAT(CAST(openinterest as CHAR) ORDER BY seq_num),',',1) openint 
from ctp where 
tradingday = 20140711 and
updatetime >= "09:00:00" and 
updatetime <= "15:15:00"
group by tradingday,dt,instrumentid) tt
set 
oneminute.open = tt.open,
oneminute.close= tt.close,
oneminute.openint = tt.openint
where 
oneminute.tradingday = tt.tradingday and
substr(oneminute.updatetime,1,5) = tt.dt and
oneminute.instrumentid = tt.instrumentid 

		       
CREATE TABLE if not exists `oneminute` (
  `tradingday` date NOT NULL,
  `updatetime` time NOT NULL,
  `instrumentid` varchar(31) NOT NULL,
  `open` double NOT NULL,
  `high` double NOT NULL,
  `low` double NOT NULL,
  `close` double NOT NULL,
  `volume` int(11) NOT NULL,
  `openint` int(11) NOT NULL,
  PRIMARY KEY (`instrumentid`,`tradingday`,`updatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8



// 20150421
select instrumentid,count(*) from mktinfo 
where
OpenPrice > upperlimitprice or HighestPrice > upperlimitprice or LowestPrice > upperlimitprice or LastPrice > upperlimitprice or BidPrice1 > upperlimitprice or AskPrice1  > upperlimitprice 
and (
substr(updatetime,1,5) <= "02:30" or 
(substr(updatetime,1,5) >= "09:00" and substr(updatetime,1,5) <= "15:15") or 
substr(updatetime,1,5) >= "21:00" 
)
group by instrumentid

// COR:
越是小合约(持仓量),越是容易出现大量不正常数据,大合约也有,只不过出现概率较低. 
这究竟是数据本身(没有的就给e+308)还是数据传输的问题？？？
前者可能性很大，因为普遍发生于小合约

唯一例外是铁矿石主力i1509有近3000个数据坏点(似乎找到答案：4月13日刚移仓）

////////////////////////////////////////////////////////////20150422  transfered from 20150206 
(id,thread ,TradingDay,InstrumentID,LastPrice,PreSettlementPrice,PreClosePrice,PreOpenInterest,OpenPrice,HighestPrice,LowestPrice,Volume,Turnover,OpenInterest,ClosePrice,SettlementPrice,UpperLimitPrice,LowerLimitPrice,UpdateTime,UpdateMillisec,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice,seq_num)
seq_num, TradingDay, InstrumentID, UpdateTime, UpdateMillisec
主见 idx:
日志 id, thread
静态 instrumentid,tradingday
presettlementprice,preopeninterest,(precloseprice)

动态:
  UpdateTime,UpdateMillisec, seq_num
  PreSettlementPrice ,PreClosePrice ,PreOpenInterest 
  (ClosePrice,SettlementPrice)

  OpenPrice,HighestPrice,LowestPrice,LastPrice
  Volume ,Turnover ,OpenInterest 
  UpperLimitPrice,LowerLimitPrice

  BidPrice1 ,BidVolume1 ,AskPrice1 ,AskVolume1 ,AveragePrice 

// PRICEMAX=1000000
// select count(*) from mktinfo where upperlimitprice > 1000000 or upperlimitprice <= 0 or lowerlimitprice > 1000000 or lowerlimitprice <=0 
// valid price 
select count(*) from mktinfo where upperlimitprice > 1000000 or upperlimitprice < lowerlimitprice or lowerlimitprice <=0 
select count(*) from mktinfo where OpenPrice > upperlimitprice or HighestPrice > upperlimitprice or LowestPrice > upperlimitprice or LastPrice > upperlimitprice or BidPrice1 > upperlimitprice or AskPrice1  > upperlimitprice 
select count(*) from mktinfo where OpenPrice < lowerlimitprice or HighestPrice < lowerlimitprice or LowestPrice < lowerlimitprice or LastPrice < lowerlimitprice or BidPrice1 < lowerlimitprice or AskPrice1  < lowerlimitprice 
select count(*) from mktinfo where presettlementprice < 0 or presettlementprice > 1000000 or precloseprice < 0 or precloseprice > 1000000
// AveragePrice excluded
// VOLMAX=1000000000, real data can exceed 1000000, less 2m
// INCREASING VOLUME?>??????????
select count(*) from mktinfo where Volume<0 or Volume>1000000000 or BidVolume1<0 or BidVolume1>1000000000 or AskVolume1<0 or AskVolume1>1000000000
// turnovermax = 10000000000000 ,less 160 billion
// 20150422 IF.amount exceeds 2 trillion 
select count(*) from mktinfo where Turnover<0 or Turnover>10000000000000 
// openinterest 1000000 
select count(*) from mktinfo where OpenInterest<0 or OpenInterest>10000000
select count(*) from mktinfo where preopeninterest < 0 or preopeninterest > 10000000

// time validation
(
substr(updatetime,1,5) <= "02:30" or 
(substr(updatetime,1,5) >= "08:55" and substr(updatetime,1,5) <= "15:15") or 
substr(updatetime,1,5) >= "20:55" 
)

// time
//select updatetime || updatemillisec from mktinfo limit 1;
//select count(*) from mktinfo t1 join mktinfo t2 on t1.updatetime=t2.updatetime and t1.updatemillisec=t2.updatemillisec and t1.tradingday=t2.tradingday and t1.instrumentid=t2.instrumentid and t1.seq_num<t2.seq_num and ((t1.updatetime || t1.updatemillisec) 
//t1.seq_num=t2.seq_num and (
insert into temp.tmp(id,thread ,TradingDay,InstrumentID,LastPrice,PreSettlementPrice,PreClosePrice,PreOpenInterest,OpenPrice,HighestPrice,LowestPrice,Volume,Turnover,OpenInterest,ClosePrice,SettlementPrice,UpperLimitPrice,LowerLimitPrice,UpdateTime,UpdateMillisec,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice,seq_num) select * from mktinfo order by updatetime || updatemillisec ASC
select count(*) from mktinfo t1 join (slect * from mktinfo orderby seq_num ASC) t2 on 
((t1.updatetime || t1.updatemillisec) > (t2.updatetime || t2.updatemillisec))


///////////////////////////////// 20150423 oneminute 
