/* `diff` is a new table  */

create temporary table tmp1 (id INT,instrumentid TEXT,id1 INT,instrumentid1 TEXT,openint INT,openint1 INT,diff INT, primary key (id));

insert into tmp1 (id,instrumentid,openint) 
select id,instrumentid,openint from ticks;

insert or replace into tmp1 
(id,instrumentid,openint,id1,instrumentid1,openint1) 
select 
m.id,m.instrumentid,m.openint,t.id,t.instrumentid,t.openint 
from ticks t, tmp1 m 
where t.id == m.id + 1 ;

update tmp1
set diff = openint1 - openint;

create table diff (id INT,instrumentid TEXT,id1 INT,instrumentid1 TEXT, diff INT, primary key (id));

insert into diff
select id,instrumentid,id1,instrumentid1,diff from tmp1;

select * from ticks t join diff d on t.id=d.id 
where t.volume == abs(d.diff) limit 5;


