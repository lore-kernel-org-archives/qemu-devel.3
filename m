Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A868CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEYe-00032c-Qv; Thu, 18 Jun 2026 11:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waEYd-00031r-AV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waEYY-0001Ub-Rs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cy17Yxl4YDGzc+W57KAFuF0RIMb1MKu+/rSttotRPbc=;
 b=V5puFb2UyKaiJ0FBxLrKHS0qGfoBfrDdOHJhsJPxF7xOx2f3RO8SRiq7qzh0ylnoX8iUW3
 8iIoJaHuMyIwqkux+JRjnPGQoUxQFHC3X3vHebxSrxywSG6IVQxbHSu+4IMiFaWmOd8AL2
 64Wd11hLXig2HzMfG/Zdbn/2ti+IhFA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-YLofrco5OQGkPeBFLHxmuw-1; Thu,
 18 Jun 2026 11:21:02 -0400
X-MC-Unique: YLofrco5OQGkPeBFLHxmuw-1
X-Mimecast-MFC-AGG-ID: YLofrco5OQGkPeBFLHxmuw_1781796061
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74AAD1802675; Thu, 18 Jun 2026 15:21:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A91E1956044; Thu, 18 Jun 2026 15:21:00 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:20:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-blk: store the zone-append sector as little-endian
Message-ID: <20260618152059.GF720244@fedora>
References: <20260617151739.4072252-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QrL5hPO6c2Qi01Dw"
Content-Disposition: inline
In-Reply-To: <20260617151739.4072252-1-michael.bommarito@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--QrL5hPO6c2Qi01Dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:17:39AM -0400, Michael Bommarito wrote:
> The zone-append completion path writes the append sector back to the
> guest with virtio_stq_p(), the VIRTIO_F_VERSION_1-aware accessor,
> while the rest of the zoned reply path (the zone report descriptors
> and the report header) stores its fields with cpu_to_le64(). The
> zoned feature is only defined for VIRTIO 1.x devices and the virtio
> specification defines all of its fields as little-endian, so store the
> append sector with stq_le_p() too, for a single spec-matching
> convention across the zoned path.
>=20
> This is not a functional change for a VIRTIO 1.x device, where
> virtio_stq_p() already stores little-endian; it only removes the mixed
> convention within the zoned reply path.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Testing: builds (qemu-system-x86_64) and the qos-test virtio-blk cases
> (basic, indirect, config, resize, msix, idx, nxvirtq, hotplug) pass
> against the patched binary. No functional change on a
> VIRTIO_F_VERSION_1 device, where virtio_stq_p() already stores
> little-endian.
>=20
>  hw/block/virtio-blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QrL5hPO6c2Qi01Dw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0DNsACgkQnKSrs4Gr
c8gMowf9Ei4B8xznc1EllQfdC+H15Ip88n+HrapuH1H571hvNQ7rmiOoRhWTwxtl
KK+xNxJV4DyD4wOea1wPqWnfKwi1i4fPN/YZRR1jkQ5htLikTOE5mEi3yeCb8bhi
bmWTjkWtkrUCKYfIDi9NO1EEkpDKW2ysfpiXtja8KyMGIvEHtih2iaVcgGSddoId
OyzMp2EvlkHex450oXK7xjpzICHBl+1tmGD7A8FKemcXj6l7cOd4dOv5NRfWMWJM
rwriLoEhhOJs2SM4Spm7IY5YWSi8rR5Eyi3xX/WsNO7REDltX41h2jB0qsG2i9zK
kXjnUv4h/YCYySYtZqaf9bx7u3mxWg==
=C000
-----END PGP SIGNATURE-----

--QrL5hPO6c2Qi01Dw--


