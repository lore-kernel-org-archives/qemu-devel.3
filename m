Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BA0C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSy0-0002Ba-E3; Thu, 30 Jul 2026 11:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpSxz-0002BB-0u
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpSxw-0005x3-Fq
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785426395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipMtX17ru06OSKuMG+OP6V1yu1tewBPf197411q1u1c=;
 b=Vhe0UiturC8chsKkvZyhIX5ILGD9ZQ3vr8PxaKwaJVOnTKIYnVMuSS9oktxEOHOx/AdAYq
 C457XCNBFILBFNSbwaAkcidoeqn/3qjFWxiTAgP8EJdyMOPZ/gOmMkMCzUL4PUeaGtvzSp
 JzloBmNZuhWSRCY/1W2XtOS8tSWN32g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-7N2UJ5p3O7-U-AxkHV2g5w-1; Thu,
 30 Jul 2026 11:46:31 -0400
X-MC-Unique: 7N2UJ5p3O7-U-AxkHV2g5w-1
X-Mimecast-MFC-AGG-ID: 7N2UJ5p3O7-U-AxkHV2g5w_1785426390
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D87591956096; Thu, 30 Jul 2026 15:46:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A8F530002E9; Thu, 30 Jul 2026 15:46:28 +0000 (UTC)
Date: Thu, 30 Jul 2026 11:46:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/6] hw/[block]: Fix missing accounting
Message-ID: <20260730154627.GD1442692@fedora>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2fQ9thYzZz1dcl30"
Content-Disposition: inline
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--2fQ9thYzZz1dcl30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 05:23:09PM +0200, Hanna Czenczek wrote:
> Hi,
>=20
> There are some places where block accounting should be happening, but is
> not; either because the whole operation is not accounted (like discard
> operations in virtio-blk) or because certain code paths forget to
> finalize existing cookies.
>=20
>=20
> Hanna Czenczek (6):
>   hw/virtio-blk: Account discard operations
>   hw/virtio-blk: Complete zone-append cookies
>   hw/nvme: Fix block accounting in nvme_copy()
>   hw/nvme: Fix block accounting for compare
>   hw/ide: Have ide_dma_cb() complete accounting
>   hw/scsi-disk: Fix accounting for IGNORE, ret > 0
>=20
>  hw/block/virtio-blk.c | 34 +++++++++++----------
>  hw/ide/core.c         |  3 +-
>  hw/nvme/ctrl.c        | 70 +++++++++++++++++++++++++++----------------
>  hw/scsi/scsi-disk.c   |  7 +++++
>  4 files changed, 72 insertions(+), 42 deletions(-)
>=20
> --=20
> 2.55.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2fQ9thYzZz1dcl30
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmprcdMACgkQnKSrs4Gr
c8iZHwf/aEbyrZ2dd61e6DvonITDQJcA5bN+D5dlxwEqOuKpu/f6jPF4XNakXfee
crtLjZRl/qjxsaXNHm10rD0RSflLc7KPdmxMAZiAU+E7rCmJTGjGuc3wGwzq1csx
DFJXi4nNSKIX45Rn0iRGXnQyI5GRawxtckbVZR9kNVSR9vNicIbWIrLNrUNUg7TG
4ZDCm3lJ6QbuzRbfhb3dmuFX1ohphCcM+blGU8h5+tDYLOK2QCq3sj/LnkI73f2H
C36kK2Cu+Pm5Fx0+/u6sttam5CwyWkByScdoJLKHtqiqjol1G+TFzZ2jxY1zI0ai
dxOlFZDAHHIHbqK0b/+nW+2/bxWqEw==
=xqK+
-----END PGP SIGNATURE-----

--2fQ9thYzZz1dcl30--


