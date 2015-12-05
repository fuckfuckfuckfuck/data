#!/usr/bin/env python

import datetime as dtime
import re

date1 = str(20151028)
date2 = str(20151030)


tmp = dtime.date.today()
num = tmp.year*10000 + tmp.month*100 + tmp.day
d1 = re.compile('@date1')
d2 = re.compile('@date2')


try:
    fstr = open("/home/dell/data/jzt/day.sql",'r')
    lines = fstr.readlines()
finally:
    fstr.close()

if lines is not None:
    fstr1 = open(str(num) + '.sql','w')
    for line in lines:
        tmp_str = d1.sub(date1, line)
        tmp_str = d2.sub(date2, tmp_str)
        fstr1.write(tmp_str)

    fstr1.close()

