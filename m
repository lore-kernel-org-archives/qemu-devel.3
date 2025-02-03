Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6613C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1eB-0006lG-Vh; Mon, 03 Feb 2025 13:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1e9-0006km-IE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1e7-000698-Iz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738609089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3D8G70hMku3k5/3/vq3ScIXaJZhc+aMKqv67BUtkfPg=;
 b=Rl7HjNivLIlq/J5YMD4APvlC9vcJh28sQAKq0zGGPJHtWF3I+vcxNtEh+p37xj6K5UyC/y
 Hv8oLOezF+fQJkTYDLjXQ7d4pgRm5xh+D+XJpDtQ0R3QWWHQK9n95XAW9gLquRRRp7gD+G
 QmIeKAc1FZ14MtcdZbqRIWBG3gKQuUI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-qZihngPnMJybsStwnfd05w-1; Mon,
 03 Feb 2025 13:58:08 -0500
X-MC-Unique: qZihngPnMJybsStwnfd05w-1
X-Mimecast-MFC-AGG-ID: qZihngPnMJybsStwnfd05w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517E419560B7; Mon,  3 Feb 2025 18:58:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55239195608E; Mon,  3 Feb 2025 18:58:06 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:58:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/15] block/export: Don't ignore image activation
 error in blk_exp_add()
Message-ID: <20250203185804.GL268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+oS0zVJl6cKfqmmb"
Content-Disposition: inline
In-Reply-To: <20250131095051.49708-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--+oS0zVJl6cKfqmmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 10:50:46AM +0100, Kevin Wolf wrote:
> Currently, block jobs can't handle inactive images correctly. Incoming

Did you mean "block exports" instead of "block jobs"? If it's really
"block jobs", please give an example scenario of the iteraction between
jobs and exports.

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> write requests would run into assertion failures. Make sure that we
> return an error when creating an export can't activate the image.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/export/export.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/export/export.c b/block/export/export.c
> index 79c71ee245..bac42b8608 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -145,7 +145,11 @@ BlockExport *blk_exp_add(BlockExportOptions *export,=
 Error **errp)
>       * ctx was acquired in the caller.
>       */
>      bdrv_graph_rdlock_main_loop();
> -    bdrv_activate(bs, NULL);
> +    ret =3D bdrv_activate(bs, errp);
> +    if (ret < 0) {
> +        bdrv_graph_rdunlock_main_loop();
> +        goto fail;
> +    }
>      bdrv_graph_rdunlock_main_loop();
> =20
>      perm =3D BLK_PERM_CONSISTENT_READ;
> --=20
> 2.48.1
>=20

--+oS0zVJl6cKfqmmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehEbwACgkQnKSrs4Gr
c8iVYQf5ASFz/Z6UKBCJnJBQeqMu8uu9t6UpkHKo16iJk49HUoVs2UpV/RpSo9qv
sPIzNSILtR0aLoS0LPl9mMzYGEHUv1GywpAbMsE9sbg+xwiVaBvswnb49GasUhvC
foRsDE0ggDv+6XVGkIMb69EFmoZKSqVW56vENflAWC/OIi9AzlZIzJ4a1VPRs/j9
8R7M0wzWribiB9KYnOdsILen/Mkg6Jzdr60E6jLuBG9YSYxcpQaxP5+byVtvRCN6
JPBkQvv9imyiWMA90LZnKN9+z5cgxPKQVHde11Xkk/6mFOYk9+Yp6m5PSPdiE0Ct
VT2BLl3mcug63chTOiEV3WFWi2vr8A==
=EZMo
-----END PGP SIGNATURE-----

--+oS0zVJl6cKfqmmb--


