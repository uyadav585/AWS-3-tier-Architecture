#!/bin/sh

sudo apt-get update
wget --user=kumang163@gmail.com --password=cmVmdGtuOjAxOjE3NTQyOTc5NTI6cWtCRXJMdjVrT0hrT3FZUGtBMks5MWxtelo4 https://threetierloginapp1.jfrog.io/artifactory/threetier-libs-release-local/com/devopsrealtime/dptweb/0.0.1/dptweb-0.0.1.war
sudo systemctl stop tomcat
sudo cp dptweb-0.0.1.war /opt/tomcat/webapps/
sudo systemctl start tomcat
sudo apt install -y mysql-client
# Create a SQL file with the database and table creation commands
echo "CREATE DATABASE UserDB;" > /tmp/create_db.sql
echo "USE UserDB;" >> /tmp/create_db.sql
echo "CREATE TABLE Employee (
  id int unsigned auto_increment not null,
  first_name varchar(250),
  last_name varchar(250),
  email varchar(250),
  username varchar(250),
  password varchar(250),
  regdate timestamp,
  primary key (id)
);" >> /tmp/create_db.sql

# Run the SQL commands on the RDS instance

mysql -u admin -ppass12345 -h database-2.cbmcm6ga4dhp.us-east-1.rds.amazonaws.com < /tmp/create_db.sql