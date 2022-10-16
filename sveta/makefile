NAME=sveta_db
PORT=5432
USER=postgres
PASS=postgres
BASE=sveta_dev
DATA=`pwd`/data/postgres

main:
	livebook server ./main.livemd
api:
	mix phx.server
database:
	docker run --name ${NAME}  \
		-p ${PORT}:5432 \
		-e POSTGRES_USER=${USER} \
		-e POSTGRES_PASSWORD=${PASS} \
		-e POSTGRES_DB=${BASE} \
		-v ${DATA}:/var/lib/postgresql/data \
		-it --rm postgres
tunnel:
	npx ngrok http 4000
