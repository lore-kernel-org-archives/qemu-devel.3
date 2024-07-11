Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FBBC3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpka-0008RL-I6; Thu, 11 Jul 2024 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpkZ-0008On-JY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpkX-0003px-TE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720688760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NQDM/oX5cCVtxdzbtNPxpQqT15i9aZfcPEVtS1QDGeg=;
 b=M54cJo+6bd+1obXY0+8WtcAfB9WG/rlashe6XCNeGCSdqRqVDU1OHYkb/MkdP+7Cuw+ClU
 U/PdcO7WH+WdPmEmgpGoKX5YkcApI7KtbyzF1r/Z9VZmKFmrYIt8GTA8jqurkzIilkXQDJ
 H6az5tgCCl5EpyythC/UGW+2/wDrURE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-3tD3yiBEOhKrEmMU4O6a_Q-1; Thu,
 11 Jul 2024 05:05:56 -0400
X-MC-Unique: 3tD3yiBEOhKrEmMU4O6a_Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2F1F1935D0C; Thu, 11 Jul 2024 09:05:54 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 017F23000182; Thu, 11 Jul 2024 09:05:53 +0000 (UTC)
Date: Thu, 11 Jul 2024 11:05:52 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 2/2] Consider discard option when writing zeros
Message-ID: <20240711090552.GJ563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628202058.1964986-1-nsoffer@redhat.com>
 <20240628202058.1964986-3-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y9lgrBnnJ8bRfjBF"
Content-Disposition: inline
In-Reply-To: <20240628202058.1964986-3-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Y9lgrBnnJ8bRfjBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:20:58PM +0300, Nir Soffer wrote:
> When opening an image with discard=3Doff, we punch hole in the image when
> writing zeroes, making the image sparse. This breaks users that want to
> ensure that writes cannot fail with ENOSPACE by using fully allocated
> images[1].
>=20
> bdrv_co_pwrite_zeroes() correctly disables BDRV_REQ_MAY_UNMAP if we
> opened the child without discard=3Dunmap or discard=3Don. But we don't go
> through this function when accessing the top node. Move the check down
> to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.
>=20
> This change implements the documented behavior, punching holes only when
> opening the image with discard=3Don or discard=3Dunmap. This may not be t=
he
> best default but can improve it later.
>=20
> The test depends on a file system supporting discard, deallocating the
> entire file when punching hole with the length of the entire file.
> Tested with xfs, ext4, and tmpfs.
>=20
> [1] https://lists.nongnu.org/archive/html/qemu-discuss/2024-06/msg00003.h=
tml
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/io.c                                    |   9 +-
>  tests/qemu-iotests/tests/write-zeroes-unmap   | 127 ++++++++++++++++++
>  .../qemu-iotests/tests/write-zeroes-unmap.out |  81 +++++++++++
>  3 files changed, 213 insertions(+), 4 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/write-zeroes-unmap
>  create mode 100644 tests/qemu-iotests/tests/write-zeroes-unmap.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Y9lgrBnnJ8bRfjBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPoHAACgkQnKSrs4Gr
c8gyQQf+NUWNR45Jasi+YEvrvLK2UAwQwVM5lobxUDnIRCaeWpNpTyBVF+GBCbcb
aOGO9bsC8n15QssF3uWr0S70E7sywxHL6+lxFmZ9QgOm3+uHOR+TaG1ur6WkHDqX
j2Cp3WGsYbOWvyL4G3fjemfRI+hqv6RhgkJsW4KAihZjLBn1LBbzx4M7zDWMcUHI
jbow+Ep3djtJQ8x6SywmZhnxabqwni2oXZehxb+tAUwdmW5fPrUM6OPcCb0d091x
ekZdtoRPXy2fTl0GBG4BpG9wUFIvo4jRasJzRnEOf/7ixarcNl+pRNv6HjTX+GNz
F0195Smg15ah1/Xp86l9uiicyLHLnA==
=c5Iy
-----END PGP SIGNATURE-----

--Y9lgrBnnJ8bRfjBF--


