system/orcl

spool "D:\220116919_spool.sql";
set time on;
set sqlprompt "220116919 >";

drop user prakbd2 cascade;
create user prakbd2 identified by 2;
grant connect, resource to prakbd2;

conn prakbd2/2

create table guru(
    id_guru varchar2(5) constraint pk_guru primary key,
    nama varchar2(50) constraint nn_nama not null,
    alamat varchar2(50) constraint nn_alamat not null,
    telepon varchar2(15) constraint nn_telepon not null
);

create table kelas(
    id_kelas varchar2(5) constraint pk_kelas primary key,
    nama_kelas varchar2(10) constraint nn1_kelas not null,
    jenjang varchar2(1) constraint chk_kelas check (jenjang = 1 or jenjang = 2 or jenjang = 3),
    id_guru varchar2(5),
    constraint fk_guru foreign key (id_guru) references guru(id_guru)
);

create table mata_pelajaran(
    id varchar2(5) constraint pk_mapel primary key,
    nama varchar2(20) constraint nn1_mapel not null,
    semester varchar2(1) constraint chk_mapel check (semester = 1 or semester = 2 or semester = 3 or semester = 4 or semester = 5 or semester = 6 or semester = 7 or semester = 8)
);

create table waktu(
    id_waktu varchar2(5) constraint pk_waktu primary key,
    hari varchar2(10) constraint chk_hari check(hari = 'SENIN' or hari = 'SELASA' or hari = 'RABU' or hari = 'KAMIS' or hari = 'JUMAT'),
    waktu_mulai timestamp,
    waktu_selesai timestamp
);

create table jadwal(
    id varchar2(5) constraint pk_jadwal primary key,
    id_waktu varchar2(5),
    id_mapel varchar2(5),
    id_guru varchar2(5),
    id_kelas varchar2(5),
    constraint fk1_jadwal foreign key (id_waktu) references waktu(id_waktu),
    constraint fk2_jadwal foreign key (id) references mata_pelajaran(id),
    constraint fk3_jadwal foreign key (id_guru) references guru(id_guru),
    constraint fk4_jadwal foreign key (id_kelas) references kelas(id_kelas)
);

/*2*/
alter table kelas modify nama_kelas varchar2(30);

/*3*/
alter table kelas rename column nama_kelas to nama;

/*4*/
alter table waktu drop constraint chk_hari;
alter table waktu add constraint chk_hari check(hari = 'MONDAY' or hari = 'TUESDAY' or hari = 'WEDNESDAY' or hari = 'THURSDAY' or hari = 'FRIDAY');

/*5*/
alter table jadwal add periode varchar2(5) constraint nn_periode not null;

/*6*/
alter table guru drop column telepon;

drop table jadwal;
drop table waktu;

spool off;