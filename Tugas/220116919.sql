system/orcl

drop user tprakbd2 cascade;
create user tprakbd2 identified by 2;
grant connect, resource to tprakbd2;

conn tprakbd2/2

SELECT 'DROP TABLE ' || TNAME || ' CASCADE CONSTRAINT PURGE;' FROM TAB;

drop table owner cascade constraint purge;
drop table company cascade constraint purge;
drop table office cascade constraint purge;
drop table employee cascade constraint purge;
drop table brand_ambassador cascade constraint purge;
drop table event cascade constraint purge;
drop table sponsorship cascade constraint purge;
drop table users cascade constraint purge;
drop table voucher cascade constraint purge;
drop table courier cascade constraint purge;
drop table product cascade constraint purge;
drop table category cascade constraint purge;
drop table supplier cascade constraint purge;
drop table cart cascade constraint purge;
drop table invoice cascade constraint purge;
drop table sponsory cascade constraint purge;
drop table manage cascade constraint purge;
drop table chat cascade constraint purge;
drop table follow cascade constraint purge;
drop table rate cascade constraint purge;
drop table sell cascade constraint purge;
drop table have_productcategory cascade constraint purge;
drop table provide cascade constraint purge;
drop table have_uservoucher cascade constraint purge;
drop table add_cart cascade constraint purge;
drop table use_cartvoucher cascade constraint purge;
drop table checkout cascade constraint purge;
drop table pay cascade constraint purge;
drop table get cascade constraint purge;
drop table send cascade constraint purge;

create table owner(
    own_id varchar2(5) constraint pk_own primary key,
    own_name varchar2(20) constraint nn_own_name not null,
    own_sex varchar2(1) constraint ch_own_sex check(own_sex in ('L', 'P')),
    own_title varchar2(20),
    own_birthplacedate varchar2(20),
    own_nationality varchar2(20),
    own_maritalstatus varchar2(8) constraint ch_own_maritalstatus check(own_maritalstatus in ('Married', 'Single', 'Divorced', 'Widowed')),
    own_phone varchar2(20) constraint un_own_phone unique,
    own_email varchar2(20) constraint un_own_email unique
);

create table company(
    cp_id varchar2(5) constraint pk_cp primary key,
    own_id varchar2(5) constraint fk_cp_own references owner(own_id),
    cp_name varchar2(6) constraint nn_cp_name not null,
    cp_caddress varchar2(20) constraint un_cp_centraladdress unique,
    cp_website varchar2(20) constraint un_cp_website unique,
    cp_datefound date,
    cp_region varchar2(20),
    cp_phone varchar2(20),
    cp_email varchar2(20),
    cp_fax varchar2(20)
);

create table office(
    of_id varchar2(5) constraint pk_of primary key,
    cp_id varchar2(5) constraint fk_of_cp references company(cp_id),
    of_address varchar2(20),
    of_phone varchar2(20),
    of_email varchar2(20),
    of_fax varchar2(20)
);

create table employee(
    emp_id varchar2(5) constraint pk_emp primary key,
    of_id varchar2(5) constraint fk_emp_of references office(of_id),
    emp_name varchar2(20) constraint nn_emp_name not null,
    emp_sex varchar2(1) constraint ch_emp_sex check(emp_sex in ('L', 'P')),
    emp_maritalstatus varchar2(8) constraint ch_emp_maritalstatus check(emp_maritalstatus in ('Married', 'Single', 'Divorced', 'Widowed')),
    emp_birthplacedate varchar2(20),
    emp_nationality varchar2(20),
    emp_address varchar2(20),
    emp_title varchar2(20),
    emp_salary number(9),
    emp_hiredate date,
    emp_phone varchar2(20),
    emp_email varchar2(20)
);

