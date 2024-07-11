Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E05C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 06:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRmy5-0000Af-6C; Thu, 11 Jul 2024 02:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRmy3-000070-51
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRmy0-0001UX-Km
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720678061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i25z4uZ+/Fxzeoyg1AR24ZrVR05thaAMaiTy51v1bxs=;
 b=I+6EsfDJ1P5t1HhlvgLibATtb0PXSdSXfl+JH5VKpB++GD69iSOgSAef9tlgqP7ykh79VA
 ekpxcvTfbUZJkGHyZD2CI+k2/BcvmmZJlqXvQogtBuT7+1drx6o1ftq7/wWfUE3bW90FYy
 MfhUsg4CUVF7PLNm/hM6fWL2oFgklfA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-WCsjp8_NMiidIeS8tOc5Xw-1; Thu,
 11 Jul 2024 02:07:36 -0400
X-MC-Unique: WCsjp8_NMiidIeS8tOc5Xw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E84D1896ECA; Thu, 11 Jul 2024 06:07:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBF521955E70; Thu, 11 Jul 2024 06:07:32 +0000 (UTC)
Date: Thu, 11 Jul 2024 08:07:31 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] block/graph-lock: Make WITH_GRAPH_RDLOCK_GUARD()
 fully checked
Message-ID: <20240711060731.GB563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240627181245.281403-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qx5sy9nNcWDrrSDy"
Content-Disposition: inline
In-Reply-To: <20240627181245.281403-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Qx5sy9nNcWDrrSDy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 08:12:43PM +0200, Kevin Wolf wrote:
> Newer clang versions allow us to check scoped guards more thoroughly.
> Surprisingly, we only seem to have missed one instance with the old
> incomplete checks.
>=20
> Kevin Wolf (2):
>   block-copy: Fix missing graph lock
>   block/graph-lock: Make WITH_GRAPH_RDLOCK_GUARD() fully checked
>=20
>  include/block/graph-lock.h | 21 ++++++++++++++-------
>  block/block-copy.c         |  4 +++-
>  meson.build                | 14 +++++++++++++-
>  3 files changed, 30 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.45.2
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qx5sy9nNcWDrrSDy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPdqIACgkQnKSrs4Gr
c8h9AQf/c8SYDChfKSfA1nze7UF/n0MxCFGkCNyROh1zScdIBry//3Ni0Mq3Oddc
SrZl4+maubmtBmCd7/ikAWwxqVFSekfVn9clECOSoS5JAfbwWflV1Ldx9bf6gxqJ
5qrVRz5ejV+tYxf1zYdsZNap43kcAHnTakzGBm/H0YHWVk5+sBNK2J46k7BQjZTg
tL9A9A5cB4E9uSzE/2gS8dfvOcnyCf3O3wrDbwpH+3c9yVMX5L4CvYHIODK2mX4U
IeM34U3H/gCv9tZjQPUXBEMfNsts8PcR6z8O+C530vwi7RKs8/ICb+UnkrnREnTU
7tM2yGmmwJXU1lUm2di8MQ/02V1y8A==
=Aa0H
-----END PGP SIGNATURE-----

--Qx5sy9nNcWDrrSDy--


