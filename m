Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05514C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95kX-0002zK-CF; Tue, 22 Sep 2026 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95kF-0002yq-8e
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95kD-00005d-9m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790103692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=25R/+DYYe9NVTz/221RNUqL0O9Z26fVitLzix/o2JNc=;
 b=I06hAOfZgtvRjXViMddmTRzIjXAkDUp7Ja6cBRcCvCU2LDWn9TH3yhCmJkaGAAXyBmk3Ev
 LRQvTVXNyO/Dv4k4DkkP7DMEA7rT8zKoI/Zl2tgxC3aPTUh5qlbINz9pcCvAAn7vrpwULL
 KM8W4/WAIP6t/Odclh4XTiirrC1waXo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-uRD_KmgtPvayLor-LnTeHA-1; Tue,
 22 Sep 2026 15:01:27 -0400
X-MC-Unique: uRD_KmgtPvayLor-LnTeHA-1
X-Mimecast-MFC-AGG-ID: uRD_KmgtPvayLor-LnTeHA_1790103686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAE391956061; Tue, 22 Sep 2026 19:01:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7C981956041; Tue, 22 Sep 2026 19:01:24 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:01:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 07/15] hw/block: reject a zoned device that the block
 sizes cannot address
Message-ID: <20260922190123.GC340123@fedora>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20260921142819.2916043-8-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N3WZIE0VQil76Fud"
Content-Disposition: inline
In-Reply-To: <20260921142819.2916043-8-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

--N3WZIE0VQil76Fud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 04:28:09PM +0200, Niklas Cassel wrote:
> The write granularity that a frontend reports is derived from the logical
> and the physical block size, which are properties of the device model,
> while the granularity that the medium requires and the write pointers
> that it holds belong to the backend. Nothing ties them together, and
> where they disagree a guest is told about a device it cannot use.
>=20
> A backend can require a coarser granularity than the block sizes express.
> A 512e host managed disk has a logical block size of 512 and requires
> writes to a sequential zone to be a multiple of 4096, so attaching it
> with a finer physical block size reports a granularity that the disk will
> not accept, and the guest is given a plain I/O error for a request that
> it was told was valid.
>=20
> The write pointers can disagree in the same way. They outlive any
> particular use of the device, while the block sizes are chosen afresh
> every time it is attached, so a zone written with logical_block_size=3D512
> leaves a write pointer that logical_block_size=3D4096 cannot address. A
> zone report expresses it in 512 byte sectors, so the guest is told about
> a position that does not fall on a logical block boundary, which it can
> neither read nor write, and the zone can then only be recovered by
> resetting it. The reverse is harmless: a pointer laid down with a larger
> logical block size is still a multiple of a smaller one.
>=20
> Check both at realize time, along with the zone size and the zone
> capacity, and refuse to start otherwise. The write pointers are already
> held in memory by the driver, so this costs no I/O.
>=20
> The check uses blkconf_zone_write_granularity(), the same value that a
> frontend reports to its guest and validates requests against, so the
> three cannot disagree.
>=20
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/block.c         | 63 ++++++++++++++++++++++++++++++++++++++++
>  hw/block/virtio-blk.c    |  4 +++
>  include/hw/block/block.h |  1 +
>  3 files changed, 68 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--N3WZIE0VQil76Fud
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqy0IMACgkQnKSrs4Gr
c8gEygf/UFVky70vY5U7+W7sZDaQ8Z9750eEJi7o9tz6F5DC8yxGK7WqLlCQQdSF
9wpxPsYZimaFA04odIQmV0NCKi3MUALRe/tadh/JOOM3gQUT2Xu09KPrZ35abtnK
cXw0B0C01sOnT9lcj5REywaQkgdDKyvXwwqrb2NxddZ0Y4NveVvGzmXqj7AyHkRM
KGZYuwACjuvHbkneqD23Q8Cu/eRFWunTWE2IB7WT/H3bDriRHhwQC26mxjvt3EJI
PzJli4s5ccaRBw7esGCyM6l/PKJe9eP7pceYsbWvlQfjPrYR+J/c/vdMTF/gpl0K
avohLMVSzYaoXVtrT7/2yCd9p2MoFw==
=J8YB
-----END PGP SIGNATURE-----

--N3WZIE0VQil76Fud--