create table brand_ambassador(
    ba_id varchar2(5) constraint pk_ba primary key,
    cp_id varchar2(5) constraint fk_ba_cp references company(cp_id),
    ba_name varchar2(20) constraint nn_ba_name not null,
    ba_sex varchar2(1) constraint ch_ba_sex check(ba_sex in ('L', 'P')),
    ba_birthplacedate varchar2(20),
    ba_region varchar2(20),
    ba_salary number(9),
    ba_contractdate date,
    ba_phone varchar2(20),
    ba_email varchar2(20)
);

create table event(
    ev_id varchar2(5) constraint pk_ev primary key,
    cp_id varchar2(5) constraint fk_ev_cp references company(cp_id),
    ev_name varchar2(20) constraint nn_ev_name not null,
    ev_desc varchar2(20),
    ev_place varchar2(20),
    ev_date date,
    ev_agenda varchar2(20),
    ev_benefit varchar2(20)
);

create table sponsorship(
    sp_id varchar2(5) constraint pk_sp primary key,
    sp_name varchar2(20) constraint nn_sp_name not null,
    sp_company varchar2(20),
    sp_phone varchar2(20),
    sp_email varchar2(20),
    sp_fax varchar2(20)
);

create table users(
    us_id varchar2(5) constraint pk_us primary key,
    cp_id varchar2(5) constraint fk_us_cp references company(cp_id),
    us_username varchar2(20) constraint nn_us_username not null,
    us_pass varchar2(20) constraint nn_us_pass not null,
    us_datecreated date,
    us_name varchar2(20),
    us_sex varchar2(1) constraint ch_us_sex check(us_sex in ('L', 'P')),
    us_birthplacedate varchar2(20),
    us_lastonline timestamp,
    us_address varchar2(20),
    us_following number(9),
    us_follower number(9),
    us_phone varchar2(20),
    us_email varchar2(20),
    us_creditcard varchar2(20),
    us_rating number(3,2)
);

create table voucher(
    vc_id varchar2(5) constraint pk_vc primary key,
    cp_id varchar2(5) constraint fk_vc_cp references company(cp_id),
    vc_name varchar2(20),
    vc_discount number(2),
    vc_tnc varchar2(20)
);

create table courier(
    cr_id varchar2(5) constraint pk_cr primary key,
    cp_id varchar2(5) constraint fk_cr_cp references company(cp_id),
    cr_number varchar2(20),
    cr_estimatedtime timestamp,
    cr_phone varchar2(20),
    cr_email varchar2(20)
);

create table product(
    pd_id varchar2(5) constraint pk_pd primary key,
    pd_number varchar2(20),
    pd_picture varchar2(20),
    pd_name varchar2(20),
    pd_desc varchar2(20),
    pd_stock number(5),
    pd_price number(7),
    pd_size varchar2(3) constraint ch_pd_size check(pd_size in('XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL')),
    pd_color varchar2(20),
    pd_weight number(4,2),
    pd_discount number(2)
);

create table category(
    cg_id varchar2(5) constraint pk_cg primary key,
    cg_icon varchar2(20),
    cg_name varchar2(20),
    cg_desc varchar2(20)
);

create table supplier(
    sup_id varchar2(5) constraint pk_sup primary key,
    sup_name varchar2(20),
    sup_company varchar2(20),
    sup_address varchar2(20),
    sup_phone varchar2(20),
    sup_email varchar2(20),
    sup_fax varchar2(20)
);

create table cart(
    ct_id varchar2(5) constraint pk_ct primary key,
    ct_number varchar2(20),
    ct_expdate date,
    ct_price varchar2(9),
    ct_discount varchar2(2)
);

create table invoice(
    iv_id varchar2(5) constraint pk_invoice primary key,
    iv_number varchar2(20),
    iv_datecreated date,
    iv_totalprice varchar2(9),
    us_id varchar2(5) constraint fk_iv_us references users(us_id),
    ct_id varchar2(5) constraint fk_iv_ct references cart(ct_id)
);

