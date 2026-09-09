Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F21C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NV1-0006MA-Je; Wed, 09 Sep 2026 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NUz-0006LX-B5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NUw-0002SZ-Fe
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788980297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+h6Ok661yopWzfiDvf7T0oMbjn6DDkCTufG/Ue80pTg=;
 b=FvenR6tFJ7oCECYzexg/pG3Y0DGzMZ2Eg4RRXsohZpQzx2QtyyczRotPwcZbXqi/1k2gl1
 N1Nip5cKDD03HvlaCee9nZLKcIqoZrld0wAeWqfu5p5+f/NccrYBdzCvwQzuJQcp3QNlTR
 ne0b65fDHH86g2BVzCLDlxXwDaBqy1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-yFdpM5SOPa2d0f3KrccIUg-1; Wed,
 09 Sep 2026 14:58:13 -0400
X-MC-Unique: yFdpM5SOPa2d0f3KrccIUg-1
X-Mimecast-MFC-AGG-ID: yFdpM5SOPa2d0f3KrccIUg_1788980291
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA519180067A; Wed,  9 Sep 2026 18:58:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE6CE1956087; Wed,  9 Sep 2026 18:58:09 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:58:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/12] block: fix the zone write granularity and the
 zone append limit
Message-ID: <20260909185808.GM20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="28kfotcs42qvoQZp"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-1-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--28kfotcs42qvoQZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:35PM +0200, Niklas Cassel wrote:
> Hello Stefan, Kevin, and everyone else,
>=20
> This series fixes how QEMU reports and enforces the two constraints a zon=
ed
> device places on a write to a sequential zone: the write granularity, and
> the largest zone append it accepts. It also fixes two bugs in the zone
> append emulation in file-posix, one of which a guest can reach.
>=20
> Many of these patches are in preparation for Sam Li's zoned qcow2 series.
> The first two patches in the series are taken directly from there, as they
> are unrelated to qcow2.
>=20
> Patch 3 is preparation with no functional change: deriving the zone that =
an
> offset belongs to was open coded in five places, so it becomes a helper.
>=20
> Patches 4 to 6 concern the write granularity. virtio-blk reported the
> logical block size while the driver enforced the backend value, so on a
> 512e SMR disk a guest could be told that a request was valid and get an
> I/O error for it. Writes to sequential zones were not checked against the
> granularity at all, and zone appends had only their offset checked, not
> their length. Patch 6 then refuses at realize a device whose write
> pointers the configured logical block size cannot address, which needs no
> emulated backend to provoke: write 512 bytes to a zone of a null_blk
> device and attach it with logical_block_size=3D4096.
>=20
> Patches 7 to 10 concern the append limit. The sector invariant moves to
> bdrv_co_zone_append(), since a write pointer is tracked in sectors and
> cannot represent anything finer, and file-posix drops its own check which
> conflated that with the coarser granularity of the medium. file-posix then
> stops reporting zone_append_max_bytes, which bounds REQ_OP_ZONE_APPEND, an
> operation it never issues: it appends with an ordinary pwritev(), so
> max_hw_transfer is the limit that applies. Finally virtio-blk derives what
> it advertises rather than passing BlockLimits.max_append_sectors through,
> which made an unset field mean "zone append unsupported" rather than "no
> limit of its own", and Linux refuses to attach a zoned device that reports
> zero.
>=20
> Patches 11 and 12 fix the write pointer that raw_co_prw() substitutes for
> the offset of an append. An offset that is never bounded against the
> device derives an out of range zone index and reads past the write pointer
> array, which qemu-io can reach. An append to a full zone uses a pointer
> recorded at the end of the zone, so the data is written into the next zone
> and success is returned; a guest can reach that one, because nothing in
> virtio-blk checks whether a zone is full.
>=20
>=20
> Changes since v3:
> -Picked up tags from Damien.
> -Replaced ctz64() with a zone_size_bits in struct BlockLimits.

Hi Niklas,
Thank you for your patience. QEMU block layer code reviews are slow at
the moment and it took me a while to get to your series.

Overall it looks good. The only concern I have is exposing BlockBackend
BlockLimits fields directly in the emulated device. This breaks live
migration because guest drivers are not prepared for limits to change
suddenly at runtime. More about this in my replies.

Thanks,
Stefan

>=20
>=20
> Niklas Cassel (10):
>   block: add a helper for the index of the zone an offset falls in
>   virtio-blk: report the effective zone write granularity
>   virtio-blk: check the write granularity of writes to sequential zones
>   hw/block: reject a zoned device whose write pointers are unaddressable
>   block: reject zone appends that are not a multiple of the sector size
>   file-posix: remove the zone append write granularity check
>   file-posix: base the zone append limit on the transfer limit
>   virtio-blk: derive the maximum zone append size
>   file-posix: reject a zone append past the device capacity
>   file-posix: reject a zone append to a full or conventional zone
>=20
> Sam Li (2):
>   block: widen BlockLimits.zone_size to uint64_t
>   virtio-blk: do not merge requests across a zone boundary
>=20
>  block/block-backend.c             |  11 +++
>  block/file-posix.c                |  71 +++++++++++++-------
>  block/io.c                        |  31 +++++++++
>  hw/block/block.c                  |  53 +++++++++++++++
>  hw/block/virtio-blk.c             | 108 +++++++++++++++++++++++++-----
>  include/block/block-io.h          |   8 +++
>  include/block/block_int-common.h  |   9 ++-
>  include/hw/block/block.h          |   9 +++
>  include/system/block-backend-io.h |   1 +
>  9 files changed, 260 insertions(+), 41 deletions(-)
>=20
> --=20
> 2.55.0
>=20

--28kfotcs42qvoQZp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhrEAACgkQnKSrs4Gr
c8htnAf+KV3gCV92U2wiHoWUOmg4apaImeTgKWlbBRALUiH6FPgpKn63Q30Zjdmr
n/8fqZWdgIyZpwuXcuVIO5szOU6QPijRJn9NjMkvRx+SJNIilx16FlgceejWslFp
2iwaHBDOfklndiCJGkz6I3JAcyNy3QhGI6oF6a0BksNwa+I0m0uoAzWHXiEhSPDM
I3UznDCMrr7gXta8dj0RoBGNY+ZIifxwhLOP6RYQHn0ewUpuReTfqVog6ld/HQKL
FLbd/tsjdxm2keIcU0I6kcViChYVnvnWFMUIG4EgoQwZfAJnHOv/EO+8bcvOQ6a8
DrnjWfBqDFstNJ98/Qi/bYLeb7rrww==
=e69V
-----END PGP SIGNATURE-----

--28kfotcs42qvoQZp--


