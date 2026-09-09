Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBAEC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NB8-0005hd-NP; Wed, 09 Sep 2026 14:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NB6-0005go-Hl
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NB4-0006o0-Ka
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788979065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9A3kljZKbAJVVSHuP0SY1V6egf60EnbMBEcag7VsMHY=;
 b=FqkPlUwPTMV03AxRhxQE1J/OaMDeWy8zQFPzBGnQbWANGugPUPGjqbI0ZTgDY1Mq/LVjR4
 0pvG4RHvpsVTZ9y+iJcFNydtlxeIRmC516LV1w/oYUTbyDo5Ig57H26j4lslx4jhwBTGon
 EjuvV9Bm8DrzZ7KKgBryUrt85Gl+F5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-RIOC-G9rNN-bcd2bmsZIhg-1; Wed,
 09 Sep 2026 14:37:41 -0400
X-MC-Unique: RIOC-G9rNN-bcd2bmsZIhg-1
X-Mimecast-MFC-AGG-ID: RIOC-G9rNN-bcd2bmsZIhg_1788979058
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D1D61954B19; Wed,  9 Sep 2026 18:37:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 854D218004D4; Wed,  9 Sep 2026 18:37:37 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:37:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/12] block: reject zone appends that are not a
 multiple of the sector size
Message-ID: <20260909183736.GF20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-8-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p0rRWq7IGw9g1sIY"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-8-cassel@kernel.org>
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

--p0rRWq7IGw9g1sIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:42PM +0200, Niklas Cassel wrote:
> Zone write pointers are tracked and reported in units of
> BDRV_SECTOR_SIZE, so an append whose data size is not a multiple of it
> would leave a write pointer that cannot be represented, neither in a
> BlockZoneDescriptor nor in the virtio and NVMe zone reports derived from
> one.
>=20
> Nothing states that invariant. file-posix, the only driver that carries
> out an append itself, does enforce it, but only as a side effect of
> checking each iovec against BlockLimits.write_granularity, which is never
> smaller than the sector size. That conflates two constraints: the sector
> granularity holds for every driver, whereas write_granularity describes a
> coarser requirement of the medium below a driver, and only a driver that
> has such a medium should express it.
>=20
> Check the invariant once in bdrv_co_zone_append(), so that it no longer
> rests on a driver that happens to have a granularity of its own to
> report.
>=20
> This is a lower bound, not the alignment that a guest has to observe. The
> block layer cannot know that one, because it also depends on the logical
> block size the device is configured with, which is a property of the
> frontend. The alignment that applies to a guest is the larger of the two,
> and it is the frontend that reports it, that validates requests against
> it, and that has to refuse a device whose write pointers do not satisfy
> it.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p0rRWq7IGw9g1sIY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhp3AACgkQnKSrs4Gr
c8iEwAgAq3YyUtC2FyTIq2t1+ec7EaspVKkbBt/J55D9CXrXbFSjSTafkzjcUe0h
KAAuktgZJJJp9rvYvc2HeWOFq8vsfl6jfIwfJl/E7VqIJe//+1R/06rV+XT9fcw4
lnyBnsUKZNydNTHB93Cy479Mwh/tJ21P6hOyHl8qn+xfLgIE1QPhdRhqwvoECfXf
ZGtBdQ15Uk+HAVifbQD3rNwa+T3dt6cYNp3jk6D9U2e7ZleZRkWd5NyAeS4IQpoh
7vLv5U4jt7FqeLthnZarbYanI8HaLrZt9XYOZW4CwQ4aFEghTs9/4W5xv5r7hH7x
4T6wXDJdiVKXbEaYWxis0Mvf+XrpvA==
=VtWn
-----END PGP SIGNATURE-----

--p0rRWq7IGw9g1sIY--


