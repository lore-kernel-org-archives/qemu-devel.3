Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4E8C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NFQ-0001jU-B6; Wed, 09 Sep 2026 14:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NFP-0001j6-34
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NFN-0007cq-DL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788979331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6kcPiSFYuTQ1xXqU9qCg4dm1mRrzYvbQZ7VXaglGDbw=;
 b=hi3vQrsPl83vYBKa/srjeShrL/P1gkGBzu6dGpbBic08+zDbC8zuoLMgZZRx1UbcMDstO8
 yRTArx3C979/a80K8jtwDcd1XJITWeUrGxrdKzsDolCuF4F4GQR0tQ+SuDMTGA+nzPb7JR
 HRd3EQ+a0e765m/v5OSrclXF0ZCoC98=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-LI_dSUn6Pi6L5AuL30tIuQ-1; Wed,
 09 Sep 2026 14:42:06 -0400
X-MC-Unique: LI_dSUn6Pi6L5AuL30tIuQ-1
X-Mimecast-MFC-AGG-ID: LI_dSUn6Pi6L5AuL30tIuQ_1788979325
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FF94195607F; Wed,  9 Sep 2026 18:42:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 906B9426; Wed,  9 Sep 2026 18:42:04 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:42:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/12] block: reject zone appends that are not a
 multiple of the sector size
Message-ID: <20260909184203.GH20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-8-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vO3KCS3Q9O7LYFUw"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-8-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--vO3KCS3Q9O7LYFUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:42PM +0200, Niklas Cassel wrote:
> diff --git a/block/io.c b/block/io.c
> index cef23ee5bc..64e2f2b046 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3355,6 +3355,16 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverSt=
ate *bs, int64_t *offset,
>          return ret;
>      }
> =20
> +    /*
> +     * Zone write pointers are kept and reported in units of BDRV_SECTOR=
_SIZE,
> +     * so an append that would leave a write pointer at a finer granular=
ity
> +     * cannot be represented. Drivers may impose a coarser granularity o=
f their
> +     * own, see BlockLimits.write_granularity.
> +     */
> +    if (!QEMU_IS_ALIGNED(qiov->size, BDRV_SECTOR_SIZE)) {
> +        return -EINVAL;
> +    }
> +
>      bdrv_inc_in_flight(bs);
>      if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned =3D=3D BLK_Z_N=
ONE) {
>          co.ret =3D -ENOTSUP;

When looking at bdrv_co_zone_append() and surrounding functions, I
noticed that the CoroutineIOCompletion co local variable is not used
except for the co.ret field. The co local could be replaced with "int
ret" to make the function more concise.

If you feel like it, feel free to add a patch that cleans up these
functions.

--vO3KCS3Q9O7LYFUw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhqHsACgkQnKSrs4Gr
c8hbVwgAjBa++pcI43FGg/ef0z2ALobSNhesny+PwHCP0VHHRobyA1rA/jdoVyZY
tkFe4p6PcS97SwEcB1hDlSfmC/Refoe5Sbw1qAgo+5a/Pk6eAwYhXYMQ6NU1PoXc
jRYval0x6EbaPKQu6x4U4tqlinuCyBWfcezJ5wKpARMnlX9K4+hGVKKMgKDwf0TP
fav8TD1LjMlSNGsYRcm0TNiu5JNYNeq7fTkEZ/IEv4E1VvLDW96rxsCrluXvDrzt
Wj0xNToDo7ejzY/bBek1RRfQhkfXmlJdzPjR8dRrCSYvqbxb7Qa9HDejN6gjuwzB
y3yiQCTRB1McBI9COtGcctioVGV27w==
=pA1F
-----END PGP SIGNATURE-----

--vO3KCS3Q9O7LYFUw--


