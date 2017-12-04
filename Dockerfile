FROM amazonlinux:latest
MAINTAINER hoanglt705@gmail.com
# install latest pinit framework
ARG PINIT_URL=http://jenkins-hrbc.ps.porters.local/job/PInit_Build_Binaries/lastSuccessfulBuild/artifact/build/pinit.tgz
RUN set -ex \
	&& curl -fL $PINIT_URL -o /pinit.tgz \
	&& mkdir -p /etc/pinit \
	&& chmod +x /etc/pinit \
	&& tar -zxf /pinit.tgz -C /etc/pinit --strip-components=1 \
	&& rm /pinit.tgz \
;
# entry point and startup logic
COPY pinit /etc/pinit
COPY yum.repo.d /etc/yum.repos.d
VOLUME /logs   
# default entrypoint is bash. use the CMD to override in extending dockerfile
ENTRYPOINT ["/etc/pinit/entrypoint.sh"]
CMD ["default"]
