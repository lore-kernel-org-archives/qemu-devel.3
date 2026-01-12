Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4130CF45C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMcZ-0006sw-T7; Mon, 12 Jan 2026 13:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfMcS-0006kG-5k
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfMcQ-0002Dh-HI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768242381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiiVwqPfLBSfXxbQoyZJuIJk1mp3var7XvImw9adjxQ=;
 b=Pa8bQ0HIPF8GbNI+9O38ywBqw8mynlTM47PlS8wzbzouJ2yH4e/ZNAEhlvpDmDkeUy+JCi
 G84HGtiNHF46jWkG0z9f91O4AQfuvP0qhMIiQXv4PYXPBwWsdpSMnfqytcOpEZrs9g8bnm
 BW77ldNLV+4lE0dmzVMi1F6nrNmUCME=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-rNRcQrtrOHOZMhmgLebEMQ-1; Mon,
 12 Jan 2026 13:26:17 -0500
X-MC-Unique: rNRcQrtrOHOZMhmgLebEMQ-1
X-Mimecast-MFC-AGG-ID: rNRcQrtrOHOZMhmgLebEMQ_1768242377
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF619195608E; Mon, 12 Jan 2026 18:26:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43DCB30001A7; Mon, 12 Jan 2026 18:26:16 +0000 (UTC)
Date: Mon, 12 Jan 2026 13:26:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chandan Somani <csomani@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Subject: Re: [PATCH v2 0/5] qdev release function cleanups + unit test
Message-ID: <20260112182615.GG462084@fedora>
References: <20260108230311.584141-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NH0yQi+AA0QN2zlM"
Content-Disposition: inline
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--NH0yQi+AA0QN2zlM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 03:03:06PM -0800, Chandan Somani wrote:
> Hello,
>   This was originally a single patch to make the property array release
> function free the property array instead of having the users free it
> in their exit functions. This fixes leaks and reduces code overhead.
> After review, Marc-Andr=E9 asked to include some work he did on
> this earlier
> (https://patchew.org/QEMU/20250429140306.190384-1-marcandre.lureau@redhat=
=2Ecom/).
> I have included his patches that added unit testing and made some
> release functions idempotent.
>=20
> Chandan Somani (1):
>   qdev: Free property array on release
>=20
> Marc-Andr=E9 Lureau (4):
>   qdev: make release_string() idempotent
>   qdev: make release_drive() idempotent
>   qdev: make release_tpm() idempotent
>   tests: add /qdev/free-properties test
>=20
>  backends/tpm/tpm_util.c           |  1 +
>  block/accounting.c                |  1 -
>  hw/core/qdev-properties-system.c  |  1 +
>  hw/core/qdev-properties.c         | 24 ++++----
>  hw/input/stellaris_gamepad.c      |  8 ---
>  hw/intc/arm_gicv3_common.c        |  8 ---
>  hw/intc/rx_icu.c                  |  8 ---
>  hw/misc/arm_sysctl.c              |  2 -
>  hw/misc/mps2-scc.c                |  8 ---
>  hw/net/rocker/rocker.c            |  1 -
>  hw/nvram/xlnx-efuse.c             |  8 ---
>  hw/nvram/xlnx-versal-efuse-ctrl.c |  8 ---
>  hw/virtio/virtio-iommu-pci.c      |  8 ---
>  tests/unit/meson.build            |  1 +
>  tests/unit/test-qdev.c            | 96 +++++++++++++++++++++++++++++++
>  15 files changed, 111 insertions(+), 72 deletions(-)
>  create mode 100644 tests/unit/test-qdev.c
>=20
> --=20
> 2.51.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NH0yQi+AA0QN2zlM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmllPMcACgkQnKSrs4Gr
c8h/HAf/YEIRHT7uRfU3scXhnN5nEoZZrdqxY/b99G9m+yX+2Ag3BQM9qds2cy8X
pU5x6ufr81xyM9Krl1uEhuGpcljqUV8+AVauKW/67joH32WQzmA9BBzMXCAgMbJK
3or13KGamEUgc7aByOWxLIopz9Ecop4N3FGMV8dXY17XSkwPB3jqsrPDW0+VxRhQ
KXVQhH8bfoqAwKtm1JQVXzwfBdbUnAx+zZgxRjzibPrsnq+RXSUNdJNYldInHwkq
vUuPpd4O2QFwgfCxSePqMG4n+BT1DDKtTr+JzdypOFcwZRwTEKHSJSy/6fT6Qhcm
vYboST76LiThdbMDxmFB28vGvLxwig==
=clyr
-----END PGP SIGNATURE-----

--NH0yQi+AA0QN2zlM--


