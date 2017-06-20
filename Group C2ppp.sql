CREATE OR REPLACE FUNCTION AMOUNTORDER
return number is
  totalorder number (3) := 0;
BEGIN
  SELECT COUNT(*) into totalorder from SORDERLINE;
  return totalorder;
END;
/

CREATE OR REPLACE PROCEDURE ADDORDER(MCODE IN MENU.MENU_CODE%TYPE,MCOST IN MENU.COST%TYPE)
IS
BEGIN
  UPDATE MENU SET COST = MCOST WHERE MENU_CODE = MCODE;
END;

/

set serveroutput on;

DECLARE
  c number(3);
  menu_code number(2);
  item_cost float(5);
BEGIN 
  menu_code := &Item_Number;
  item_cost := &Item_New_Cost;
  c:=amountorder();
  DBMS_OUTPUT.PUT_LINE('Total number of Orders Currently :' || c);
  ADDORDER(menu_code,item_cost);
    EXCEPTION
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE('Error');
END;

/
SELECT COST FROM MENU;
/
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (1,'Full Irish Breakfast',4.50);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (2,'Pancakes',2.00);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (3,'Sushi',10.00);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (4,'Kebab',5.00);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (5,'Falafal',3.50);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (6,'Pasta',7.50);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (7,'Steak',8.00);
--insert into MENU (MENU_CODE,DESCRIPTION,COST) VALUES (8,'Filet of Cod',8.00);


--insert into SORDER (ORDERNO,STUDENTNO,ORDER_DATE,TIME) VALUES (1,1234565,'29-JUN-04','12:53');
--insert into SORDER (ORDERNO,STUDENTNO,ORDER_DATE,TIME) VALUES (2,1122456,'29-JUN-04','12:57');
--insert into SORDER (ORDERNO,STUDENTNO,ORDER_DATE,TIME) VALUES (3,1322146,'28-MAR-04','13:30');
--insert into SORDER (ORDERNO,STUDENTNO,ORDER_DATE,TIME) VALUES (4,1231232,'12-DEC-04','15:30');
--insert into SORDER (ORDERNO,STUDENTNO,ORDER_DATE,TIME) VALUES (5,1696918,'29-SEP-04','12:30');
--insert into SORDER (ORDERNO,STUDENTNO,ORDER_DATE,TIME) VALUES (6,1889812,'29-JAN-04','9:00');

--select SId,SERIAL#,STATUS from V$SESSION;


--insert into SORDERLINE (ORDERNO,MENU_CODE,QUANTITY) VALUES (1,2,3);
--insert into SORDERLINE (ORDERNO,MENU_CODE,QUANTITY) VALUES (2,1,2);
--insert into SORDERLINE (ORDERNO,MENU_CODE,QUANTITY) VALUES (3,5,3);
--insert into SORDERLINE (ORDERNO,MENU_CODE,QUANTITY) VALUES (4,1,1);
--insert into SORDERLINE (ORDERNO,MENU_CODE,QUANTITY) VALUES (5,6,2);
--insert into SORDERLINE (ORDERNO,MENU_CODE,QUANTITY) VALUES (6,4,1);

SELECT * FROM SORDERLINE;
SELECT * FROM SORDER;
select * from menu;
select * from STUDENT;

/*
  intersection
  Diffrence
  union
  inner join
  outerJoin
  Aggregation
  Subquerie
*/


select * from MENU WHERE COST IN (SELECT COST FROM MENU WHERE COST > 5.0 );

select STUDENTNO,count(*) from SORDER group by STUDENTNO;

select STUDENTNAME,COURSEYEAR from STUDENT
FULL OUTER JOIN SORDER
ON STUDENT.STUDENTNO = SORDER.STUDENTNO;

select DESCRIPTION from MENU 
INNER JOIN SORDERLINE
ON MENU.MENU_CODE = SORDERLINE.MENU_CODE;

select studentno from sorder where OrderNo = 1
union
select studentno from records;

select studentno from student
minus
select studentno from sorder;

select studentno from student
intersect
select studentno from sorder;

SELECT * FROM SORDERLINE;

commit;


