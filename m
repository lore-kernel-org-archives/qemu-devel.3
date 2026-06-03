Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81673CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUomq-0002nh-Cn; Wed, 03 Jun 2026 12:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUomo-0002nX-Te
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUomm-00063O-IC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780505382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQxJ3htaf+k/umX3d4p14iyCWWfogZpY0vto7OittVg=;
 b=IjyDond0Teg91y1wbWZvs800n3amHuxorRIp+4QIdKJEjiAxpyiqRIDT4DRuS8TiAiIxK+
 0234v3wcMIaiIMMX+m8xKGgGoKIhU5kpgDart8X/mq8QuCXBkQ5tbe8eZZqMQdPv4LL7V6
 kdlVZEdw96ExgbTtHcEODmOhIknHnbo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-0SxucynNPHu9UPOPUYGADA-1; Wed,
 03 Jun 2026 12:49:40 -0400
X-MC-Unique: 0SxucynNPHu9UPOPUYGADA-1
X-Mimecast-MFC-AGG-ID: 0SxucynNPHu9UPOPUYGADA_1780505379
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1450719560BB; Wed,  3 Jun 2026 16:49:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62D9227A; Wed,  3 Jun 2026 16:49:38 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:49:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 0/3] gitlab: remove x64-freebsd-14-build job and Cirrus
 CI integration
Message-ID: <20260603164936.GC59214@fedora>
References: <20260602162457.828969-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AUZtDs/ab0nueIph"
Content-Disposition: inline
In-Reply-To: <20260602162457.828969-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--AUZtDs/ab0nueIph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 12:24:53PM -0400, Stefan Hajnoczi wrote:
> Cirrus CI shut down yesterday and the x64-freebsd-14-build CI job is now
> failing. This patch series removes the job as well as the Cirrus CI integ=
ration
> in lcitool.
>=20
> Warner is setting up a gitlab-runner on a VM hosted by OSUOSL for QEMU. I=
t will
> be possible to test FreeBSD builds again when it comes online.
>=20
> Stefan Hajnoczi (3):
>   gitlab: remove x64-freebsd-14-build Cirrus job
>   lcitool: remove Cirrus CI support
>   MAINTAINERS: remove stale Cirrus macOS build job path
>=20
>  MAINTAINERS                         |  3 --
>  .gitlab-ci.d/cirrus/README.rst      | 54 -----------------------------
>  docs/devel/testing/main.rst         |  4 +--
>  .gitlab-ci.d/base.yml               |  4 ---
>  .gitlab-ci.d/cirrus.yml             | 46 ------------------------
>  .gitlab-ci.d/cirrus/build.yml       | 42 ----------------------
>  .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ---------
>  .gitlab-ci.d/qemu-project.yml       |  1 -
>  docs/devel/testing/ci-jobs.rst.inc  |  6 ----
>  tests/lcitool/refresh               | 11 ------
>  10 files changed, 2 insertions(+), 185 deletions(-)
>  delete mode 100644 .gitlab-ci.d/cirrus/README.rst
>  delete mode 100644 .gitlab-ci.d/cirrus.yml
>  delete mode 100644 .gitlab-ci.d/cirrus/build.yml
>  delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars
>=20
> --=20
> 2.54.0
>=20

Alex and Pierrick gave their R-b, so I guess this is not going through
their trees.

Applied to the staging tree to make CI green again but without the final
MAINTAINERS patch (Markus has a patch that obsoletes mine):
https://gitlab.com/qemu-project/qemu/commits/staging

Stefan

--AUZtDs/ab0nueIph
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmogWyAACgkQnKSrs4Gr
c8gEGgf/URhpjuO1FX5pwInsrg9dMSZ6RIHtmdrAIwMWfthZFSkAWmyYaq56ZsEX
IrjnETOGHoUvtQrx6CsIeOM4pRJte2FSjsQfBqBRA/tphqK4wN411kDuZtZrpAeb
Vop6+PLSEVQCXof9cqDp75hTP9dv/Mfh2p3ZGcvZTH65m9+m2s1Nhys8QQfQ5zFf
xn4wT7yVHoO21Et7qBNMxgLQ9wjNs1BEw4YzrO1+Lu4sTBUCA7DWKx2VV5ALXt97
18kLF0ExeMRPkuGQ1/QtWNQWd1RO6JqjTLicPp/cE6od5v2GUlgPyGcZMSoUcalG
tzbQeUnVKWOqIwXVOA2QQ2fFEQRr7w==
=ul5Z
-----END PGP SIGNATURE-----

--AUZtDs/ab0nueIph--


