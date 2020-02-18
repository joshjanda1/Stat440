/*2*/

proc sql;
	/*a*/
	select *
	from sashelp.shoes
	where subsidiary = "Singapore";
	/*b*/
	select *
	from sashelp.shoes
	where subsidiary = "Singapore" AND
		  sales = (select max(sales) from sashelp.shoes
		  		   WHERE subsidiary = "Singapore");
	/*c*/
	select *
	from sashelp.shoes
	where subsidiary = "Singapore" AND
		  stores = (select max(stores) from sashelp.shoes
		  			WHERE subsidiary = "Singapore");
	/*d*/
	select sum(inventory) as SumInventory,
		   avg(inventory) as AvgInventory,
		   min(inventory) as MinInventory,
		   max(inventory) as MaxInventory,
		   subsidiary
	from sashelp.shoes
	where region = "Asia"
	group by subsidiary;
quit;
	/*e*/
proc sql outobs=1;
	select sum(inventory) as SumInventory,
		   avg(inventory) as AvgInventory,
		   min(inventory) as MinInventory,
		   max(inventory) as MaxInventory,
		   subsidiary
	from sashelp.shoes
	where region = "Asia"
	group by subsidiary
	order by calculated SumInventory desc;
	/*f*/
	select sum(inventory) as SumInventory,
		   avg(inventory) as AvgInventory,
		   min(inventory) as MinInventory,
		   max(inventory) as MaxInventory,
		   subsidiary
	from sashelp.shoes
	where region = "Asia"
	group by subsidiary
	order by calculated SumInventory asc;
	
	proc sql;
	select max(sumInventory)
	from
		(select sum(inventory) as sumInventory
		 from sashelp.shoes
		 where region = "Asia"
		 group by subsidiary);
	select *
	from
		(select sum(inventory) as sumInventory,
			    subsidiary
		 from sashelp.shoes
		 where region = "Asia"
		 group by subsidiary)
	where sumInventory = (select min(sumInventory) from
						  (select sum(inventory) as sumInventory,
							    subsidiary
						  from sashelp.shoes
						  where region = "Asia"
						  group by subsidiary));
	
	
quit;
	