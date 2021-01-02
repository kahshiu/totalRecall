create database recall;

create table us (
  us_id int unsigned auto_increment,
  us_name varchar(100),
  us_ic varchar(20),
  us_email varchar(254), 
  us_contact1 varchar(10), 
  us_contact2 varchar(10), 
  address1 varchar(50),
  address2 varchar(50),
  postcode varchar(50),
  town_id int unsigned,
  state_id int unsigned,
  us_password varchar(128),

  rec_status smallint,
  constraint pk_us primary key (us_id)
);

create table co (
  co_id int unsigned auto_increment, 
  co_name varchar(100), 
  co_type smallint unsigned,
  co_subtype smallint unsigned,

  -- company attributes


  -- svc_accounting


  rec_status smallint,
  constraint pk_co primary key (co_id)
);

create table co_us (
  co_id int unsigned auto_increment,
  us_id int unsigned,
  rec_status smallint,
  constraint pk_co_us primary key (co_id, us_id)
);

create table svc_audit(
  svc_id int unsigned auto_increment,
  svc_co int unsigned,
  dt_start datetime,
  dt_end datetime,
  constraint pk_audit primary key (svc_id)
);
create table svc_tax(
  svc_id int unsigned auto_increment,
  svc_co int unsigned,
  dt_start datetime,
  dt_end datetime,
  constraint pk_tax primary key (svc_id)
);
create table svc_secretary(
  svc_id int unsigned auto_increment,
  svc_co int unsigned,
  dt_start datetime,
  dt_end datetime,
  constraint pk_sec primary key (svc_id)
);

-- measured from fiscal year
create table form_type (
  form_id int unsigned auto_increment,
  form_name varchar(20),
  mm smallint unsigned,
  yyyy smallint unsigned,

  dt_start datetime,
  dt_end datetime,
  rec_status smallint unsigned,
  constraint pk_deadline_def primary key (type_id)
);

create table svc_form (
  svc_type int unsigned,
  form_id int unsigned,
  constraint pk_svc_form primary key (svc_type, form_id)
);

create table deadline_co (
  co_id int unsigned,
  form_type int unsigned,

  dd smallint unsigned,
  mm smallint unsigned,
  svc_type smallint unsigned,  
  svc_type_id int unsigned, 

  rec_status smallint unsigned,
  constraint pk_deadline_co primary key (
    co_id, 
    form_type
  )
);

create table deadline_year (
  co_id int unsigned,
  form_type int unsigned,
  yyyy smallint unsigned,

  dt_start datetime,
  dt_end datetime,

  dt_deadline datetime,
  dt_completed datetime,
  us_completed int unsigned,

  rec_status smallint unsigned,
  constraint pk_deadline_year primary key (
    co_id, form_type, yyyy
  )
);

