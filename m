Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FF1C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4N57-000440-Vc; Wed, 09 Sep 2026 14:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4N56-00043k-Ba
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4N54-0005PG-FT
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788978692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Je4w4HgWHtpE759ZIJUuOiCrBwEXmLtRy5qPZ7y1tQ=;
 b=ey5JD4r3uE8/k/tbXrMJPRvg37y4FUalVq387HPFMf/9o7Z7OrR1xcRQ9eLqIcAHgCpofH
 qGpQDkVSVZOOmjdnXk2JmYRlQeMydeTI6803ETsEkIErka6yVZoY9sPxSs9Dc5D/XQS/wE
 iNKt0VhIjbn6SV9+HWuumOGNpmOOCog=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-npXW5u7xM6mGXnHFvh3QPw-1; Wed,
 09 Sep 2026 14:31:30 -0400
X-MC-Unique: npXW5u7xM6mGXnHFvh3QPw-1
X-Mimecast-MFC-AGG-ID: npXW5u7xM6mGXnHFvh3QPw_1788978689
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13BA0180075B; Wed,  9 Sep 2026 18:31:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5297818004D4; Wed,  9 Sep 2026 18:31:28 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:31:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 05/12] virtio-blk: check the write granularity of
 writes to sequential zones
Message-ID: <20260909183127.GD20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-6-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H2Tq8IBtQ19dRlXc"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-6-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--H2Tq8IBtQ19dRlXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:40PM +0200, Niklas Cassel wrote:
> All VIRTIO_BLK_T_OUT requests issued to sequential zones and all
> VIRTIO_BLK_T_ZONE_APPEND requests must have an offset and a data size
> that are multiples of the write granularity reported by the device
> (virtio 1.4, 5.2.6.1), and a violation is reported as
> VIRTIO_BLK_S_ZONE_UNALIGNED_WP (virtio 1.4, 5.2.6).
>=20
> Neither request type was fully checked. Zone appends validated only the
> offset, while writes were not checked at all.
>=20
> Check the size of the appended data, and both the offset and the size of
> a write, against blkconf_zone_write_granularity(), so that every request =
the
> device accepts is one that the guest driver was told is valid. Writes to
> conventional zones keep no alignment constraint beyond the logical block
> size. The write path performs the check after virtio_blk_sect_range_ok()
> so that the zone index derived from the guest supplied sector is known to
> be in range.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/virtio-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H2Tq8IBtQ19dRlXc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhpf8ACgkQnKSrs4Gr
c8i4rQgArUpH7j6DCXp7R3G7QgcZ6YUBjI3Cqaoh+Ux9/2NEeOnwo6jRlg3yf7VX
gN67cEM8HjPR/n5iGFpDl+nhf8jsTheQ+ssfjq5J20PaNC/J7msR46agKAvYUwq3
fO4N8VphMwMZqqcO3gg3w3p4JwqhkCH4MEsZMh3IC0MUV3YoaWjZo6/wyhKHmzUS
//Bwwce4frsb1j2vEjfhaEwhSPcRo8nbC/QJJzdo5D/4tzZjfdXyT+FTbrwVNx3k
HEaarK8kyvwEpRXusovHAeQA0CPoMJkRRVM3nk222gogHRkDpOSuj+eX6HDxx4EK
BzB+eAAMUrin9aYQ6Q0JDip3R6Aw1A==
=RHay
-----END PGP SIGNATURE-----

--H2Tq8IBtQ19dRlXc--


