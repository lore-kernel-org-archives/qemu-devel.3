Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B89C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NQR-0003yt-CD; Wed, 09 Sep 2026 14:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NQP-0003wy-MG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NQM-0001TR-Nb
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788980013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GjXwlZcsmtinLDeABBU3FtFWni4GQk3aPSHOtHFaFuY=;
 b=UcYqYXapC2tfnod/A8guyi4W/eak6lNYImGe0Lv1qLWwUPNfL6qqHnlbQCsBm84sovbFcU
 LUWXq0cTuxtl9kzMW7+ktNF4+SP9aHH/iz1IVpaaUEATz4dczmOQBh64eGXAEchFCF6kzT
 3hQxDBgCWCC38dxTKY5SEzwlIUAD5xY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-3jarizB7NpCTybgwnPzs7A-1; Wed,
 09 Sep 2026 14:53:30 -0400
X-MC-Unique: 3jarizB7NpCTybgwnPzs7A-1
X-Mimecast-MFC-AGG-ID: 3jarizB7NpCTybgwnPzs7A_1788980009
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AAFF19560B5; Wed,  9 Sep 2026 18:53:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FB2730001A2; Wed,  9 Sep 2026 18:53:28 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:53:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 11/12] file-posix: reject a zone append past the
 device capacity
Message-ID: <20260909185327.GK20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-12-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4Wy8ffYvf7lrKVIZ"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-12-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--4Wy8ffYvf7lrKVIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:46PM +0200, Niklas Cassel wrote:
> raw_co_zone_append() checks that the offset it is given is aligned to the
> zone size, but not that it names a zone of the device. raw_co_prw() then
> derives a zone index from it and reads that entry of the write pointer
> array, so an offset past the end of the device reads past the end of the
> array.
>=20
> bdrv_co_zone_append() does not catch it either: bdrv_check_qiov_request()
> bounds the request against BDRV_MAX_LENGTH, which has nothing to do with
> the size of this device. A guest cannot reach it, because
> check_zoned_request() in virtio-blk rejects an out of range offset first,
> but qemu-io and any other caller of blk_co_zone_append() can:
>=20
>   $ qemu-io --image-opts -n driver=3Dhost_device,filename=3D/dev/nullb0 \
>         -c "zap -p 0x100000000000 0x1000"
>   Segmentation fault
>=20
> On a null_blk device with 1000 zones of 256 MiB, that offset yields zone
> index 65536 and reads 512 KiB beyond an 8000 byte allocation.
>=20
> Reject an offset that lies outside the device. That also bounds the
> zone index that raw_co_prw() derives from it, so its write pointer
> lookup stays inside the array.
>=20
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned device=
s")
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4Wy8ffYvf7lrKVIZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhqycACgkQnKSrs4Gr
c8gSqwf+Mo8RjN/IqRHjMs54ZKy9bpRskIISa7u4QSkkaspBSzjr57TbRCamaL6s
DXFipMfVQoSK3XugPJ/pCjGHFK5SHnnkEZuDRz1tRqmQ5DsvZIrOz1gFxZwPiSYM
7RSGYHMtfO/8DE1q7tVoh5DdLCDiW161F3yxcJUv+ExU6Nam1McoiOv92oN5jHNP
FsyRKa2lenJVbzudY5iEpbXJ4xcSkgkOZaigLwRIHdKHYUugDBfbSV0PuEJPHLVQ
EY7m8IwwopNjeU9RMCgQ+6Er0lEv0V/V6M6IuZ1HjnI3N2/fHyrAngfBDxWS0Ip8
5vZtDXRk1KPV2rHgY1TkybDsXp9Uuw==
=ZTMQ
-----END PGP SIGNATURE-----

--4Wy8ffYvf7lrKVIZ--


