Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C95C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95ev-0001Lj-Fp; Tue, 22 Sep 2026 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95ei-0001K9-V6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95ef-00080O-UA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790103347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Umie0JWj14NlmSGDgMBZ3r1wJElkGN8tC0XZyyve+Ms=;
 b=FB5Si1vM8bRDMY2LZCinvHjX3ku4weLmk3P3sveaOgrmQnQsoYr+KHFKxqDRm9ZdBxMbhR
 lZk1fmynhMCcCe75LfbJTWxUmmVDI5YCNJWLVimP8CJwLCy2Sa0XAw/k1lA4Kg8GglG8wu
 d5hJaW6bgtzmr5V+COzXcJpW2Ws0cic=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-dnzW_g77NAKgEd6rt_xOrQ-1; Tue,
 22 Sep 2026 14:55:44 -0400
X-MC-Unique: dnzW_g77NAKgEd6rt_xOrQ-1
X-Mimecast-MFC-AGG-ID: dnzW_g77NAKgEd6rt_xOrQ_1790103342
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31D5D195422F; Tue, 22 Sep 2026 18:55:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E547C180057F; Tue, 22 Sep 2026 18:55:40 +0000 (UTC)
Date: Tue, 22 Sep 2026 14:55:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 04/15] block: add a helper to check if a zone is
 conventional
Message-ID: <20260922185539.GA340123@fedora>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20260921142819.2916043-5-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w4nkjRT/XvSFQ8MB"
Content-Disposition: inline
In-Reply-To: <20260921142819.2916043-5-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

--w4nkjRT/XvSFQ8MB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 04:28:06PM +0200, Niklas Cassel wrote:
> Whether a zone is conventional is encoded in the most significant bit of
> the write pointer that the block layer keeps for it, so a caller that
> wants to know has to reach into bs->wps->wp[] and apply BDRV_ZT_IS_CONV()
> to the raw value. virtio-blk does that, which means a device model both
> knows how a block driver stores its write pointers and knows what one of
> the bits of a write pointer means.
>=20
> Add an accessor next to bdrv_zone_index() and use it there, so that the
> encoding stays with the code that chose it.
>=20
> Unlike bdrv_zone_is_full(), this does not need the write pointer lock.
> get_zones_wp() only ever sets the bit for a conventional zone and never
> clears it, and a zone does not change type, so the answer cannot become
> stale. The rest of the word does change, on every write, which is what
> the lock is there for.
>=20
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/io.c               | 7 +++++++
>  hw/block/virtio-blk.c    | 2 +-
>  include/block/block-io.h | 6 ++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--w4nkjRT/XvSFQ8MB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqyzysACgkQnKSrs4Gr
c8i0bAf/V9tM2o/UXXIslGlvuXYY93X8etVUmFkBMdHVsJ5/dTJZQ4OLBQrMHxKv
2M80ywkcIgk5gd3OkxYdlD3IiReoYpZMHrLcB+36owgHd3OmviB8Sk+SVpuioIUE
P1qxL//zgj6O1s3OOc6Vz7g1p23sBuK4Wa9sOmWz/ezqeYYH61lxiTVDm9HVxUn7
Eixxo6GITbT2v+u0v/Y846BqtePVscvcLaPyptNCVDvLPEm4rf+4egVU94wxeaUZ
/nLSghKZEEHwtfQgCGKK+jmq14MlHahHOAnkdeH/oi9C6qxIF6MVnMnlfmXvLlYX
VfMV0wZj3w9QpP5lugxL1kI9X0QjXw==
=ZW7I
-----END PGP SIGNATURE-----

--w4nkjRT/XvSFQ8MB--


