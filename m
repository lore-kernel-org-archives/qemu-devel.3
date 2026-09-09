Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7A9C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NGc-0002D9-HB; Wed, 09 Sep 2026 14:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NGU-0002Ca-7X
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NGR-0007z8-Ur
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788979399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bEqwXERtTnPz8AEnXPhlGtJhAmtZv1Zzr+R2za5hZ9U=;
 b=Q8wbCG4fTPf6Nremw7mrSz4RzCAKsDYXgiFsCMLF001FEMFn8UmMSZX9pduN2V/+yAUSRL
 4vSuJTuSimj1xHrgQ60EFuFcNrbJtBKOz+RqoNv+4esD56cYy8hBcF6HOEim3jSegrJjTS
 rkaPafbHPeNdi3KDs/ewJJWtR9Mwooo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-Xi2pluZEPHOX3qgO-th7Kw-1; Wed,
 09 Sep 2026 14:43:14 -0400
X-MC-Unique: Xi2pluZEPHOX3qgO-th7Kw-1
X-Mimecast-MFC-AGG-ID: Xi2pluZEPHOX3qgO-th7Kw_1788979393
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59AF5195607F; Wed,  9 Sep 2026 18:43:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7978180057E; Wed,  9 Sep 2026 18:43:12 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:43:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/12] file-posix: base the zone append limit on the
 transfer limit
Message-ID: <20260909184311.GI20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-10-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hL9i6hWHbFBsxLJi"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-10-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

--hL9i6hWHbFBsxLJi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:44PM +0200, Niklas Cassel wrote:
> The zone_append_max_bytes queue attribute is the largest
> REQ_OP_ZONE_APPEND that the device accepts, and Linux has no interface
> for issuing one from userspace: include/uapi has no such operation, and
> every submitter of REQ_OP_ZONE_APPEND is in the kernel. Userspace writes
> to a sequential zone with an ordinary write at the write pointer.
>=20
> That is what this driver does. raw_co_zone_append() substitutes the write
> pointer of the zone for the offset and hands the request to raw_co_prw(),
> which reaches handle_aiocb_rw_vector() and issues a plain pwritev(). The
> kernel never sees a zone append, so the attribute describes a limit on an
> operation that is never issued.
>=20
> Nor is it a limit that this driver runs into. The kernel splits a write
> that exceeds the transfer limit rather than refusing it, so a larger
> append succeeds: on a null_blk device whose zone_append_max_bytes is
> 130560, a 16 MiB append completes and advances the write pointer by
> 16 MiB. Reporting the attribute only understates what the driver can do,
> because Linux derives it as a minimum that already includes max_sectors
> and chunk_sectors.
>=20
> Report max_hw_transfer instead, the limit that governs the write the
> driver actually issues. There is no use in telling a guest that it may
> append more than the device carries in one command, and a frontend then
> does not have to reason about how this driver implements an append in
> order to bound the value it advertises.
>=20
> On a null_blk device with max_hw_sectors_kb of 127 and
> zone_append_max_bytes of 130560, virtio-blk reports 255 sectors before
> and after.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hL9i6hWHbFBsxLJi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhqL8ACgkQnKSrs4Gr
c8joNQf/dOhQnxql/P3dHHV5DoYMJAEor0846zL4R48DGagZciG2m9TJCMwq87Am
E6sgBROysTHS7SjHi5aOxPWyiLFlbw3xteMKb0PhBMw2gdfnaruCDDaE1igVD7kI
Sp4m+AmCxddKQ548EQbeYbkDnz+QkiVBddq/vZ4yB2rU3EZTrQUDPiB3zCVlulxp
9nwBMGxbqPWJ53mO7dLwfH0Ypf4RW3ovzsEh7mKjd2Q9/1sct3NwMXifQuxEQ4/p
ncbzSseyzY1fioeNQRsRFun+H2u1dEzF06Dv0e+MSKhJ+2/LcCYzJotgLEm9ZSQI
f6nMUExpRTn3csOmfOtiQ5g6Zbss2A==
=zIG9
-----END PGP SIGNATURE-----

--hL9i6hWHbFBsxLJi--


