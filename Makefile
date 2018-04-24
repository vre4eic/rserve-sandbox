DOPTS=--net=none --detach --name=kbswish_rserve
LOPTS=--limit-data=20000000 --limit-time=86400 --limit-file=10000000
VOL=-v /home/rserve:/rserve

all::
	@echo "Targets:"
	@echo
	@echo "  image		Build the docker image"
	@echo "  run		Run the image one time"
	@echo "  install	Run the image with --restart=unless-stopped"

image:	Dockerfile
	docker build -t rserve .

run:
	docker run $(DOPTS) $(VOL) rserve $(LOPTS)

install:
	docker run $(DOPTS) --restart=unless-stopped $(VOL) rserve $(LOPTS)
