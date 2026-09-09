Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7F4C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NRW-0005Ir-Ay; Wed, 09 Sep 2026 14:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NRV-0005IY-Ii
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NRT-0001bT-UF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788980083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VJrNNo24d45T4L5FIsCb0KafQVMqr5Vsb93Gkb/fh+k=;
 b=gsUMZxEeogrFPngqkgImGYN7rsfBkAn8f22NkRY7JhHpO83MPvqWrFN1rTlqPsRDcXslKA
 fyVC0NF1yT/48nl5l72Fvk0sL/BPjYDORtMpxz25aU4bgjBFHpY0WaZpzG340clBZ0MKgh
 g/wab2O0bTGt1rM9hoOxODfHiGw9oZc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-t3HhgyLnP0q3SEMB1P1-3w-1; Wed,
 09 Sep 2026 14:54:40 -0400
X-MC-Unique: t3HhgyLnP0q3SEMB1P1-3w-1
X-Mimecast-MFC-AGG-ID: t3HhgyLnP0q3SEMB1P1-3w_1788980078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 657D61955F6E; Wed,  9 Sep 2026 18:54:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C643830001A2; Wed,  9 Sep 2026 18:54:37 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:54:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 12/12] file-posix: reject a zone append to a full or
 conventional zone
Message-ID: <20260909185436.GL20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-13-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7YroyJbBt6usBi+i"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-13-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

--7YroyJbBt6usBi+i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:47PM +0200, Niklas Cassel wrote:
> raw_co_prw() replaces the offset of a zone append with the write pointer
> of the addressed zone, which assumes that the stored value names a
> position inside that zone. It does not in two cases.
>=20
> A full zone has its write pointer recorded at the end of the zone, since
> get_zones_wp() stores start + len for BLK_ZONE_COND_FULL. That is the
> first sector of the following zone, so the append is submitted there. The
> kernel accepts it whenever that zone is empty, because it is a legal
> write at its write pointer, and the completion path advances the wrong
> zone because it recomputes the zone index from the replaced offset. The
> data is written to a zone that was never addressed and success is
> returned:
>=20
>   zone 2 finished, then a 4 KiB append to zone 2:
>   After zap done, the append sector is 0x180000     <- zone 3
>   zone 2: wptr 0x180000, zcond:14 (full)
>   zone 3: wptr 0x180008                             <- advanced
>=20
> A conventional zone has no write pointer at all, and its array entry
> carries only the type marker in the top bit, so the offset becomes
> negative and the write fails with EINVAL. That is harmless but it reports
> nothing about the actual mistake.
>=20
> Reject both while the write pointer lock is held, since the state has to
> be read and acted on atomically. check_zoned_request() in virtio-blk
> refuses an append to a conventional zone, so that case needs a caller
> that goes to the driver directly, but nothing there examines whether a
> zone is full, so a guest can reach the misdirected write.
>=20
> Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned device=
s")
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c       | 27 +++++++++++++++++++++++++--
>  block/io.c               |  9 +++++++++
>  include/block/block-io.h |  6 ++++++
>  3 files changed, 40 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7YroyJbBt6usBi+i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhq2wACgkQnKSrs4Gr
c8inhgf/YzdXR5dm3lbf+FWyyIi9AjYwDn1D5CW92FDtzXegm+m050P8TKEi+rsy
nsFXk8B3IDP976k41wBphiEogMyliSvjUdr4D5/7GkeTMF01DJZZJs9oQhccgjey
2/EBZsr1sPu8O+ICeKVHWiESZFq1MHuZNovMqYStDY+FZXAYlgqUP+AeI06R2ofK
O0OmfyDGlWJQc/HdOQL+4ZGPih0H+jWkLylqH7jeituaKQoA3QxebcELqWEPVv4N
EW1GwxPxkBS1u802YwYuXGvznUgz1iE+BWaLzDcjIUh6hPGx5nIEloVR1FCZi/B8
wTBtY3VW6VkkbbBk9SitE5Vskxg06g==
=qPcf
-----END PGP SIGNATURE-----

--7YroyJbBt6usBi+i--


