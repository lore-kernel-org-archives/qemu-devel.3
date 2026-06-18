Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58636CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEEU-0005QY-IZ; Thu, 18 Jun 2026 11:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waEEP-0005OX-LG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waEEN-0002u0-Oo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781794833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oi41gOxQCV/Bs2v6VNgLBVFj2ZFYAyA0BXhpsaW4evk=;
 b=R2v3vSZvM4oD7S+sq4BGZO0/XSuSn/mDNRakULy5d6Ij166nxVP2ntC1IuWwUfAZz0RSXp
 7Syj/8EAb394ETjapxthClTMShyotaehXmqFzbcnvauI2wsLurE7uUUKKfLPy4Ugd4tv9S
 F3HwI8a8QhoCUEYEva/rUmJX9QIvgLs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-LEsVmTaMOnOwnyuNwfM5vg-1; Thu,
 18 Jun 2026 11:00:29 -0400
X-MC-Unique: LEsVmTaMOnOwnyuNwfM5vg-1
X-Mimecast-MFC-AGG-ID: LEsVmTaMOnOwnyuNwfM5vg_1781794827
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 510D4180065A; Thu, 18 Jun 2026 15:00:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AA8236916; Thu, 18 Jun 2026 15:00:26 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:00:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] file-posix: fix cache.direct=on check for zoned block
 devices
Message-ID: <20260618150025.GC720244@fedora>
References: <20260617133658.2022750-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rVxGWJnIINmhXS7t"
Content-Disposition: inline
In-Reply-To: <20260617133658.2022750-1-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--rVxGWJnIINmhXS7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 03:36:58PM +0200, Niklas Cassel wrote:
> For zoned block devices with SWR zones, the order of the writes must be
> maintained to avoid write not at write pointer errors.
> Thus, cache.direct=3Don must be used to bypass the page cache, since the
> page cache uses write-back caching, where the physical order of the writes
> is not guaranteed.
>=20
> There is already a check for cache.direct=3Don in raw_open_common(),
> however, this check is done before raw_refresh_zoned_limits() has been
> called (which initializes bs->bl.zoned), so it is currently dead code.
>=20
> Fix this by moving the check to raw_refresh_zoned_limits(), such that the
> check is done after bs->bl.zoned has been initialized.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Fixes: 774c726ceb2a ("block: add zoned BlockDriver check to block layer")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Picked up tags from Damien and Dmitry
> -Modified existing code comment to use plural instead of singular
>=20
>  block/file-posix.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rVxGWJnIINmhXS7t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0CAkACgkQnKSrs4Gr
c8huKwf/fXrNWm8XUeJ/bqiZlXknfejuPvyxe4uJpUiQkNQibr3a82nz6Z1KrQ2D
9rm+DFjaByth5cllDB3p7FquvLqpcJElGs2f6vT5RFBcBD3DV3jY2vPbY6+Ej0zX
/VW+VoyGhFskzzPswZ0mwizoa8hXf7vljw55tuOMAgnTPHB+NL/DdjnFEGLFcMVY
ix9EfA1e90w1y/v+Y4LtSTATt07BlyP/M6yYvnSHfolJEBXSYLkNA1bNNy11a37m
wOjaKNNEXANVH1NQpmZL3FYO1XOEavrYDD401ZG3Ruzmc/HogPi6tgMkhjXqjYI5
WxdJZfXBV8CvLS70nXfAaCT5QUJRxw==
=95y8
-----END PGP SIGNATURE-----

--rVxGWJnIINmhXS7t--


