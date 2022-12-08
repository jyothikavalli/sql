create table brands( bid number(5), bname varchar(20) );

alter table brands add primary key(bid); 

create table inv_user(
 user_id varchar(20),
 name varchar(20),
 password varchar(20),
 last_login timestamp,
 user_type varchar(10)
 );

create table categories(
 cid number(5),
 category_name varchar(20)
 );

 alter table categories add primary key(cid);

alter table inv_user add primary key(user_id);


create table product(
 pid number(5) primary key,
 cid number(5) references categories(cid),
 bid number(5) references brands(bid),
 sid number(5),
 pname varchar(20),
 p_stock number(5),
 price number(5),
 added_date date);

 create table stores(
 sid number(5),
 sname varchar(20),
 address varchar(20),
 mobno number(10)
 );

alter table stores add primary key(sid);

alter table product add foreign key(sid)references stores(sid);

create table provides(
 bid number(5)references brands(bid),
 sid number(5)references stores(sid),
 discount number(5));

 create table customer_cart(
 cust_id number(5) primary key,
 name varchar(20),
 mobno number(10)
 );

create table select_product(
 cust_id number(5) references customer_cart(cust_id),
 pid number(5)references product(pid),
 quantity number(4)
 );

create table transaction(
 id number(5) primary key,
 total_amount number(5),
 paid number(5),
 due number(5),
 gst number(3),
 discount number(5),
 payment_method varchar(10),
 cart_id number(5) references customer_cart(cust_id)
 );

 create table invoice(
 item_no number(5),
 product_name varchar(20),
 quantity number(5),
 net_price number(5),
 transaction_id number(5)references transaction(id)
 );

insert into brands values( '&bid' , '&bname');
insert into brands values(2,'Samsung');
insert into brands values(3,'Nike');
insert into brands values(4,'Fortune');
insert into inv_user values( '&user_id', '&name', '&password', '&last_login', '&user_type');
insert into inv_user values('harsh@gmail.com','Harsh Khanelwal','1111','30-oct18 10:20','Manager');
insert into inv_user values('prashant@gmail.com','Prashant','0011','29-oct-18 10:20','Accountant');

insert into categories values('&cid','&category_name');
insert into categories values(2,'Clothing');
insert into categories values(3,'Grocey');

insert into stores values('&sid', '&sname', '&address', '&mobno');
insert into stores values(2,'Rakesh kumar','chennai',8888555541);
insert into stores values(3,'Suraj','Haryana',7777555541);
insert into product values( '&pid', '&cid', '&bid', '&sid', '&pname', '&p_stock', '&price', '&added_date'); 
insert into product values(2,1,1,1,'Airpods',3,19000,'27-oct18'); 
insert into product values(5,3,4,3,'REFINED OIL',6,750,'25-oct-18'); 
insert into provides values(1,1,12);
insert into provides values(2,2,7);
insert into provides values(3,3,15);
insert into provides values(4,2,19);
insert into customer_cart values('&cust_id','&name', '&mobno');
insert into customer_cart values(2,'Shyam',7777777777);
insert into customer_cart values(3,'Mohan',7777777775);
insert into select_product values( '&cust_id', '&pid', '&quantity');
insert into select_product values(1,3,1);
insert into select_product values(2,3,3);
insert into select_product values(3,2,1);
insert into transaction values('&id', '&total_amount', '&paid', '&due', '&gst', '&discount', '&payment_method', '&cart_id');
insert into transaction values(2,57000,57000,0,570,570,'cash',2);
insert into transaction
values(3,19000,17000,2000,190,190,'cash',3);

--pl/sql function
declare
 due1 number(7);
 cart_id1 number(7);
 function get_cart(c_id number)return number is
 begin
 return (c_id);
 end;
 begin
 cart_id1:=get_cart('&c_id');
 select due into due1 from transaction where cart_id=cart_id1;
 dbms_output.put_line(due1);
 end;
/

--pl/sql cursor
DECLARE
 p_id product.pid%type;
 p_name product.pname%type;
 p_stock product.p_stock%type;
 cursor p_product is
 select pid,pname ,p_stock from product;
 begin
 open p_product;
 loop
 fetch p_product into p_id,p_name,p_stock;
 exit when p_product%notfound;
 dbms_output.put_line(p_id||' '||p_name||' '||p_stock);
 end loop;
 close p_product;
 end;
 /

 --procedure
 DECLARE
 a number;
 b number;
 PROCEDURE check_stock(x IN number) IS
 BEGIN
 IF x < 2 THEN
 dbms_output.put_line('Stock is Less');
 ELSE
 dbms_output.put_line('EnoughStock'); 10 END IF;
 END;
 BEGIN
 b:='&b';
 select p_stock into a from product where pid=b;
 check_stock(a);
 END;
/
