POC for PostgreSQL database running in docker
<br>
<br>
Uses Docker host volume mapping in : /home/mika/DOCKERDATA

Uses Docker backups mapping: /DOCKERBACKUPS
<br>
<br>

Start Postgres in docker:

docker-compose up

--------------------------------------------------

Create db content from host:

sudo docker exec -i testipossu psql -U mika -d cars < ./create_db.sql

---------------------------------------------------

Adminer, UI for db management: http://localhost:8100

----------------------------------------------------

Take timestampped db backup:
./backup.sh

----------------------------------------------------

Return backup:
./returnbackup.sh

----------------------------------------------------

Open SQL shell into Docker:
sudo docker exec -it -u postgres testipossu psql -U mika -d cars


------------------------------------------
QT directory includes small Qt(5.15) app to "access" database (showing SELECT * FROM cars;)

Qt Postgres may require driver installation:

sudo apt-get install libqt5sql5-psql libpq-dev
