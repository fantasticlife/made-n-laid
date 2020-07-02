drop table if exists instruments;

create table instruments (
	id serial,
	title varchar(10000) not null,
	procedure varchar(100) not null,
	laying_body varchar(10000) not null,
	date_made date not null,
	date_laid date not null,
	instrument_uri varchar(100) not null,
	work_package_uri varchar(100) not null,
	tna_uri varchar(200) not null,
	is_tweeted boolean default false,
	primary key (id)
);