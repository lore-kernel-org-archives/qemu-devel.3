Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9C5CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcr9H-0006F2-E9; Thu, 25 Jun 2026 16:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcr9G-0006En-4l
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcr9E-0006Kh-Ba
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782421087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwKoPcR35kbNduIVnK3Sf7vnoc0Sxur6DzZB1wsSaf4=;
 b=MDNFoUg1pKdMWhbvBhgzPXtZ9wNQSRbiJrsZs2MW1hmrT+jyFlNUyIi4Tnimo5WwYzsWme
 +uvZOqbGCeS/c1zyBreSQy8kZ7bZjVH5z7t6Lpyz3plQlP2SXZxfMxhWNapenmA+dy6XFA
 mLo1E3NOKmNIpM6mBzzmhhdn88Y7mkU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-h1N7bPrWN4K3qSddpW60wQ-1; Thu,
 25 Jun 2026 16:58:05 -0400
X-MC-Unique: h1N7bPrWN4K3qSddpW60wQ-1
X-Mimecast-MFC-AGG-ID: h1N7bPrWN4K3qSddpW60wQ_1782421084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A96391806CA2; Thu, 25 Jun 2026 20:58:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.255])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4337B195608D; Thu, 25 Jun 2026 20:58:04 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:58:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/76] hex queue
Message-ID: <20260625205803.GA267975@fedora>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OAp5ZFWGSRCswb6M"
Content-Disposition: inline
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--OAp5ZFWGSRCswb6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 07:15:17AM -0700, Brian Cain wrote:
> The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5=
fb:
>=20
>   Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qe=
mu into staging (2026-06-19 15:00:01 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/qualcomm/qemu tags/pull-hex-20260625
>=20
> for you to fetch changes up to 0281aa50c4792fd091e00051031aa927ea0790ea:
>=20
>   tests/qtest: Add hexagon boot-serial-test (2026-06-24 22:18:47 -0700)
>=20
> ----------------------------------------------------------------
> hex queue sysemu v3
>=20
> w/`tests/docker: add flex and bison to emsdk-wasm64-cross`, now passes:
>=20
>     Program flex found: YES (/usr/bin/flex)
>     Program bison found: YES 3.8.2 (/usr/bin/bison)
>     ...
>     Build-time dependency glib-2.0 found: YES 2.72.4
>     ...
>     Build targets in project: 527
>     ...
>     [1421/1421] Linking target qemu-system-hexagon.js

There is another wasm-related hexagon failure:

https://gitlab.com/qemu-project/qemu/-/jobs/15042103056#L9777

Note that I also applied 20260625193320.260312-1-stefanha@redhat.com to
solve a zlib.net tarball 404 error that breaks the emsdk-wasm64-cross
image. The mailing list is slow right now, so just in case you don't
have that email, here is a copy of it:

=46rom: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] tests/docker: bump emsdk-wasm64-cross zlib version to 1.3.2
Date: Thu, 25 Jun 2026 15:33:20 -0400
Message-ID: <20260625193320.260312-1-stefanha@redhat.com>

Container image builds have started failing because zlib.net no longer
hosts the 1.3.1 tarball. Move to the 1.3.2 release from February 17,
2026.

  $ make docker-image-emsdk-wasm64-cross
  changing dir to build for make "docker-image-emsdk-wasm64-cross"...
  make[1]: Entering directory 'qemu/build'
    BUILD   emsdk-wasm64-cross
  ...
  xz: (stdin): File format not recognized
  tar: Child returned status 1
  tar: Error is not recoverable: exiting now
  Error: building at STEP "RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION=
=2Etar.xz |     tar xJC /zlib --strip-components=3D1": while running runtim=
e: exit status 2
  make[1]: *** [qemu/tests/docker/Makefile.include:43: docker-image-emsdk-w=
asm64-cross] Error 2
  make[1]: Leaving directory 'qemu/build'
  make: *** [GNUmakefile:6: build] Error 2

Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/doc=
ker/dockerfiles/emsdk-wasm64-cross.docker
index 8a924816f92..cbe20c7193e 100644
--- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
@@ -1,7 +1,7 @@
 # syntax =3D docker/dockerfile:1.5

 ARG EMSDK_VERSION_QEMU=3D4.0.10
-ARG ZLIB_VERSION=3D1.3.1
+ARG ZLIB_VERSION=3D1.3.2
 ARG GLIB_MINOR_VERSION=3D2.84
 ARG GLIB_VERSION=3D${GLIB_MINOR_VERSION}.0
 ARG PIXMAN_VERSION=3D0.44.2
--
2.54.0

--OAp5ZFWGSRCswb6M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo9llsACgkQnKSrs4Gr
c8jG1gf/UIQ79dAIHKIAPti2UZuw8+jEvQs/IJzSrh6oWe+bj8AuTsGRqsmOejKb
PZIv67y1w0Pm/YxP+JFZs/vUhYdGHWUobnohMTV5A1kpPraZM8C4sARp673k4Gvn
mIg7j7KtlFdFUMerKkDHmqurNkqqZr4cld8w1CuXOOdiR6GL6e2ZImd9VlTbjIpn
to5KitxhIwI0phie03RGJ4GqSBQ/Yvs2KBO+/uy4J+OGpH1WbifRGEwq4/NGWJXg
OIQ5asKykelKZRLnWgQ0r1VhKaPyq1vcEcaWIqnD4G64xtVAjQVy5fjazTdnJ7J8
2reqLW9dwOHTGpIQHLwebSCtR/0wEQ==
=iQTk
-----END PGP SIGNATURE-----

--OAp5ZFWGSRCswb6M--


