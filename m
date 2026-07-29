Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77191C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp9A6-0007eb-Rg; Wed, 29 Jul 2026 14:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp9A6-0007eL-AK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 14:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp9A4-0007kO-H6
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 14:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785350266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=47zJ32u7MLI0uIopGsi85tZNT1c6fLUTmR2A+yb5+KQ=;
 b=U81R2S9kyZdGfyTLTvQlhg15UudaMGwp8MHmjJb0c8VX9hQOc8gZwwztpGeMaCLw7Qz3At
 /lxFofkaL8c4c09uK4MoaUV9sBA4HG4bc0WKphMVCBp/swA6PI/HyLbQyFftz5mzcbY6WD
 cNrvHqrtXXGpXjmS0UgNjMmZQ2IXpGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-9DswcQQmPZS6Tg9ANb7vnQ-1; Wed,
 29 Jul 2026 14:37:43 -0400
X-MC-Unique: 9DswcQQmPZS6Tg9ANb7vnQ-1
X-Mimecast-MFC-AGG-ID: 9DswcQQmPZS6Tg9ANb7vnQ_1785350262
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E3CE19560AA; Wed, 29 Jul 2026 18:37:41 +0000 (UTC)
Received: from localhost (unknown [10.2.17.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E249A423; Wed, 29 Jul 2026 18:37:40 +0000 (UTC)
Date: Wed, 29 Jul 2026 14:37:39 -0400
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
Message-ID: <20260729183739.GA1409995@fedora>
References: <20260617133658.2022750-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C2JTvgHSINZxYcGM"
Content-Disposition: inline
In-Reply-To: <20260617133658.2022750-1-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--C2JTvgHSINZxYcGM
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

No comments from Kevin and this is a zoned storage fix, so I'm picking
it up.

QEMU is currently frozen for the 11.1 release and only serious
regressions, security fixes, or build fixes should go into the next
release candidate (-rc3).

I'm applying this to my block-next tree for the next release (11.2). It
will hit the master branch in about 2 weeks when 11.1 has been released.

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--C2JTvgHSINZxYcGM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpqSHMACgkQnKSrs4Gr
c8hIiQf/YCccaw55JIF27xg8G5HG180yO21g7/ZEX4BzrT66XlsBtXc2ZpUas9bs
R0Vz5kNTZBK4YTDDgBLGt/RpNlVJ4Kp3bpd2mXesy1ApdQYaoa3zZi52w0aLOovZ
BqblNFTGNDhuNH8PLlRXFmTJA1fQdGQBGiVhULi14D59QExulPuCjV4zc4hnQRus
Bdk4fkB+ayt9v52t0HTwAdsXKzBTHHDL4DcV8BlUGhKC0LwiNlHvcB6FJj2zg0F+
trrYSxsId3fXX3oogqMcQVkf/dUYhbrP7Sgo3kmio/aRCWm9oUldPx8T7GY7TuTV
U0wh2+bdyVYsi+EwyRdKZKFHXytTFw==
=0NUM
-----END PGP SIGNATURE-----

--C2JTvgHSINZxYcGM--