create table sponsory(
    ev_id varchar2(5) constraint fk_sponsory_ev references event(ev_id),
    sp_id varchar2(5) constraint fk_sponsory_sp references sponsorship(sp_id),
    contractdate date,
    constraint pk_sponsory primary key (ev_id,sp_id)
);

create table manage(
    emp_id varchar2(5) constraint fk_manage_emp references employee(emp_id),
    emp1_id varchar2(5) constraint fk1_manage_emp references employee(emp_id),
    constraint pk_manage primary key (emp_id, emp1_id)
);

create table chat(
    us_id varchar2(5) constraint fk_chat_us references users(us_id),
    us1_id varchar2(5) constraint fk1_chat_us references users(us_id),
    constraint pk_chat primary key (us_id, us1_id)
);

create table follow(
    us_id varchar2(5) constraint fk_follow_us references users(us_id),
    us1_id varchar2(5) constraint fk1_follow_us references users(us_id),
    constraint pk_follow primary key (us_id, us1_id)
);

create table rate(
    us_id varchar2(5) constraint fk_rate_us references users(us_id),
    us1_id varchar2(5) constraint fk1_rate_us references users(us_id),
    constraint pk_rate primary key (us_id, us1_id)
);

create table sell(
    us_id varchar2(5) constraint fk_sell_us references users(us_id),
    pd_id varchar2(5) constraint fk_sell_pd references product(pd_id),
    constraint pk_sell primary key (us_id, pd_id)
);

create table have_productcategory(
    pd_id varchar2(5) constraint fk_hpc_pd references product(pd_id),
    cg_id varchar2(5) constraint fk_hpc_cg references category(cg_id),
    constraint pk_hpc primary key (pd_id, cg_id)
);

create table provide(
    pd_id varchar2(5) constraint fk_provide_pd references product(pd_id),
    sup_id varchar2(5) constraint fk_provide_sup references supplier(sup_id),
    constraint pk_provide primary key (pd_id, sup_id)
);

create table have_uservoucher(
    us_id varchar2(5) constraint fk_huv_us references users(us_id),
    vc_id varchar2(5) constraint fk_huv_vc references voucher(vc_id),
    expdate date,
    constraint pk_huv primary key (us_id, vc_id)
);

create table add_cart(
    us_id varchar2(5) constraint fk_add_us references users(us_id),
    pd_id varchar2(5) constraint fk_add_pd references product(pd_id),
    ct_id varchar2(5) constraint fk_add_ct references cart(ct_id),
    constraint pk_add primary key (us_id, pd_id, ct_id)
);

create table use_cartvoucher(
    ct_id varchar2(5) constraint fk_ucv_ct references cart(ct_id),
    vc_id varchar2(5) constraint fk_ucv_vc references voucher(vc_id),
    constraint pk_ucv primary key (ct_id, vc_id)
);

create table checkout(
    cout_id varchar2(5) constraint pk_cout primary key,
    cout_date date,
    cout_number varchar2(20),
    cout_paymentmethod varchar2(20),
    ct_id varchar2(5) constraint fk_cout_ct references cart(ct_id),
    cp_id varchar2(5) constraint fk_cout_cp references company(cp_id)
);

create table pay(
    cp_id varchar2(5) constraint fk_pay_cp references company(cp_id),
    us_id varchar2(5) constraint fk_pay_us references users(us_id),
    constraint pk_pay primary key (cp_id, us_id)
);

create table get(
    cr_id varchar2(5) constraint fk_get_cr references courier(cr_id),
    pd_id varchar2(5) constraint fk_get_pd references product(pd_id),
    constraint pk_get primary key (cr_id, pd_id)
);

create table send(
    cr_id varchar2(5) constraint fk_send_cr references courier(cr_id),
    us_id varchar2(5) constraint fk_send_us references users(us_id),
    constraint pk_send primary key (cr_id, us_id)
);

alter table employee add emp_shoes_size varchar2(3);
alter table employee add emp_clothes_size varchar2(3);

alter table employee drop column emp_shoes_size;
alter table employee drop column emp_clothes_size;