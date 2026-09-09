Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADB1C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MgJ-0007n0-N3; Wed, 09 Sep 2026 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4MgF-0007m3-NV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4MgE-0006aW-9N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788977153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZXx7RU1amE74ftyTtFUY3ZmSnOEuY0gLP4Vk7YXpwg=;
 b=IPt66WM1d1463hjydPOsCK9DwFJaKpKYSaDH+mh59lj8//lt3qWemDM6k+O2a4UMj8DXuP
 L2SjUQrpK8BTbZXPKoLQYMWag2ayNncBv6md0ygsBLVFKxsXoOTpQ27Rv2Ydt+4nMsYRJL
 yiOttjqhNcQ3jwPo/HymULl1j1LzbR8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-ux7Lm9K2Nc6KtK1Mtbb9Tg-1; Wed,
 09 Sep 2026 14:05:50 -0400
X-MC-Unique: ux7Lm9K2Nc6KtK1Mtbb9Tg-1
X-Mimecast-MFC-AGG-ID: ux7Lm9K2Nc6KtK1Mtbb9Tg_1788977149
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 916231955F6E; Wed,  9 Sep 2026 18:05:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C236F426; Wed,  9 Sep 2026 18:05:47 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:05:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 03/12] block: add a helper for the index of the zone
 an offset falls in
Message-ID: <20260909180546.GB20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-4-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sRDEFTl/VL0g9A/e"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-4-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

--sRDEFTl/VL0g9A/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:38PM +0200, Niklas Cassel wrote:
> Deriving the zone that an offset belongs to is open coded in five places,
> in two files, as a division of the offset by BlockLimits.zone_size.
>=20
> The zone size of a zoned device is always a power of two. Linux requires
> that of every zoned device it accepts, in blk_revalidate_disk_zones() and
> in each of the drivers that report one, and qcow2 rejects an image whose
> header says otherwise. So the division is a shift, and the shift is worth
> deriving once rather than at every use: record it in BlockLimits as
> zone_size_bits, next to the size it comes from, and assert the property
> that it relies on where it is computed.
>=20
> Add bdrv_zone_index() and use it. No functional change; the count of zones
> that a management operation spans stays a division, since it is a length
> rather than an offset.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c               |  8 ++++----
>  block/io.c                       | 12 ++++++++++++
>  hw/block/virtio-blk.c            |  2 +-
>  include/block/block-io.h         |  2 ++
>  include/block/block_int-common.h |  7 +++++++
>  5 files changed, 26 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sRDEFTl/VL0g9A/e
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhn/oACgkQnKSrs4Gr
c8itzQgAiEHQUBWPTs3L6Hxw1074CJGuchtsWMC/d2Icrdd41OIN0xIBdVOaq16v
cCYtNJJBZs2UmFfMdmwhaGAhNmJ8jLVwX916DOXPfw3sQfxpGUTQzVXS+dZMnEZQ
nKiocl+cI4U/ta7jtuLusxKKa1aewOljwWRCba9SQuc8HeVpMKjEo3gRmW/7kIns
SIgh3yV9O3tdeCiIVx8iRAM26VuWO99/klCPVjE/RdSmlrQesO0sQEBlcF/I+m+X
RfxjY8X6ZZeBXt7PQPRtduB+Mjo/G4jQdVOaT+OYQ4rQ1xOqhDIbmNbN5OzbYaog
OTMBMNjaPMnKCukQaSfOORqseQKI+w==
=vfcE
-----END PGP SIGNATURE-----

--sRDEFTl/VL0g9A/e--


