Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D067AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95xc-00078B-8G; Tue, 22 Sep 2026 15:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95xZ-00076H-CZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x95xX-0001ON-Fw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790104511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/8YaSr8vTyFKmvNvJe5VBY7sfwZrl67iVdcSLDiyuY=;
 b=igNPI1l1tKzMnDH2S3NNX2ivmNway+kaT/f9+9vqRNcwAEUL7yWdi4qyh/xTTPv9PoGNWc
 3pz1DAG1+wlEtXHyrJEQ+9kCoCNJTuXGCwE9vRRn7jcmNaV3t2r8fZEuUtilRa2gqRTLaN
 FaTyK/7q/oVefRKXgMKrkKewX1CZZTw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-Nyc_Wbs_OricPZ-SDnJrGQ-1; Tue,
 22 Sep 2026 15:15:05 -0400
X-MC-Unique: Nyc_Wbs_OricPZ-SDnJrGQ-1
X-Mimecast-MFC-AGG-ID: Nyc_Wbs_OricPZ-SDnJrGQ_1790104504
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3FFE192527A; Tue, 22 Sep 2026 19:14:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADB311956095; Tue, 22 Sep 2026 19:14:54 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:14:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 11/15] virtio-blk: add a max-append-sectors property
Message-ID: <20260922191453.GE340123@fedora>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20260921142819.2916043-12-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PWTSId3knXoTKx2Q"
Content-Disposition: inline
In-Reply-To: <20260921142819.2916043-12-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

--PWTSId3knXoTKx2Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 04:28:13PM +0200, Niklas Cassel wrote:
> The maximum zone append size that the device reports to its driver was
> taken from BlockLimits.max_append_sectors, a limit of the host disk that
> the backend happens to sit on. A guest reads it out of the configuration
> space, so it becomes part of what the guest has been told about its
> device, and migrating that guest to a host whose disks report something
> smaller leaves it appending more than the device accepts.
>=20
> Make it a property, as max-discard-sectors and max-write-zeroes-sectors
> already are, so that the value a guest is given is part of the device
> model and does not change under it. Nothing from BlockLimits reaches the
> configuration space any more.
>=20
> Zero is a valid value here, unlike for those two. There is no feature bit
> for zone append, and a maximum of zero is how the specification has a
> device say that it does not support the operation (virtio 1.4, 5.2.5.2).
> It is also what a ZBC or ZAC disk is: such a disk has no zone append
> command at all, and Linux emulates one in its block layer.
>=20
> What is reported is capped by the size of a zone. The specification asks
> for the largest append that can be carried out, and one larger than a
> zone never can be, so the default would otherwise advertise a size that
> the block layer refuses. The cap tells a guest nothing about the host
> that zone_sectors has not already told it.
>=20
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  hw/block/virtio-blk.c          | 67 ++++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-blk.h |  1 +
>  2 files changed, 61 insertions(+), 7 deletions(-)

Before virtio-blk reported bs->bl.max_append_sectors to the guest. Now
the default value is MAX_INT >> BDRV_SECTOR_BITS.

This is a guest-visible change (e.g. when upgrading QEMU versions) and
we normally avoid that. In this case it's a bug that the host value was
exposed in the first place and it is unlikely that anyone is using zoned
storage emulation in a use case that involves migration. Therefore I
think we can allow this change.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PWTSId3knXoTKx2Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqy060ACgkQnKSrs4Gr
c8jtiQf/VGl3gAPvdeHeZSd5/rSgLmGIv/8gSnoKgJFrbS0OOO15nUZwg6sHEH0e
JMvyvoyLfsgp32FMgUC5NSxoUjWuSAfNe+2NhWKXD5X/Iqc8hqBOdq+M11Rf2iu5
n+SGbB6esbeK2prlUJARflB6dHni/Lf038toYzjPpnrl8u/3a2Den97m1c419fbc
gJcnbVUrDmZEQXAfW1tPpTq0LVwVD30Hpwfj3hWvtaWjYkCo1Z1Nlud2jpIDT8Oj
MWCCRSqAgP04vRekgiuS0xfITjCzmvLx3A51GIWBXkosueA6DD7ZmhSUblFwQyoE
2dOkfolfjbp6COZLbT/BuI5+mNWC5A==
=O02M
-----END PGP SIGNATURE-----

--PWTSId3knXoTKx2Q--


