# Created by: Alexander Pereira Girald <alexander.girald@icloud.com>

PORTNAME=	temporal-cli
DISTVERSION=	0.14.0
CATEGORIES=	devel

MAINTAINER=	alexander.girald@icloud.com
COMMENT=	Command-line interface for Temporal workflow engine
WWW=		https://github.com/temporalio/cli

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		go:1.21,modules
USE_GITHUB=	yes
GH_ACCOUNT=	temporalio
GH_PROJECT=	cli
GH_TAGNAME=	v${DISTVERSION}

GO_MODULE=	github.com/temporalio/cli
GO_BUILDFLAGS=	-ldflags "-s -w -X github.com/temporalio/cli/internal/temporalcli.Version=${DISTVERSION}"
GO_TARGET=	./cmd/temporal

PLIST_FILES=	bin/temporal

PORTDOCS=	README.md

OPTIONS_DEFINE=	DOCS

DOCS_PLIST_FILES=	%%DOCSDIR%%/README.md

do-build:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${GO_CMD} generate ./...
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${GO_CMD} build ${GO_BUILDFLAGS} -o ${GO_WRKDIR_BIN}/temporal ./cmd/temporal

do-install:
	${INSTALL_PROGRAM} ${GO_WRKDIR_BIN}/temporal ${STAGEDIR}${PREFIX}/bin/temporal

do-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/README.md ${STAGEDIR}${DOCSDIR}/README.md

.include <bsd.port.mk>