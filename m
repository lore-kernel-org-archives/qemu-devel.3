Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F5FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXaq-00056Y-FN; Thu, 01 May 2025 13:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uAXan-00054C-IP
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uAXal-0003Ga-R9
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746120058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xX/JiV5ZiaxXa8afLFouH+B5J8JazaLmEUfNHqYmtCQ=;
 b=GBUmdttDTrP8Bd6rcCbFxBzTBlAfr0AB78ZEsjgPXKjq3t2+Afgs92xEv6Wb70TsXqsVAa
 buNLjsm8hca5F24HqpbH6aShcHTSxzEw6vDCZmOQnSmnxrKBJ1Qhc3f7QOdJg5MMouqYXr
 lMKGnM7Ju4r0mF4fBChnjXAttAroEU4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-52DgaLfSOKSQBiVKM5wcMg-1; Thu,
 01 May 2025 13:20:55 -0400
X-MC-Unique: 52DgaLfSOKSQBiVKM5wcMg-1
X-Mimecast-MFC-AGG-ID: 52DgaLfSOKSQBiVKM5wcMg_1746120054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CE1F195608C; Thu,  1 May 2025 17:20:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF22019560A3; Thu,  1 May 2025 17:20:51 +0000 (UTC)
Date: Thu, 1 May 2025 13:20:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 03/11] block: Let bdrv_co_is_zero_fast consolidate
 adjacent extents
Message-ID: <20250501172050.GD99177@fedora>
References: <20250425005439.2252467-13-eblake@redhat.com>
 <20250425005439.2252467-16-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7kP80jPhCPqWlwMS"
Content-Disposition: inline
In-Reply-To: <20250425005439.2252467-16-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--7kP80jPhCPqWlwMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 07:52:03PM -0500, Eric Blake wrote:
> Some BDS drivers have a cap on how much block status they can supply
> in one query (for example, NBD talking to an older server cannot
> inspect more than 4G per query; and qcow2 tends to cap its answers
> rather than cross a cluster boundary of an L1 table).  Although the
> existing callers of bdrv_co_is_zero_fast are not passing in that large
> of a 'bytes' parameter, an upcoming caller wants to query the entire
> image at once, and will thus benefit from being able to treat adjacent
> zero regions in a coalesced manner, rather than claiming the region is
> non-zero merely because pnum was truncated and didn't match the
> incoming bytes.
>=20
> While refactoring this into a loop, note that there is no need to
> assign pnum prior to calling bdrv_co_common_block_status_above() (it
> is guaranteed to be assigned deeper in the callstack).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v3: also tweak function comment
> ---
>  block/io.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7kP80jPhCPqWlwMS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgTrXIACgkQnKSrs4Gr
c8hh3wgAuf0N4eGwZqA5O1aNVDN04Gp16u3Vnh9hqOpUjD1nG4kSV5aoS78nf6tR
2Jk746FbffeYvHI0ccRqGLaOgn0dt7IU0eo17t6gHqUh0UEXL/LWhNqLdGwOTVqy
16j5lGfyBgEpTHxCdBqepgCgYh+wIQjbn9kLHoJui/xc9jzfDe5dv6Ltw7BrlBMc
XDnRL/sWPmyQAnmnjbrFzf4Ctem0/a1f6DhJEI4++f1mfPGyAp3yH/dNAgfYoGTq
wamK6L0M07a5IlfNDlTuiYbkEoHDN+jrH67kgHmxIIxcd3y0xjowX5z/bsTNgKT8
VBK7s4BZ9EGCWsz4qPELrS1F5TSqkA==
=VrzU
-----END PGP SIGNATURE-----

--7kP80jPhCPqWlwMS--


